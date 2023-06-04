//@version=4
strategy("Take Profit Detection", overlay=true, default_qty_type=strategy.fixed, default_qty_value=2)

tp_perc = input(1, step=0.25, title='Take Profit 1 %')/100
tp2_perc = input(2, step=0.25, title='Take Profit 2 %')/100
sl_perc = input(1, step=0.25, title='Stop Loss %')/100
sma_len = input(200, minval=1, title='SMA Length')


sma1 = sma(close, sma_len)

long_condition = crossover(close, sma1)
short_condition = crossunder(close, sma1)

strategy.entry('Long', strategy.long, when=long_condition)
strategy.entry('Short', strategy.short, when=short_condition)

long_tp_hit = strategy.position_size[1] > 0 and strategy.position_size[0] > 0 and strategy.position_size[1] > strategy.position_size[0]
short_tp_hit = strategy.position_size[1] < 0 and strategy.position_size[0] < 0 and strategy.position_size[1] < strategy.position_size[0]


// Impostazione stop loss e take profit
// ----------------------------------------
float long_sl_level = na
float short_sl_level = na
// float long_tp_level = na
// float short_tp_level = na
// float long_tp2_level = na
// float short_tp2_level = na

long_sl_level := long_condition ? close * (1 - sl_perc) : long_tp_hit ? strategy.position_avg_price : long_sl_level[1]
short_sl_level := short_condition ? close * (1 + sl_perc) : short_tp_hit ? strategy.position_avg_price : short_sl_level[1]

long_tp_level = strategy.position_avg_price * (1 + tp_perc)
long_tp2_level = strategy.position_avg_price * (1 + tp2_perc)

short_tp_level = strategy.position_avg_price * (1 - tp_perc)
short_tp2_level = strategy.position_avg_price * (1 - tp2_perc)

strategy.exit('L-SLTP1', 'Long', stop=long_sl_level, limit=long_tp_level, qty_percent=50)
strategy.exit('L-SLTP2', 'Long', stop=long_sl_level, limit=long_tp2_level, qty_percent=100)
strategy.exit('S-SLTP1', 'Short', stop=short_sl_level, limit=short_tp_level, qty_percent=50)
strategy.exit('S-SLTP2', 'Short', stop=short_sl_level, limit=short_tp2_level, qty_percent=100)

// Take Profit e Stop
plot(strategy.position_size > 0 ? long_sl_level : na, color=color.red, style=plot.style_circles, title="Long Stop")
plot(strategy.position_size < 0 ? short_sl_level : na, color=color.maroon, style=plot.style_circles, title="Short Stop")
plot(strategy.position_size > 0 ? long_tp_level : na, color=color.lime, style=plot.style_circles, title="Long TP")
plot(strategy.position_size > 0 ? long_tp2_level : na, color=color.lime, style=plot.style_circles, title="Long TP2")
plot(strategy.position_size < 0 ? short_tp_level : na, color=color.green, style=plot.style_circles, title="Short TP")
plot(strategy.position_size < 0 ? short_tp2_level : na, color=color.green, style=plot.style_circles, title="Short TP")

alertcondition(long_condition, title='Go Long')