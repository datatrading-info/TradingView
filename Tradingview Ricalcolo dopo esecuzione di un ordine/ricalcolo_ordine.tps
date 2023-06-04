//@version=4
strategy("calc_on_order_fills testing",  overlay=true, calc_on_order_fills=true, pyramiding=2, max_bars_back=100)

//setup ma
ma = sma(close, 50)

//plotting
plot(ma, linewidth=2)

//Strat
longCondition = (open > ma)
if (longCondition)
    strategy.entry("MA Long Sig", strategy.long)

shortCondition = (open < ma)
if (shortCondition)
    strategy.entry("MA Short Sig", strategy.short)