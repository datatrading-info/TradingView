
//@version=3
study("RSI Backgound", overlay=true)

rsi = rsi(close, 14)

bcol = rsi > 70 ? red : rsi < 30 ? green : na

bgcolor(bcol)