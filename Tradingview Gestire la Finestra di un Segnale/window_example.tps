//@version=3
strategy("Window Example", overlay=true)

FromYear  = input(defval = 2018, title = "From Year", minval = 2017)
FromMonth = input(defval = 1, title = "From Month", minval = 1, maxval = 12)
FromDay   = input(defval = 1, title = "From Day", minval = 1, maxval = 31)
ToYear    = input(defval = 9999, title = "To Year", minval = 2017)
ToMonth   = input(defval = 1, title = "To Month", minval = 1, maxval = 12)
ToDay     = input(defval = 1, title = "To Day", minval = 1, maxval = 31)

start  = timestamp(FromYear, FromMonth, FromDay, 00, 00)  // inizio backtest
finish = timestamp(ToYear, ToMonth, ToDay, 23, 59)        // fine backtest
trade_window = time >= start and time <= finish ? true : false // crea la funzione "all'interno della finestra temporale"

left_bars = input(10, title='Pivot Detection: Left Bars')
right_bars = input(3, title='Pivot Detection: Right Bars')
min_retracement = input(0.5, type=float, title='Min Retracement from pivot')/100
breakout_limit = input(50, title='Breakout Window: Max bars from pivot to breakout')

// Ottenere gli swing più recenti e i loro valori
pivot_high = pivothigh(high, left_bars,right_bars)
pivot_low = pivotlow(low, left_bars, right_bars)
pivot_high_value = valuewhen(pivot_high, high[right_bars], 0)
pivot_low_value = valuewhen(pivot_low, low[right_bars], 0)

// Abbiamo bisogno di verificare se il pivot massimo o il pivot minimo sono attivati per primo.
// perchè non vogliamo attivati in una finestra short quando stiamo cercando un setup long.
since_pivot_high = barssince(pivot_high)
since_pivot_low = barssince(pivot_low)


// Calcolo del ritracciamento dal massimo/minimo
// long_retracement = since_pivot_high < since_pivot_low ? (close - pivot_high_value)/pivot_high_value : na
// short_retracement = since_pivot_low < since_pivot_high ? (close - pivot_low_value)/pivot_low_value : na
long_retracement = since_pivot_high < since_pivot_low ? (close - pivot_high_value)/pivot_high_value : na
short_retracement = since_pivot_low < since_pivot_high ? (close - pivot_low_value)/pivot_low_value : na


// Aprire e Chiudere la finistra
// Chiudere quando:
//       - una nuova finestra è aperta
//       - un nuovo pivot è individuato (reset)
//       - oltrepassare il limite di breakout
buy_window = false
sell_window = false

buy_window :=
  strategy.position_size > 0 ? false :
  pivot_high ? false :
  since_pivot_high > breakout_limit ? false:
  long_retracement <= -min_retracement  ? true : buy_window[1]

sell_window :=
  strategy.position_size < 0 ? false :
  pivot_low ? false :
  since_pivot_low > breakout_limit ? false:
  short_retracement >= min_retracement  ? true : sell_window[1]

// Entrate
longCondition = close > pivot_high_value and buy_window and trade_window
if (longCondition)
    strategy.entry("Long", strategy.long)

shortCondition = close < pivot_low_value and sell_window and trade_window
if (shortCondition)
    strategy.entry("Short", strategy.short)

plotshape(pivot_high, style=shape.arrowdown, location=location.abovebar, color=purple, title='Pivot High', offset=-right_bars)
plotshape(pivot_low, style=shape.arrowup, location=location.belowbar, color=purple, title='Pivot Low', offset=-right_bars)

bgcolor(buy_window and sell_window ? orange : buy_window ? lime : sell_window ? red : na, transp=80)

position_color  = strategy.position_size > 0 ? green : strategy.position_size < 0 ? red : silver
plotshape(true, style=shape.circle, location=location.bottom, color=position_color, title='Position Indicator')

// Grafici Test
//plot(long_retracement, style=linebr)
//plot(short_retracement, color=red, style=linebr)