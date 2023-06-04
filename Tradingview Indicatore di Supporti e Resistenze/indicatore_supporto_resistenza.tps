//@version=3
study("Support & Resistance", overlay=true)

left = 50
right = 25
quick_right = 5 // Usato per individuare lo swing significativo più recente

pivot_high = pivothigh(high,left,right)
pivot_lows = pivotlow(low, left,right)

quick_pivot_high = pivothigh(high,left,quick_right)
quick_pivot_lows = pivotlow(low, left,quick_right)

level1 = valuewhen(quick_pivot_high, high[quick_right], 0)
level2 = valuewhen(quick_pivot_lows, low[quick_right], 0)
level3 = valuewhen(pivot_high, high[right], 0)
level4 = valuewhen(pivot_lows, low[right], 0)
level5 = valuewhen(pivot_high, high[right], 1)
level6 = valuewhen(pivot_lows, low[right], 1)
level7 = valuewhen(pivot_high, high[right], 2)
level8 = valuewhen(pivot_lows, low[right], 2)

level1_col = close >= level1 ? green : red
level2_col = close >= level2 ? green : red
level3_col = close >= level3 ? green : red
level4_col = close >= level4 ? green : red
level5_col = close >= level5 ? green : red
level6_col = close >= level6 ? green : red
level7_col = close >= level7 ? green : red
level8_col = close >= level8 ? green : red

plot(level1, style=circles, color=level1_col, show_last=1, linewidth=1, trackprice=true)
plot(level2, style=circles, color=level2_col, show_last=1, linewidth=1, trackprice=true)
plot(level3, style=circles, color=level3_col, show_last=1, linewidth=1, trackprice=true)
plot(level4, style=circles, color=level4_col, show_last=1, linewidth=1, trackprice=true)
plot(level5, style=circles, color=level5_col, show_last=1, linewidth=1, trackprice=true)
plot(level6, style=circles, color=level6_col, show_last=1, linewidth=1, trackprice=true)
plot(level7, style=circles, color=level7_col, show_last=1, linewidth=1, trackprice=true)
plot(level8, style=circles, color=level8_col, show_last=1, linewidth=1, trackprice=true)