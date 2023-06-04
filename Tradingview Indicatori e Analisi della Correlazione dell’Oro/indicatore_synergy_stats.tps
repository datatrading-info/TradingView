//@version=3
study("Synergy Stats")

alt_sym = input("FX:USDOLLAR", type=symbol, title='Comparison Symbol')
lkb = input(300, title='Lookback Period For Summing')
bars = input(4, title='Both Instruments in Sync > x bars')
thresh = input(0.1, step=0.1, title='Alt Instrument Change Threshold %')

// Otteniamo i dati per il secondo asset
alt_o = security(alt_sym, period, open)
alt_h = security(alt_sym, period, high)
alt_l = security(alt_sym, period, low)
alt_c = security(alt_sym, period, close)

// Work out the candle sentiment - this will help us later
sent = open < close ? 1 : open > close ? -1 : 0
alt_sent = alt_o < alt_c ? 1 : alt_o > alt_c ? -1 : 0

change = ((close - open) / open) * 100
alt_change = ((alt_c - alt_o) / alt_o ) *100

// Osservazione:
// ------------
// In tutti i timeframe gli asset di muovono in direzioni opposte più frequentemente
// che nella stessa direzione
// -----------------------------------------------------------------------------
in_sync = sent == alt_sent ? 1 : 0
opposite = sent != alt_sent ? 1 : 0

count_in_sync = sum(in_sync, lkb)
count_opposite = sum(opposite, lkb)

perc_in_sync = (count_in_sync / lkb) * 100
perc_opposite = (count_opposite / lkb) * 100

bg_col = (change > 0 and alt_change < 0) or (change < 0 and alt_change > 0) ? na :
  (change != 0 and alt_change == 0) or (change == 0 and alt_change != 0) ? na : black
bgcolor(bg_col, transp=90)


// Osservazione:
// ------------
// A. Trend dove i due asse si muovono nella stessa direzione per più di 4 barre
//
// B. Il timeframe a 1 minuti ha la maggioranza delle barre dove i due asset si muovono in
// direzioni opposte.
// -----------------------------------------------------------------------------
trend_count(bars)=>
    result = 1
    for i = 0 to (bars)
        if sent[i] != alt_sent[i]
            result := 0
            break
    result

in_sync_trend = trend_count(bars)

// Cattura i casi dove il trend continua per 6, 7 o 8 barre. Conteggiamo questi come una sola occorenza
count_in_sync_trend = in_sync_trend[1] == 0 and in_sync_trend[0] == 1 ? 1 : 0
total_in_sync_trend = 0
total_in_sync_trend := count_in_sync_trend == 1 ?  nz(total_in_sync_trend[1]) + 1 : total_in_sync_trend[1]


// Osservazioni:
// ------------
// Grandi movimenti nel dollaro USA provocano movimento dell'oro nella direzione opposta
// -----------------------------------------------------------------------------
above_thresh = alt_change > thresh
count_above_thresh = 0
count_above_thresh := above_thresh ? nz(count_above_thresh[1]) + 1 : count_above_thresh[1]
above_thresh_and_in_sync = 0
above_thresh_and_in_sync := above_thresh and in_sync ? nz(above_thresh_and_in_sync[1]) + 1 : nz(above_thresh_and_in_sync[1])

// GRAFICO
// ---------
plot(perc_in_sync, style=line, color=green, title='Percentage: Instruments Are In Sync')
plot(perc_opposite, style=line, color=red, title='Percentage: Instruments Are Moving Opposite')
plotshape(count_in_sync_trend == 1, style=shape.triangleup, color=purple, location=location.bottom, title='Marker: Trend In Sync > x Input')
plotshape(above_thresh, style=shape.triangledown, color=blue, location=location.bottom, title='Marker: Alt Instrument > x Threshold')
plot(total_in_sync_trend, style=stepline, color=purple, title='Count: Trend In Sync > x Input')
plot(above_thresh_and_in_sync, style=stepline, color=blue, title='Count: Number of times Alt Instrument > x Threshold and In Sync')
plot(count_above_thresh, style=stepline, title='Count: Number of times Alt Instrument > x Threshold')