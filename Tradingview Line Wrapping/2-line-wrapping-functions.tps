//@version=3
study("My Script")

// Long line
a = open +
  high +
  low +
  close

//Plot
plot(a,
  title = 'My Line Wrapping',
  color=red,
  linewidth=2,
  style=line)