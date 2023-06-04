//@version=3
strategy("Default Inputs for Strategy", overlay=false)

// Creare input generici per la strategia
dir_inp = input(defval="Both", title='Trade Direction', options=["Long Only","Short Only","Both"])
st_yr_inp = input(defval=2017, title='Backtest Start Year', type=integer)
st_mn_inp = input(defval=01, title='Backtest Start Month', type=integer)
st_dy_inp = input(defval=01, title='Backtest Start Day', type=integer)
en_yr_inp = input(defval=2025, title='Backtest End Year', type=integer)
en_mn_inp = input(defval=01, title='Backtest End Month', type=integer)
en_dy_inp = input(defval=01, title='Backtest End Day', type=integer)

// Tipi di Stop predefiniti
fstp = input(defval=true, title="Fixed Perc stop")
fper = input(defval=0.1, title='Percentage for fixed stop', type=float)
atsp = input(defval=false, title="ATR Based stop")
atrl = input(defval=7, title='ATR Length for stop')
atrm = input(defval=1, title='ATR Multiplier for stop')

// Sessioni
asa_inp = input(defval=true, title="Trade the Asian Session")
eur_inp = input(defval=true, title="Trade the European Session")
usa_inp = input(defval=true, title="Trade the US session")
ses_cls = input(defval=true, title="End of Session Close Out?")

// Orario di inizio e fine delle sessioni Start / End times (In exchange TZ = UTC-5)
asa_ses = "2200-0800"
eur_ses = "0700-1700"
usa_ses = "01300-2200"

in_asa = time(period, asa_ses)
in_eur = time(period, eur_ses)
in_usa = time(period, usa_ses)

// Logica di Long / Short
dir = dir_inp == "Both" ? strategy.direction.all :
  dir_inp == "Short Only" ? strategy.direction.short :
  strategy.direction.long
strategy.risk.allow_entry_in(dir)

// Imposto le date di inizio e fine per il backtest
start = timestamp(st_yr_inp, st_mn_inp, st_dy_inp,00,00)
end = timestamp(en_yr_inp, en_mn_inp, en_dy_inp,00,00)

// Controllo se siamo nella sessione desiderata
can_trade = asa_inp and not na(in_asa) ? true :
  eur_inp and not na(in_eur) ? true :
  usa_inp and not na(in_usa) ? true :
  false

// calcolo atr per lo stop
atr = atr(atrl)
atr_stp_dst = atr * atrm

// --------------------------------------------------------- //
//                                                           //
//                  INSERIRE IL CODIDEDE                     //
//                  DELLA STRATEGIA                          //
//                                                           //
// --------------------------------------------------------- //

long_condition = false
short_condition = false

if (long_condition)
    strategy.entry("Long Entry",  strategy.long)
    if strategy.position_size <= 0
        if atsp
            atr_stop = open  - atr_stp_dst
            strategy.exit('ATR Fixed Short Stop', "Long Entry", stop=atr_stop)
        if fstp
            stop = open - (open * fper)
            strategy.exit('Perc Fixed Long Stop Exit', "Long Entry", stop=stop)

if (short_condition)
    strategy.entry("Short Entry",strategy.short)
    if strategy.position_size >= 0 
        if atsp
            atr_stop = open  + atr_stp_dst
            strategy.exit('ATR Fixed Short Stop Exit', "Short Entry", stop=atr_stop)
        if fstp
            stop = open + (open * fper)
            strategy.exit('Perc Fixed Short Stop Exit', "Short Entry", stop=stop)


strategy.close_all(when=not can_trade and ses_cls)

// Grafici per il Testing e Debug
//plot(can_trade ? 1 : 0, color=purple, linewidth=2)
//plot(na(in_asa) ? 0 : 1, color=red)
//plot(na(in_eur) ? 0 : 1, color=blue)
//plot(na(in_usa) ? 0 : 1, color=green)