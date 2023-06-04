//@version=3
study(title="Currency Strength", shorttitle="CUR-STR", precision=4, scale=scale.left)

sym1 = input(title='FX Pair 1', type=symbol, defval='OANDA:GBPUSD')
sym1_counter = input(title='Counter Currency?', type=bool, defval=false)
sym2 = input(title='FX Pair 2', type=symbol, defval='OANDA:EURGBP')
sym2_counter = input(title='Counter Currency?', type=bool, defval=true)
sym3 = input(title='FX Pair 3', type=symbol, defval='OANDA:GBPJPY')
sym3_counter = input(title='Counter Currency?', type=bool, defval=false)
sym4 = input(title='FX Pair 4', type=symbol, defval='OANDA:GBPCHF')
sym4_counter = input(title='Counter Currency?', type=bool, defval=false)


inst1_daily = security(sym1, "D", close[1], lookahead=barmerge.lookahead_on)
inst2_daily = security(sym2, "D", close[1], lookahead=barmerge.lookahead_on)
inst3_daily = security(sym3, "D", close[1], lookahead=barmerge.lookahead_on)
inst4_daily = security(sym4, "D", close[1], lookahead=barmerge.lookahead_on)


inst1_current = security(sym1, period, close)
inst2_current = security(sym2, period, close)
inst3_current = security(sym3, period, close)
inst4_current = security(sym4, period, close)

inst1_change = ((inst1_current - inst1_daily) / inst1_daily) * 100
inst2_change = ((inst2_current - inst2_daily) / inst2_daily) * 100
inst3_change = ((inst3_current - inst3_daily) / inst3_daily) * 100
inst4_change = ((inst4_current - inst4_daily) / inst4_daily) * 100


inst1_change := sym1_counter == true ? inst1_change * -1 : inst1_change
inst2_change := sym2_counter == true ? inst2_change * -1 : inst2_change
inst3_change := sym3_counter == true ? inst3_change * -1 : inst3_change
inst4_change := sym4_counter == true ? inst4_change * -1 : inst4_change

overall_strength = (inst1_change + inst2_change + inst3_change + inst4_change) / 4

plot(inst1_change,title='Sym1', color=lime, style=area, transp=80)
plot(inst2_change,title='Sym2', color=blue, style=area, transp=90)
plot(inst3_change,title='Sym3', color=red, style=area, transp=90)
plot(inst4_change,title='Sym4', color=purple, style=area, transp=90)

plot(overall_strength,title='Overall Strength', color=black, linewidth=3, style=line)

// Test Plots
// ------------------
// plot(inst1_daily)
// plot(inst2_daily)
// plot(inst3_daily)
// plot(inst4_daily)

// plot(inst1_current)
// plot(inst2_current)
// plot(inst3_current)
// plot(inst4_current)