//@version=3
strategy("Stop Loss Example: Stop Entry", overlay=true)

sma = sma(close, 200)

strategy.entry("My Long Entry Id", strategy.long, stop=sma, when=close < sma)
 
strategy.entry("My Short Entry Id", strategy.short, stop=sma, when=close > sma)

plot(sma, color=orange, linewidth=2)