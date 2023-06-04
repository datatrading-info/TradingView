
//@version=3
study("Consecutive Up/Down Study", overlay=true)

consecutiveBarsUp = input(3)
consecutiveBarsDown = input(3)

price = close

ups = 0.0
ups := price > price[1] ? nz(ups[1]) + 1 : 0

dns = 0.0
dns := price < price[1] ? nz(dns[1]) + 1 : 0

goLong  = ups >= consecutiveBarsUp
goShort = dns >= consecutiveBarsDown

inLongPosition  = na
inLongPosition := goLong[1] ? true : goShort[1] ? false : inLongPosition[1]
inShortPosition = na
inShortPosition:= goShort[1] ? true : goLong[1] ? false : inShortPosition[1]
flat  = na
flat := not inLongPosition and not inShortPosition

alertcondition(goLong  and (inShortPosition or flat))
alertcondition(goShort and (inLongPosition or flat))

plotshape(goLong  and (inShortPosition or flat), location=location.belowbar, style=shape.arrowup, color=green)
plotshape(goShort and (inLongPosition or flat), location=location.abovebar, style=shape.arrowdown, color=red)

//plot(strategy.equity, title="equity", color=red, linewidth=2, style=areabr)