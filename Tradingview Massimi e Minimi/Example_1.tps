//@version=3
study("Highestbars - Use Case 1")

rsi = rsi(close, 7)
hb = highestbars(rsi, 20)
plot(rsi)

// Show most recent high
bgcolor(red, offset=hb, show_last=1, title='Most Recent High')