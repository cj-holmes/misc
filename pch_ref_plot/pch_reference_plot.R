# Plot all shapes and colours
df <- expand.grid(x=1:7, y=4:1)

par(mar=c(4,4,4,4))
plot(df$x, df$y, pch=c(0:25,NA,NA), col=1, bg=24,
     axes=F, cex=2, xlab="", ylab="", xpd=T,
     font.main=1,
     main="Point character (pch) value and shape")

# Add pch value beneath each point
text(df$x, df$y, label=c(0:25,NA,NA), adj=c(0.5,3), xpd=T)

# Add explanation around last 5 shapes
rect(0.5, 0.5, 5.5, 1.5, xpd=T, lty=2)
text(3, 1.3, label="Point outline colour set with 'col'. Point fill set with 'bg'", xpd=T)