//@version=3
strategy("Metrics Investigation", overlay=true, default_qty_type=strategy.percent_of_equity, default_qty_value=20)

T1_On = input(true, title='Trade 1')
T1_Enter_Year  = input(defval = 2018, title = "Trade 1 Entry Year")
T1_Enter_Month = input(defval = 1, title = "Trade 1 Entry Month", minval = 1, maxval = 12)
T1_Enter_Day   = input(defval = 1, title = "Trade 1 Entry  Day", minval = 1, maxval = 31)
T1_Exit_Year   = input(defval = 2018, title = "Trade 1 Exit Year")
T1_Exit_Month  = input(defval = 2, title = "Trade 1 Exit Month", minval = 1, maxval = 12)
T1_Exit_Day    = input(defval = 1, title = "Trade 1 Exit Day", minval = 1, maxval = 31)
T1_Enter = timestamp(T1_Enter_Year, T1_Enter_Month, T1_Enter_Day, 00, 00)  // backtest start window
T1_Exit  = timestamp(T1_Exit_Year, T1_Exit_Month, T1_Exit_Day, 00, 00)  // backtest finish window

T2_On = input(false, title='Trade 2')
T2_Enter_Year  = input(defval = 2018, title = "Trade 2 Entry Year")
T2_Enter_Month = input(defval = 3, title = "Trade 2 Entry Month", minval = 1, maxval = 12)
T2_Enter_Day   = input(defval = 1, title = "Trade 2 Entry  Day", minval = 1, maxval = 31)
T2_Exit_Year   = input(defval = 2018, title = "Trade 2 Exit Year")
T2_Exit_Month  = input(defval = 4, title = "Trade 2 Exit Month", minval = 1, maxval = 12)
T2_Exit_Day    = input(defval = 1, title = "Trade 2 Exit Day", minval = 1, maxval = 31)
T2_Enter = timestamp(T2_Enter_Year, T2_Enter_Month, T2_Enter_Day, 00, 00)  // backtest start window
T2_Exit  = timestamp(T2_Exit_Year, T2_Exit_Month, T2_Exit_Day, 00, 00)  // backtest finish window

T3_On = input(false, title='Trade 3')
T3_Enter_Year  = input(defval = 2018, title = "Trade 3 Entry Year")
T3_Enter_Month = input(defval = 5, title = "Trade 3 Entry Month", minval = 1, maxval = 12)
T3_Enter_Day   = input(defval = 1, title = "Trade 3 Entry  Day", minval = 1, maxval = 31)
T3_Exit_Year   = input(defval = 2018, title = "Trade 3 Exit Year")
T3_Exit_Month  = input(defval = 6, title = "Trade 3 Exit Month", minval = 1, maxval = 12)
T3_Exit_Day    = input(defval = 1, title = "Trade 3 Exit Day", minval = 1, maxval = 31)
T3_Enter = timestamp(T3_Enter_Year, T3_Enter_Month, T3_Enter_Day, 00, 00)  // backtest start window
T3_Exit  = timestamp(T3_Exit_Year, T3_Exit_Month, T3_Exit_Day, 00, 00)  // backtest finish window

T1 = T1_On ? time >= T1_Enter and time <= T1_Exit : false
T2 = T2_On ? time >= T2_Enter and time <= T2_Exit : false
T3 = T3_On ? time >= T3_Enter and time <= T3_Exit : false

bgcolor(T1 or T2 or T3 ? green : na, transp=75)
strategy.entry("Trade 1", strategy.long, when=T1)
strategy.close("Trade 1", when=not T1)
strategy.entry("Trade 2", strategy.long, when=T2)
strategy.close("Trade 2", when=not T2)
strategy.entry("Trade 3", strategy.long, when=T3)
strategy.close("Trade 3", when=not T3)