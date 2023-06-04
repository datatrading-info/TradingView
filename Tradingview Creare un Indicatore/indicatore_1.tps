//@version=3
study("Dual Strength RSI", "DS-RSI")

// Inputs
otf = input(defval="D", title="Second Momentum Timeframe", type=resolution)
otf_period = input(defval=14, title="Look Back Period (2nd Timeframe)", type=integer)
ctf_period = input(defval=14, title="Look Back Period (Chart Timeframe)", type=integer)
ob = input(defval=70, title="Overbought Area", type=integer)
os = input(defval=30, title="Oversold Area", type=integer)

// Get the data
otf_rsi = security(tickerid, otf, rsi(close, otf_period))

// Calculate RSI Values
ctf_rsi = rsi(close, ctf_period)

// Plot
hline(ob, title='Overbought Line', color=black, linestyle=dashed, linewidth=1)
hline(os, title='Oversold Line', color=black, linestyle=dashed, linewidth=1)
plot(otf_rsi, title='OTF RSI', color=blue, style=line, linewidth=3)
plot(ctf_rsi, title='CTF RSI', color=green, style=line, linewidth=3)