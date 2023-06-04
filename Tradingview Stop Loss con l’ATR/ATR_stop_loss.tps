//@version=3
strategy("Daily ATR Stop", overlay=true, precision=5)

smaFastLkb = input(14, minval=1, title='Fast SMA Period')
smaSlowLkb = input(28, minval=1, title='Slow SMA Period')
atrLkb = input(7, minval=1, title='ATR Stop Period')
atrRes = input("D", type=resolution, title='ATR Resolution')
atrMult = input(1, step=0.25, title='ATR Stop Multiplier')

// Calcolo Indicatori
// -------------------
atr = security(tickerid, atrRes, atr(atrLkb))
smaFast = sma(close, smaFastLkb)
smaSlow = sma(close, smaSlowLkb)

longCondition = crossover(smaFast, smaSlow)
if (longCondition)
    strategy.entry("Long", strategy.long)

shortCondition = crossunder(smaFast, smaSlow)
if (shortCondition)
    strategy.entry("Short", strategy.short)

// Calcolo ATR Stop loss
longStop = na
longStop :=  shortCondition ? na : longCondition ? close - (atr * atrMult) : longStop[1]
shortStop = na
shortStop := longCondition ? na : shortCondition ? close + (atr * atrMult) : shortStop[1]

// Inviare le uscite
strategy.exit("Long ATR Stop", "Long", stop=longStop)
strategy.exit("Short ATR Stop", "Short", stop=shortStop)

// Grafico Stop Loss
plot(smaFast, color=orange, linewidth=2, title='Fast SMA')
plot(smaFast, color=purple, linewidth=2, title='Slow SMA')
plot(longStop, style=linebr, color=red,     title='Long ATR Stop')
plot(shortStop, style=linebr, color=maroon,  title='Short ATR Stop')