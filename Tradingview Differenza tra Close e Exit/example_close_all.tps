//@version=3

strategy("Close Example", overlay=true, pyramiding=2)

testStartYear = input(2018, "Backtest Start Year")
testStartMonth = input(09, "Backtest Start Month")
testStartDay = input(01, "Backtest Start Day")
testPeriodStart = timestamp(testStartYear, testStartMonth, testStartDay, 0, 0)

monCondition = time >= testPeriodStart and dayofweek == monday
wedCondition = time >= testPeriodStart and dayofweek == wednesday

if (monCondition)
    strategy.entry("Monday", strategy.long)

if (wedCondition)
    strategy.entry("Wednesday", strategy.long)

strategy.close_all(when=dayofweek == friday)