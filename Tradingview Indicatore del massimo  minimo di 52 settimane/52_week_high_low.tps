//@version=3
study("52 Week High/Low",shorttitle="52W",overlay=true)

high_low_close = input(defval="Highs/Lows", title="Base 52 week values on candle:", options=["Highs/Lows", "Close"] )

weekly_hh = security(tickerid,"W", highest(high,52), lookahead=barmerge.lookahead_on)
weekly_ll = security(tickerid,"W", lowest(low,52), lookahead=barmerge.lookahead_on)
weekly_hc = security(tickerid,"W", highest(close,52), lookahead=barmerge.lookahead_on)
weekly_lc = security(tickerid,"W", lowest(close,52), lookahead=barmerge.lookahead_on)

high_plot = high_low_close == "Highs/Lows" ? weekly_hh : weekly_hc
low_plot = high_low_close == "Highs/Lows" ? weekly_ll : weekly_lc

plot(high_plot, title='52 Week High', trackprice=true, color=orange, offset=-9999)
plot(low_plot, title='52 Week Low', trackprice=true, color=orange, offset=-9999)