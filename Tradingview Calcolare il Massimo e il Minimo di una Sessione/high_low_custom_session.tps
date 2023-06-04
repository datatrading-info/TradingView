//@version=3
study("Session EMA High Low", overlay=true)
my_session = input("1200-1300", type=session, title='Custom Session')
ma_len = input(7, minval=1, title='EMA Length')

// Calcolo l'EMA
ema1 = ema(close, ma_len)

// Determinare se siamo una sessione
// ----------------------------------
in_session = time(period, my_session)
is_new_session(res, sess) =>
    t = time(res, sess)
    na(t[1]) and not na(t) or t[1] < t

new_session = is_new_session("1440", my_session)

// Calcolo dei High/Low della EMA per la sessione
ema_high = na
ema_low = na

ema_high := new_session ? ema1 : in_session ? max(ema1, ema_high[1]) : ema_high[1]
ema_low := new_session ? ema1 :  in_session ? min(ema1,ema_low[1]) : ema_low[1]

plot(ema1, linewidth=2, color=orange, title='EMA')
plot(ema_high, color=green, style=circles, title='EMA High')
plot(ema_low, color=red, style=circles, title='EMA Low')