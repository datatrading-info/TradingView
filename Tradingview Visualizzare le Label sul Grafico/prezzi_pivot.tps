//@version=4
study("Pivot Prices", overlay=true)

leftbars = input(10, minval=1, title='Bars to the left')
rightbars = input(2, minval=1, title='Bars to the right')

phigh = pivothigh(high, leftbars,rightbars)
plow = pivotlow(low, leftbars, rightbars)

if phigh
    label1 = label.new(bar_index[rightbars], high[rightbars], text=tostring(high[rightbars]), style=label.style_labeldown, color=color.orange)

if plow
    label2 = label.new(bar_index[rightbars], low[rightbars], text=tostring(low[rightbars]), style=label.style_labelup, color=color.green)