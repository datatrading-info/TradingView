//@version=3
strategy("My Strategy", overlay=true)

ATR = atr(7)

longCondition = crossover(sma(close, 100), sma(close, 200))
if (longCondition)
    stop_level = low - ATR
    profit_level = close + ATR
    strategy.entry("My Long Entry Id", strategy.long)
    strategy.exit("TP/SL", "My Long Entry Id", stop=stop_level, limit=profit_level)

shortCondition = crossunder(sma(close, 100), sma(close, 200))
if (shortCondition)
    stop_level = high + ATR
    profit_level = close - ATR
    strategy.entry("My Short Entry Id", strategy.short)
    strategy.exit("TP/SL", "My Short Entry Id", stop=stop_level, limit=profit_level)