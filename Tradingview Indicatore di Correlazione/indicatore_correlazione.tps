//@version=3
study("Correlate 3")

p = input(defval=200, title='Correlation Period')
inst1 = input(defval='LSE:VUKE', type=symbol, title='Stocks')
inst2 = input(defval='LSE:VGOV', type=symbol, title='Bonds')
inst3 = input(defval='OANDA:GBPUSD', type=symbol, title='Forex')

inst1_data = security(inst1, period, close)
inst2_data = security(inst2, period, close)
inst3_data = security(inst3, period, close)

inst1_corr = correlation(close, inst1_data, p)
inst2_corr = correlation(close, inst2_data, p)
inst3_corr = correlation(close, inst3_data, p)

h1 = hline(1, linestyle=solid, color=black, linewidth=3)
h2 = hline(-1, linestyle=solid, color=black, linewidth=3)
h3 = hline(0, linestyle=dashed, color=black)
h4 = hline(0.70, linestyle=solid, color=black, linewidth=1)
h5 = hline(-0.70, linestyle=solid, color=black, linewidth=1)
h6 = hline(-0.30, linestyle=solid, color=black, linewidth=1)
h7 = hline(0.30, linestyle=solid, color=black, linewidth=1)
fill(h4,h1, color=green, transp=80)
fill(h5,h2, color=red, transp=80)
fill(h6,h7, color=silver, transp=80)

plot(inst1_corr, style=line, title='Inst 1', linewidth=4)
plot(inst2_corr, style=line, color=lime, title='Inst 2', linewidth=4)
plot(inst3_corr, style=line, color=orange, title='Inst 3', linewidth=4)