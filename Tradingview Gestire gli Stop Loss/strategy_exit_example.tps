
//@version=3
strategy("Stop Loss Example: Loss Param", overlay=true)

sma_per = input(200, title='SMA Lookback Period', minval=1)
sl_inp = input(100, title='Stop Loss in Ticks', type=integer)
tp_inp = input(50, title='Take Profit in Ticks', type=integer)

sma = sma(close, sma_per)

strategy.entry("Simple SMA Entry", strategy.long, when=crossover(close, sma))

strategy.exit("Stop Loss/TP", "Simple SMA Entry", loss=sl_inp, profit=tp_inp)

plot(sma, color=orange, linewidth=2)