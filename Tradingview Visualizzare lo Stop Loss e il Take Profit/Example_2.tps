//@version=3
strategy("My Strategy", overlay=true)

ATR = atr(7)

longCondition = crossover(sma(close, 100), sma(close, 200))
if (longCondition)
    strategy.entry("My Long Entry Id", strategy.long)


shortCondition = crossunder(sma(close, 100), sma(close, 200))
if (shortCondition)
    strategy.entry("My Short Entry Id", strategy.short)

long_stop_level = na
long_profit_level = na
long_stop_level := longCondition ? low - ATR : long_stop_level[1]
long_profit_level := longCondition ? close + ATR : long_profit_level[1]

short_stop_level = na
short_profit_level = na
short_stop_level := shortCondition ? high + ATR : short_stop_level[1]
short_profit_level := shortCondition ? close - ATR : short_profit_level[1]

strategy.exit("TP/SL", "My Long Entry Id", stop=long_stop_level, limit=long_profit_level)
strategy.exit("TP/SL", "My Short Entry Id", stop=short_stop_level, limit=short_profit_level)

plot(strategy.position_size <= 0 ? na : long_stop_level, color=red, style=linebr, linewidth=2)
plot(strategy.position_size <= 0 ? na : long_profit_level, color=green, style=linebr, linewidth=2)
plot(strategy.position_size >= 0 ? na : short_stop_level, color=red, style=linebr, linewidth=2)
plot(strategy.position_size >= 0 ? na : short_profit_level, color=green, style=linebr, linewidth=2)