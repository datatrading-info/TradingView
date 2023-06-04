
//@version=3
strategy("Value When Example", overlay=true)

// Tratto da: https://www.tradingview.com/wiki/Sessions_and_Time_Functions
is_newbar(res) =>
    t = time(res)
    change(t) != 0 ? 1 : 0

// Controllo per un nuovo giorno
new_day = is_newbar("D")

// Ottengo la chiusura della barra di apertura precedente
last_close = valuewhen(new_day, close, 1)

strategy.entry("Long", true, when=new_day and close > last_close)
strategy.entry("Short", false, when=new_day and close < last_close)

plot(last_close, style=circles, color=orange)