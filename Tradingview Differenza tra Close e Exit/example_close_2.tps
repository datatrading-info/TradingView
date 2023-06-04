//@version=3

strategy("Close Example", overlay=true, pyramiding=2)

testStartYear = input(2018, "Backtest Start Year")
testStartMonth = input(09, "Backtest Start Month")
testStartDay = input(01, "Backtest Start Day")
testPeriodStart = timestamp(testStartYear, testStartMonth, testStartDay, 0, 0)

// Evita di entrare 2 posizioni del mercoledi quando la piramidazione è attiva
// Questo This would prevent us entering a monday position.
wedEntered = na
wedEntered := nz(wedEntered[1], false)

monCondition = time >= testPeriodStart and dayofweek == monday
wedCondition = time >= testPeriodStart and dayofweek == wednesday and (not wedEntered[1])

if (monCondition)
    strategy.entry("Monday", strategy.long)

if (wedCondition)
    wedEntered := true
    strategy.entry("Wednesday", strategy.long)


strategy.close("Monday", when=dayofweek == friday)