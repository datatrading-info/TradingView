//@version=3
study("Intra-bar Volume", overlay=false)

lower_tf = input("5", title='Lower Timeframe')
bars_in_tf = input(12, title='Bars of lower Timeframe')-1 // -1 perchè il ciclo parte da 0

balanced_volume(range)=>
    vol = na
    for i = 0 to range
        if open[i] == close[i]
            vol := na(vol) ? volume[i] : vol + volume[i]
    vol

buying_volume(range)=>
    vol = na
    for i = 0 to range
        if open[i] < close[i]
            vol := na(vol) ? volume[i] : vol + volume[i]
    vol

selling_volume(range)=>
    vol = na
    for i = 0 to range
        if open[i] > close[i]
            vol := na(vol) ? volume[i] : vol + volume[i]
    vol

lower_buy_vol =  security(tickerid, lower_tf, buying_volume(bars_in_tf))
lower_sell_vol =  security(tickerid, lower_tf, selling_volume(bars_in_tf))
balanced_vol =  security(tickerid, lower_tf, balanced_volume(bars_in_tf))

plot(balanced_vol, style=columns, color=black, transp=70, title='Balanced Volume')
plot(lower_buy_vol, style=columns, color=green, title='Buying Volume')
plot(lower_sell_vol, style=columns, color=red, transp=50, title='Selling Volume')