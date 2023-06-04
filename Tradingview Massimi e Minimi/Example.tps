//@version=3
study("RSI Highestbars")
rsi = rsi(close, 14)
hb = highestbars(rsi, 20)
plot(hb, color=purple)