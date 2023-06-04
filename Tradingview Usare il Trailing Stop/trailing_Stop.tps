//@version=3
strategy("Trailing Stop Loss Testing", overlay=true)

testStartYear = input(2019, "Backtest Start Year")
testStartMonth = input(10, "Backtest Start Month")
testStartDay = input(06, "Backtest Start Day")
testType = input('Trail Points', "Test Points or Price", options=['Trail Points', 'Trail Price'])
trailLevel = input(1.34193, "Trail Price", type=float, step=0.0001)
trailPoints = input(150, "Trail Points (in ticks)", type=integer)
trailOffset = input(100, "Trail Offset (in ticks)", type=integer)
testPeriodStart = timestamp(testStartYear, testStartMonth, testStartDay, 0, 0)

longCondition = time >= testPeriodStart

if (longCondition)
    strategy.entry("Go Long", strategy.long)

strategy.exit("Trailing Stop", "Go Long", trail_points= trailPoints, trail_offset= trailOffset, when= testType == 'Trail Points')
strategy.exit("Trailing Stop", "Go Long", trail_price= trailLevel, trail_offset= trailOffset, when= testType == 'Trail Price')