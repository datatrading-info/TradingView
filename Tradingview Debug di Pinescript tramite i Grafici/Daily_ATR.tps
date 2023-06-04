
//@version=3
study("Daily ATR", overlay=true)

atr = security(tickerid, "D", atr(7))

is_newbar(res) =>
    t = time(res)
    change(t) != 0

// Visualizzare la nuova barra giornaliera
nb = is_newbar("D")

plotchar(nb, location=location.abovebar, text="ATR")
//plotchar(nb, location=location.abovebar, text=tostring(atr))


/////////////////////////////////////////////////////


//@version=3
study("Daily ATR", overlay=false)
opts = input(defval='Hammer', title='Operation Mode', options=["Hammer", "Hanging", "Engulfing"])

operation_mode = opts == 'Hammer' ? 1 : opts == 'Hanging' ? 2 : opts == 'Engulfing' ? 3 : 0
plot_color = opts == 'Hammer' ? green : opts == 'Hanging' ? red : opts == 'Engulfing' ? purple : na

plot(operation_mode, color=plot_color, linewidth=2)