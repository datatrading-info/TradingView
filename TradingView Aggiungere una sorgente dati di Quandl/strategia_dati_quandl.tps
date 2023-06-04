// @ versione = 3
strategy (title = "Global Metal Inventories Strategy", overlay = true, default_qty_type = strategy.percent_of_equity, default_qty_value = 10)

// Aggiunge un input per Metal Selection
metal = input (defval = 'CU', title = 'Metal', options = ['AL', 'CU', 'ZI'])

// Crea syms
stBase = 'QUANDL: LME / ST_'
stSym = stBase + metal + '_ALL'

// Ottieni dati
st = security (stSym, 'D', close [0])

// Recupera i dati per il grafico corrente
stHigh = sicurezza (ticker, "D", high [0])

stChange = ((st [0] - st [1]) / st [1]) * 100

shortConditionOne = stChange> 10
if (shortConditionOne)
    strategy.entry ("Oversupply", strategy.short, stop = stHigh [0])

closeConditionOne = stChange <= 0
if (closeConditionOne)
    strategy.close ("Oversupply")