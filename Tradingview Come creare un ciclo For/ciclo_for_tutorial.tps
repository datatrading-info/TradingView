//@version=3
study("For Loop tutorial - Example 1")

y = 0
for i = 0 to 10
    y := y + i

plot(y)


////////////////////////////////////////////////

//@version=3
study("For Loop tutorial - Example 2")

y = 0
for i = 0 to 10 by 2
    y := y + i

plot(y)


////////////////////////////////////////////////

//@version=3
study("For Loop tutorial - Example 3")

y = 0
for i = 0 to 10 by 2
    z = 10
    y := y + i

plot(y)
plot(z, color=green)


///////////////////////////////////

//@version=3
study("For Loop tutorial - Example 3")

y = 0
z = for i = 0 to 10 by 2
    z = 10
    y := y + i
    z

plot(y)
plot(z, color=green)


//////////////////////////////////////

//@version=3
study("For Loop tutorial - Example 4")

y = 0
z = for i = 0 to 10 by 2
    z = 10
    if z == 10
        continue
    y := y + i
    z

plot(y)
plot(z, color=green)


//////////////////////////////////////

//@version=3
study("For Loop tutorial - Example 5")

total_volume = volume - volume

for i = 0 to 10
    if close[i] >= open[i]
        continue
    total_volume := total_volume + volume[i]

plot(total_volume, style=columns, color=red)


//////////////////////////////////////

//@version=3
study("For Loop tutorial - Example 6")

y = 0
for i = 0 to 10
    if close[i] <= open[i]
        break
    y := y + 1

plot(y, style=line, color=green, linewidth=3)