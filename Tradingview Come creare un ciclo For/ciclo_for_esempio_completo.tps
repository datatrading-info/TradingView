
//@version=3
study("For Loop Example - Up / Down Bars Counter", precision=2)

lbp = input(defval=20, title="Lookback Period", minval=1)

// Dichiarazione delle variabili upcount, downcount e no change
up = 0
dn = 0
nc = 0

// Ciclo sui dati storici
for i = 0 to lbp -1
    if open[i] < close[i]
        up := up + 1
    if open[i] > close[i]
        dn := dn + 1
    if open[i] == close[i]
        nc := nc + 1

// Conversioni dei conteggi sulle percentuali
up_perc = (up / lbp) * 100
dn_perc = (dn / lbp) * 100
nc_perc = (nc / lbp) * 100

// Grafici
plot(up_perc, title="% Up Bars", color=green, linewidth=3)
plot(dn_perc, title="% Down Bars", color=red, linewidth=3)
plot(nc_perc, title="% No Change Bars", color=black, linewidth=3)

// Linee orizontali di Fibonacci
h1 = hline(0, linestyle=solid, linewidth=2)
h2 = hline(23.6, linestyle=dashed, linewidth=2)
h3 = hline(38.2, linestyle=dashed, linewidth=2)
h4 = hline(50, linestyle=dashed, linewidth=2)
h5 = hline(61.8, linestyle=dashed, linewidth=2)
h6 = hline(100, linestyle=solid, linewidth=2)

// Riempimenti per pulire la visualizzazione
fill(h1,h2, color=red, transp=90)
fill(h5,h6, color=green, transp=90)