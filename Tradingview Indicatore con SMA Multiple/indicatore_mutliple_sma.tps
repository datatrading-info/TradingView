//@version=3
study("Multi SMA's", overlay=true)


//Get SMA Values
smaA = input(title='SMA1', type=integer, minval=1, step=1, defval=20)
smaB = input(title='SMA2', type=integer, minval=1, step=1, defval=50)
smaC = input(title='SMA3', type=integer, minval=1, step=1, defval=100)
smaD = input(title='SMA4', type=integer, minval=1, step=1, defval=200)

//Set resolutions
resA = input(title='SMA1 Resolution', type=resolution, defval="D")
resB = input(title='SMA2 Resolution', type=resolution, defval="D")
resC = input(title='SMA3 Resolution', type=resolution, defval="D")
resD = input(title='SMA4 Resolution', type=resolution, defval="D")

//Set switches
smaAswitch = input(title="SMA 1 On/Off", type=bool, defval=true)
smaBswitch = input(title="SMA 2 On/Off", type=bool, defval=true)
smaCswitch = input(title="SMA 3 On/Off", type=bool, defval=true)
smaDswitch = input(title="SMA 4 On/Off", type=bool, defval=true)

//get data
dataA = security(tickerid, resA, sma(close, smaA))
dataB = security(tickerid, resB, sma(close, smaB))
dataC = security(tickerid, resC, sma(close, smaC))
dataD = security(tickerid, resD, sma(close, smaD))


//Plotting
plot(smaAswitch ? dataA : na, color=aqua)
plot(smaBswitch ? dataB : na, color=orange)
plot(smaCswitch ? dataC : na, color=green, linewidth=2)
plot(smaDswitch ? dataD : na, color=red, linewidth=2)