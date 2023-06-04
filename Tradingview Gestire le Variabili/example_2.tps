//@version=3
strategy("Store Value Post - RSI", overlay=false)

// SEMPLICE LOGICA DI ENTRATA
sma = sma(close, 14)
strategy.entry("Long", strategy.long, when=close > sma)

rsi = rsi(close, 14)

// Memorizza il valore RSI di entrata
entry_rsi = na
rsi_close = na
entry_rsi := rsi_close[1] ? na : strategy.position_size[0] > strategy.position_size[1] ? rsi : entry_rsi[1]

// Verifica se dobbiamo chiudere
rsi_close := rsi < entry_rsi
strategy.close("Long", when=rsi_close)

plot(rsi, color=purple, title='RSI')
plot(entry_rsi, style=linebr, title='Entry Value', linewidth=2, color=red)