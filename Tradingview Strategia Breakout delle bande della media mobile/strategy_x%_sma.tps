//@version=3
strategy("Breakout x% MA Strat", overlay=true)

lkb = input(200, minval=2, title='SMA Lookback Period')
delta = input(10, step=0.25, title='Entry Delta from MA')/100
bars = input(4, minval=0, title='Min Bars Above/Below Delta')
sl = input(10, step=0.25, title='Stop-Loss Percent')/100

// Creare Medie mobili
ma = sma(close, lkb)
ma_upper = ma * (1 + delta)
ma_lower = ma * (1 - delta)

// ------------------
// CONDIZIONI ENTRATA
// ------------------
// Breakout
long_break = crossover(close, ma)
since_long_break = barssince(long_break)

short_break = crossunder(close, ma)
since_short_break = barssince(short_break)
long_entry = close >= ma_upper and since_long_break >= bars
short_entry = close <= ma_lower and since_long_break >= bars

strategy.entry("Long", strategy.long, when=long_entry)
strategy.entry("Short", strategy.short, when=short_entry)


// -----------------
// CONDIZIONI USCITA
// -----------------
// stop loss
long_stop = strategy.position_avg_price * (1 - sl)
short_stop = strategy.position_avg_price * (1 + sl)

// Individua se il prezzo raggiunge lo stop loss o la MA
long_exit = long_stop > ma ? long_stop : ma
short_exit = short_stop < ma ? short_stop : ma

strategy.exit("Long SL", "Long", stop=long_exit)
strategy.exit("Short SL", "Short", stop=short_exit)

ma_plot = plot(ma, color=maroon, linewidth=2, title='Moving Average')
ma_upper_plot = plot(ma_upper, color=red, linewidth=1, title='MA Upper Boundary')
ma_lower_plot = plot(ma_lower, color=red, linewidth=1, title='MA Lower Boundary')

fill(ma_lower_plot, ma_upper_plot, color=silver, transp=70)