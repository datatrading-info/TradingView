//@version=3
strategy("Store Value Post - Trailing Stop", overlay=true)

// SEMPLICE LOGICA DI ENTRATA
sma = sma(close, 14)
strategy.entry("Long", strategy.long, when=close > sma)

// Individua gli swing di minimo
// -----------------------
leftbars = 5
rightbars = 2
last_pivot_low = pivotlow(low,leftbars,rightbars)

// Otteniamo il prezzo di stop
stop_price = na
stop_price := strategy.position_size == 0 ? na : valuewhen(last_pivot_low, low[rightbars], 0)

strategy.exit("SL","Long", stop=stop_price)

plot(sma, color=orange, title='SMA')
plot(stop_price, style=linebr, title='Stop Price', linewidth=1, color=red)
//plot(last_pivot_low_value)