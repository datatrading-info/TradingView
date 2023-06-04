//@version=3
strategy("Close and Exit Testing", overlay=true)

testStartYear = input(2018, "Backtest Start Year")
testStartMonth = input(08, "Backtest Start Month")
testStartDay = input(01, "Backtest Start Day")
testPeriodStart = timestamp(testStartYear, testStartMonth, testStartDay, 0, 0)

longCondition = time >= testPeriodStart and dayofweek == monday

if (longCondition)
    strategy.entry("Monday", strategy.long)

strategy.close("Monday", when=dayofweek == friday)
//strategy.close_all(when=dayofweek == friday)