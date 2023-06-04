//@version=3
strategy("Stop Loss Example: Simple Stoploss", overlay=true)

sma_per = input(200, title='SMA Lookback Period', minval=1)
sl_inp = input(2.0, title='Stop Loss %', type=float)/100
tp_inp = input(4.0, title='Take Profit %', type=float)/100

sma = sma(close, sma_per)

stop_level = strategy.position_avg_price * (1 - sl_inp)
take_level = strategy.position_avg_price * (1 + tp_inp)

strategy.entry("Simple SMA Entry", strategy.long, when=crossover(close, sma))

strategy.order("Stop Loss", false, stop=stop_level, oca_name='L', oca_type=strategy.oca.cancel, when=crossover(close, sma) and strategy.position_size > 0)
strategy.order("Take Profit", false, limit=take_level, oca_name='L', oca_type=strategy.oca.cancel, when=crossover(close, sma) and strategy.position_size > 0)

plot(sma, color=orange, linewidth=2)
plot(stop_level, color=red, style=linebr, linewidth=2)
plot(take_level, color=green, style=linebr, linewidth=2)