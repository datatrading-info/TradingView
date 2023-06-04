//@version=3
strategy("Average Down", overlay=true, pyramiding=4, default_qty_type=strategy.percent_of_equity,
  default_qty_value=10)

// Range di date
from_month = input(defval = 1, title = "From Month", minval = 1, maxval = 12)
from_day   = input(defval = 1, title = "From Day", minval = 1, maxval = 31)
from_year  = input(defval = 2010, title = "From Year")
to_month   = input(defval = 1, title = "To Month", minval = 1, maxval = 12)
to_day     = input(defval = 1, title = "To Day", minval = 1, maxval = 31)
to_year    = input(defval = 9999, title = "To Year")
start  = timestamp(from_year, from_month, from_day, 00, 00)  // backtest start window
finish = timestamp(to_year, to_month, to_day, 23, 59)        // backtest finish window
window = time >= start and time <= finish ? true : false // create function "within window of time"

// Input della strategia
target_perc = input(-10, title='Target Loss to Average Down (%)', maxval=0)/100
take_profit = input(10, title='Target Take Profit', minval=0)/100
target_qty  = input(50, title='% Of Current Holdings to Buy', minval=0)/100
sma_period  = input(20, title='SMA Period')

// Ottenere la SMA usata nella prima entrata
ma = sma(close,sma_period)

// Calcolare i livelli chiave
pnl = (close - strategy.position_avg_price) / strategy.position_avg_price
take_profit_level = strategy.position_avg_price * (1 + take_profit)

// Prima posizione
first_long = crossover(close, ma) and strategy.position_size == 0 and window
if (first_long)
    strategy.entry("Long", strategy.long)

// Media al ribasso
if (pnl <= target_perc)
    qty = floor(strategy.position_size * target_qty)
    strategy.entry("Long", strategy.long, qty=qty)

// Take Profit
strategy.exit("Take Profit", "Long", limit=take_profit_level)

// Grafico
plot(ma, color=blue, linewidth=2, title='SMA')
plot(strategy.position_avg_price, style=linebr, color=red, title='Average Price')
