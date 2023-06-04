//@version=3
study("Green Candle Counter")

green_candles = close > open ? 1 : 0

green_candles_sum = sum(green_candles, 100)

plot(green_candles_sum)