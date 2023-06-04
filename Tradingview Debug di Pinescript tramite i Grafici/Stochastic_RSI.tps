//@version=3
study(title="Stochastic RSI", shorttitle="Stoch RSI", overlay=true, scale=scale.none)
smoothK = input(3, minval=1)
smoothD = input(3, minval=1)
lengthRSI = input(14, minval=1)
lengthStoch = input(14, minval=1)
src = input(close, title="RSI Source")

rsi1 = rsi(src, lengthRSI)
k = sma(stoch(rsi1, rsi1, rsi1, lengthStoch), smoothK)
d = sma(k, smoothD)

plot(k, color=blue)
plot(d, color=orange)
h0 = hline(80)
h1 = hline(20)
fill(h0, h1, color=purple, transp=80)