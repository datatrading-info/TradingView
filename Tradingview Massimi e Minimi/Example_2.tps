//@version=3
study("Highest Bars - Use Case Two")

rsi = rsi(close, 7)
hb = highestbars(rsi, 20)
plot(rsi)

redbars = 0
greenbars = 0
// bisogna usare il meno '-' per convertire in un numero positivo
for i = 0 to -hb
    greenbars:= close[i] > open[i] ?  greenbars + 1 : greenbars
    redbars:= close[i] < open[i] ?  redbars + 1 : redbars

plot(redbars, style=columns, color=red, transp=70)
plot(greenbars, style=columns, color=green, transp=70)