//@version=3
study("Percentage Change Function", overlay=false)

inp_lkb = input(5, title='Lookback Period')

perc_change(lkb) =>
    overall_change = ((close[0] - open[lkb]) / open[lkb]) * 100
    highest_high = na
    lowest_low = na
    for i = lkb to 0
        highest_high := i == lkb ? high : high[i] > high[(i + 1)] ? high[i] : highest_high[1]
        lowest_low := i == lkb ? low : low[i] < low[(i + 1)] ? low[i] : lowest_low[1]

    start_to_high = ((highest_high - open[lkb]) / open[lkb]) * 100
    start_to_low = ((lowest_low - open[lkb]) / open[lkb]) * 100

    [overall_change, start_to_high, start_to_low]

// Chiamata alla funzione
[overall, to_high, to_low] = perc_change(inp_lkb)

plot(overall, color=black, title='Overall Percentage Change', linewidth=3)
plot(to_high, color=green,title='Percentage Change from Start to High', linewidth=2)
plot(to_low, color=red, title='Percentage Change from Start to Low', linewidth=2)
hline(0, title='Center Line', color=orange, linestyle=solid, linewidth=2)