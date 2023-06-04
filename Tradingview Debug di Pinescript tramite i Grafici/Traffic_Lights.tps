
//@version=3
strategy("Traffic Lights", overlay=false)

sma_check = close > sma(close, 14)
vol_check = volume > (volume[1] * 2)
close_check = close > open

sma_plot_col = sma_check ? green : red
vol_plot_col = vol_check ? green : red
close_plot_col = close_check ? green : red

longCondition = sma_check and vol_check and close_check
if(longCondition)
    strategy.entry("Long", strategy.long)

shortCondition = not sma_check and not vol_check and not close_check
if(shortCondition)
    strategy.entry("Short", strategy.short)

plotshape(2, title='SMA Check', color=sma_plot_col, style=shape.circle, location=location.absolute)
plotshape(4, title='Vol Check', color=vol_plot_col, style=shape.circle, location=location.absolute)
plotshape(6, title='Close Check',color=close_plot_col, style=shape.circle, location=location.absolute)
hline(1, linestyle=solid)
hline(3, linestyle=dashed)
hline(5, linestyle=dashed)
hline(7, linestyle=solid)