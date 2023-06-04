//@version=3
study("Synergy")

// Select del secondo asset
alt_sym = input("FX:USDOLLAR", type=symbol, title='Comparison Symbol')

// Ottenere OHLC del secondo asset
alt_o = security(alt_sym, period, open)
alt_h = security(alt_sym, period, high)
alt_l = security(alt_sym, period, low)
alt_c = security(alt_sym, period, close)

change = ((close - open) / open) * 100
alt_change = ((alt_c - alt_o) / alt_o ) *100

// Impostazione colore dello sfondo se entrambi gli strumenti si muovono nella stessa direzione
bg_col = (change > 0 and alt_change < 0) or (change < 0 and alt_change > 0) ? na :
  (change != 0 and alt_change == 0) or (change == 0 and alt_change != 0) ? na : black
bgcolor(bg_col, transp=90)

// Grafico
plot(alt_change, style=columns, color=blue)
plot(change, style=columns, color=orange)