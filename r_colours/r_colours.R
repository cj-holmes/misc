library(tidyverse)

# Construct tibble containing base colours and their RGB/HSV values
# Order by HSV so its a bit more useful...
ordered <-
  tibble(colour_names = colours()) %>%
  mutate(rgb = map(colour_names, col2rgb),
         hsv = map(rgb, rgb2hsv), 
         hue = map_dbl(hsv, ~.x[1]),
         sat = map_dbl(hsv, ~.x[2]),
         val = map_dbl(hsv, ~.x[3])) %>%
  arrange(hue, sat, val)

# Assign variables for plot
l <- length(colours())
w <- 10 # number of columns in plot
h <- ceiling(l/w)

# Create plot of colours
as.tibble(expand.grid(y = 1:h, x = 1:w)) %>%
  slice(1:l) %>% 
  mutate(fill_colour = ordered$colour_names,
         # assign a text colour that will be readable on the background colour
         text_colour = map_chr(fill_colour, ~ifelse(mean(col2rgb(.x)) > 127, 
                                                    "black",
                                                    "white"))) %>%
  ggplot(aes(x, y, fill=fill_colour))+
  geom_tile(col=1)+
  geom_text(aes(label=fill_colour, col=text_colour), size=2)+
  scale_fill_identity()+
  scale_colour_identity()+
  theme_void()

# Produce a4 visualisation of colours
ggsave("r_colours/R_colours.png", height = 297, width = 210, units = "mm")
