//@version=3
study("Dual HULL Indicator", overlay=true)

h1=input(title="Fast MA Period",type=integer,defval=9)
h1_src= input(title='Fast MA Source', type=string, defval='Close', options=['Open', 'High','Low','Close','HL2'])
h2=input(title="Slow MA Period",type=integer,defval=18)
h2_src=input(title='Slow MA Source', type=string, defval='Close', options=['Open', 'High','Low','Close','HL2'])

get_src(str) =>
    x = str == 'Open' ?
      open:
     str == 'High' ?
      high:
     str == 'Low' ?
      low:
     str == 'Close' ?
      close:
     str == 'HL2' ?
      hl2:
     close
    x

hull_ind(_src, _length)=>
    //HMA = WMA(2*WMA(n/2) − WMA(n)),sqrt(n))
    _return = wma((2 * wma(_src, _length / 2)) - wma(_src, _length), round(sqrt(_length)))

x1= hull_ind(get_src(h1_src), h1)
y1 = hull_ind(get_src(h2_src), h2)


ma=plot(x1, title='Fast MA')
ma2=plot(y1, title='Slow MA')