
//@version=3
strategy("Asian Stoch", overlay=true)

//###########     Inputs     #################\\
adxlen = input(14, title="ADX Smoothing")
dilen = input(14, title="DI Length")
maxADX = input(26, title="Maximum ADX value allowed to trade")
stPeriod = input(14, title="The lookback period for the stochastic")
stBuy = input(30, title="Buy below this stochastic value")
stSell = input(70, title="Sell above this stochastic value")

//###########    ADR CODE    #################\\
dirmov(len) =>
	up = change(high)
	down = -change(low)
	truerange = rma(tr, len)
	plus = fixnan(100 * rma(up > down and up > 0 ? up : 0, len) / truerange)
	minus = fixnan(100 * rma(down > up and down > 0 ? down : 0, len) / truerange)
	[plus, minus]

adx(dilen, adxlen) =>
	[plus, minus] = dirmov(dilen)
	sum = plus + minus
	adx = 100 * rma(abs(plus - minus) / (sum == 0 ? 1 : sum), adxlen)

sig = adx(dilen, adxlen)
not_trending = sig < maxADX

//###########    Asian Session CODE    #################\\
t = time(period, "1900-0315")
session_open = na(t) ? false : true

//###########    Stochastic CODE    #################\\
stoch = stoch(close, high, low, stPeriod)
long = stoch < stBuy
short = stoch > stSell

//###########      STRATEGY CODE        #################\\

if (long and session_open and not_trending)
//    strategy.close("Short 1")
    strategy.entry("Long 1", strategy.long)


if (short and session_open and not_trending)
//    strategy.close("Long 1")
    strategy.entry("Short 1", strategy.short)

//Close out position before the end of the session.
if not (session_open)
    strategy.close("Long 1")
    strategy.close("Short 1")