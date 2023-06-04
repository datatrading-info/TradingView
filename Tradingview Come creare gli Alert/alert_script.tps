//@version=3
study("Alert Tester", overlay=true)

x = input(defval=0.00005, title='Min Pip Movement to trigger altert', type=float)

upper = open + x
lower = open - x

alertcondition(high > upper, title='High > Upper Bound', message='The bar high has broken the upper boundary')
alertcondition(low < lower, title='Low < Lower Bound', message='The bar low has broken the lower boundary')

plot(upper, title='Upper Boundary')
plot(lower, title='Lower Boundary')