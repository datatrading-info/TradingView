
//@version=3
study("Blue Fridays", overlay=true)
x = dayofweek
y = x == 1 ? black : x == 2 ? white : x == 3 ? maroon : x == 4 ? fuchsia : x == 5 ? blue : yellow
barcolor(y)