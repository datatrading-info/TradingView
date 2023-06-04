//@version=3
// Inside Bar Momentum Strategy

strategy("Babypips: Inside Bar Momentum Strategy", overlay=true, default_qty_type=strategy.percent_of_equity, default_qty_value=5)

From_Year  = input(defval = 2018, title = "From Year")
From_Month = input(defval = 1, title = "From Month", minval = 1, maxval = 12)
From_Day   = input(defval = 1, title = "From Day", minval = 1, maxval = 31)
To_Year    = input(defval = 9999, title = "To Year")
To_Month   = input(defval = 1, title = "To Month", minval = 1, maxval = 12)
To_Day     = input(defval = 1, title = "To Day", minval = 1, maxval = 31)
Start  = timestamp(From_Year, From_Month, From_Day, 00, 00)  // backtest start window
Finish = timestamp(To_Year, To_Month, To_Day, 23, 59)        // backtest finish window
Window = time >= Start and time <= Finish

Stop_Buy_Perc  = input(10, "Stop Buy Order Percentage From Previous Candle's Range")/100
Stop_Loss_Perc = input(20, "Stop Loss Distance from High/Low of Previous Candle")/100
Take_Prof_Perc = input(80, "Take Profit Distance from High/Low of Previous Candle")/100

Risk = input(2, "Percentage Of EQUITY to risk per trade", step=0.1, minval=0, maxval=100)/100

Inside_Bar = high[1] > high[0] and low[1] < low[0]
Prev_Range = high[1] - low[1]
Bullish = open[1] < close[1]
Bearish = open[1] > close[1]

// Calcolo dei livelli chiave
Long_Stop_Buy_Level   = high[1] + (Prev_Range * Stop_Buy_Perc)
Short_Stop_Buy_Level  = low[1]  - (Prev_Range * Stop_Buy_Perc)
Long_Stop_Loss_Level  = high[1] - (Prev_Range * Stop_Loss_Perc)
Short_Stop_Loss_Level = low[1]  + (Prev_Range * Stop_Loss_Perc)
Long_Take_Prof_Level  = high[1] + (Prev_Range * Take_Prof_Perc)
Short_Take_Prof_Level = low[1]  - (Prev_Range * Take_Prof_Perc)

long_qty = floor((strategy.equity * Risk) / (Long_Stop_Buy_Level - Long_Stop_Loss_Level))
short_qty = floor((strategy.equity * Risk) / (Short_Stop_Loss_Level - Short_Stop_Buy_Level))


Long_Condition = Window and Inside_Bar and Bullish
if (Long_Condition)
    // Nel caso abbiamo ancora un ordine buy stop attivo
    strategy.cancel_all()
    // Chiude tutte le posizioni aperte
    strategy.close_all()
    strategy.entry("Bullish IB", strategy.long, stop=Long_Stop_Buy_Level, qty=long_qty)
    strategy.exit("Bullish Exit","Bullish IB", stop=Long_Stop_Loss_Level, limit=Long_Take_Prof_Level)


Short_Condition = Window and Inside_Bar and Bearish
if (Short_Condition)
    // Nel caso abbiamo ancora un ordine buy stop attivo
    strategy.cancel_all()
    // Chiude tutte le posizioni aperte
    strategy.close_all()
    strategy.entry("Bearish IB", strategy.short, stop=Short_Stop_Buy_Level, qty=short_qty)
    strategy.exit("Bearish Exit","Bearish IB", stop=Short_Stop_Loss_Level, limit=Short_Take_Prof_Level)

// ----------------------------- PLOTTING ------------------------------------//
plotshape(Inside_Bar, style=shape.arrowdown, location=location.abovebar, color=purple)