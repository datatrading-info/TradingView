//@version=3
study("Highest Bars - Use Case Three")

rsi = rsi(close, 7)
hb = highestbars(rsi, 20)
plot(rsi)

// Mostra la percentuale di ritracciamento dal massimo
// E' sempre 0 o negativo per misura la distanza dal punto di massimo
diff = ((rsi - rsi[-hb]) / rsi[-hb]) * 100
plot(diff, color=black, title='RSI Retracment')

// Possiamo usare anche higest()
diff_alt = ((rsi - highest(rsi, 20)) / highest(rsi, 20) ) * 100
plot(diff_alt, color=black, title='RSI Retracment - Highest()')