//@version=3
study("Consecutive Up/Down Study", overlay=true)

consecutiveBarsUp = input(3)
consecutiveBarsDown = input(3)

price = close

ups = 0.0
ups := price > price[1] ? nz(ups[1]) + 1 : 0

dns = 0.0
dns := price < price[1] ? nz(dns[1]) + 1 : 0

alertcondition(ups >= consecutiveBarsUp)
alertcondition(dns >= consecutiveBarsDown)

plotshape(ups >= consecutiveBarsUp, location=location.belowbar, style=shape.arrowup, color=green)
plotshape(dns >= consecutiveBarsDown, location=location.abovebar, style=shape.arrowdown, color=red)