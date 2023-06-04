//@version=3
strategy("Simple RSI", overlay=true, initial_capital=10000, currency='USD')

fromYear = year > 2014
toYear = year < 2016

longCondition = rsi(close, 21) < 30
if (longCondition and fromYear and toYear)
    strategy.entry("Long 1", strategy.long)

closeCondition = rsi(close, 21) > 70
if (closeCondition)
    strategy.close("Long 1")