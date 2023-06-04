//@version=3
study("Barmerge Tests", overlay=true)

daily_high = security(tickerid, "D", high)
daily_low = security(tickerid, "D", low)

plot(daily_high, style=cross, color=green)
plot(daily_low, style=cross, color=red)