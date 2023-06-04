
//@version=4
study("Rounders", overlay=false)
val   = input(12.05, step=0.01, title='Value to round')
mtick = input(0.1, step=0.01, title='Minimum tick to Simulate')
dir   = input("Up", options=["Up","Down"], title="Round")

// NOTA
// ========================================================
// Non dimenticarsi di replicare mtick con syminfo.mintick
// --------------------------------------------------------

round_up_to_tick(x, mintick)=>
    mult = 1 / mintick
    value = ceil(x*mult)/mult

round_down_to_tick(x, mintick)=>
    mult = 1 / mintick
    value = floor(x*mult)/mult

rounded =
  dir == "Up" ? round_up_to_tick(val, mtick) :
  round_down_to_tick(val, mtick)

plot(rounded, title='Rounded Value')