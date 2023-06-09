//@version=4
study("Trendlines", shorttitle='BTL', overlay=true)

leftbars = input(100, minval=1, title='Pivot Detection: Left Bars')
rightbars = input(15, minval=1, title='Pivot Detection: Right Bars')
plotpivots = input(true, title='Plot Pivots')

// Punti Pivot
ph = pivothigh(high, leftbars, rightbars)
pl = pivotlow(low, leftbars, rightbars)

phv1 = valuewhen(ph, high[rightbars], 0)
phb1 = valuewhen(ph, bar_index[rightbars], 0)
phv2 = valuewhen(ph, high[rightbars], 1)
phb2 = valuewhen(ph, bar_index[rightbars], 1)

plv1 = valuewhen(pl, low[rightbars], 0)
plb1 = valuewhen(pl, bar_index[rightbars], 0)
plv2 = valuewhen(pl, low[rightbars], 1)
plb2 = valuewhen(pl, bar_index[rightbars], 1)

plotshape(ph, style=shape.circle, location=location.abovebar, color=color.orange,  title='Pivot High', offset=-rightbars)
plotshape(pl, style=shape.circle,   location=location.belowbar, color=color.blue, title='Pivot Low',  offset=-rightbars)

plot(ph ? high[rightbars] : na, color=color.orange, offset=-rightbars)
plot(pl ? low[rightbars] : na, color=color.purple, offset=-rightbars)

// TRENDLINE
// --------------
get_slope(x1,x2,y1,y2)=>
    m = (y2-y1)/(x2-x1)

get_y_intercept(m, x1, y1)=>
    b=y1-m*x1

get_y(m, b, ts)=>
    y = m * ts + b


int   res_x1 = na
float res_y1 = na
int   res_x2 = na
float res_y2 = na

int   sup_x1 = na
float sup_y1 = na
int   sup_x2 = na
float sup_y2 = na


// Resistenze
res_x1 := ph ? phb1 : res_x1[1]
res_y1 := ph ? phv1 : res_y1[1]
res_x2 := ph ? phb2 : res_x2[1]
res_y2 := ph ? phv2 : res_y2[1]

res_m = get_slope(res_x1,res_x2,res_y1,res_y2)
res_b = get_y_intercept(res_m, res_x1, res_y1)
res_y = get_y(res_m, res_b, bar_index)

// Supporti
sup_x1 := pl ? plb1 : sup_x1[1]
sup_y1 := pl ? plv1 : sup_y1[1]
sup_x2 := pl ? plb2 : sup_x2[1]
sup_y2 := pl ? plv2 : sup_y2[1]

sup_m = get_slope(sup_x1,sup_x2,sup_y1,sup_y2)
sup_b = get_y_intercept(sup_m, sup_x1, sup_y1)
sup_y = get_y(sup_m, sup_b, bar_index)


// plot(line.get_y2(line1))
plot(res_y, color=color.red, title='Resistance Trendline', linewidth=2, style=plot.style_circles)
plot(sup_y, color=color.lime, title='Support Trendline', linewidth=2, style=plot.style_circles)

if ph
    line.new(phb1,phv1, bar_index, res_y, style=line.style_dashed, color=color.blue)

if pl
    line.new(plb1,plv1, bar_index, sup_y, style=line.style_dashed, color=color.blue)

// Breakout
long_break = crossover(close, res_y)
short_break = crossunder(close, sup_y)
plotshape(long_break,  style=shape.triangleup, color=color.green, size=size.tiny, location=location.belowbar, title='Long Break')
plotshape(short_break, style=shape.triangledown, color=color.red, size=size.tiny, location=location.abovebar, title='Short Break')

alertcondition(long_break, title='Long Breakout')
alertcondition(short_break, title='Short Breakout')