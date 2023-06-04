//@version=3
study("Blue Fridays", overlay=true)
x = dayofweek == 5
barcolor(x ? blue:gray)