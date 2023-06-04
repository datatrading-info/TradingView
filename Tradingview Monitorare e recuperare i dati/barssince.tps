//@version=3
strategy("Barssince Example")

rsi_len = input(14, title="RSI Length")
rsi_src = input(close, title="RSI Source")

rsi = rsi(rsi_src, rsi_len)

rsi_x_under = crossunder(rsi, 30)

since_x_under = barssince(rsi_x_under)

plot(since_x_under)


/////////////////////////////////////////////////////////

//@version=3
strategy("Barssince Example")

rsi_len = input(14, title="RSI Length")
rsi_src = input(close, title="RSI Source")
rsi_ent = input(30, title="RSI Entry Level")
rsi_ext = input(50, title="RSI Exit Level")
rsi_lim = input(5, title="Cross Back Up Bar Limit")

rsi = rsi(rsi_src, rsi_len)

rsi_x_under = crossunder(rsi, rsi_ent)
rsi_x_over = crossover(rsi, rsi_ent)
rsi_exit = crossover(rsi, rsi_ext)

since_x_under = barssince(rsi_x_under)

strategy.entry("Long", true, when=rsi_x_over and since_x_under <= rsi_lim)
strategy.close("Long", when=rsi_exit)

plot(rsi, color=blue, linewidth=3)
hline(rsi_ent, linestyle=dashed, linewidth=2)
hline(rsi_ext, linestyle=dashed, linewidth=2)