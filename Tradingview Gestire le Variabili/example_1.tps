//@version=3
strategy("Store Value Post - Open", overlay=true)

// SEMPLICE LOGICA DI ENTRATA
sma = sma(close, 200)
strategy.entry("Long", strategy.long, when=close > sma)

// Chiusura dopo 10 barre
bought = strategy.position_size[0] > strategy.position_size[1]
since_entry = barssince(bought)
strategy.close("Long", when=since_entry >=10)

// Ottenre il prezzo di entrata
entry_price = valuewhen(bought, open, 0)

plot(sma, color=orange, title='SMA')
plot(entry_price, title='Entry Price', linewidth=2)