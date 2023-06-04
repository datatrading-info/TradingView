//@version=3
study("LME Inventories Indicator", overlay=false)

//Add an input for Metal Selection
metal = input(defval='CU', title='Metal', options=['AL','CU','ZI'])

// Create sym
stBase = 'QUANDL:LME/ST_'
stSym = stBase + metal + '_ALL'

//Get the data
st = security(stSym,'D', close[0])

//Calc the percentage change
stChange = ((st[0] - st[1]) / st[1]) * 100

//Setup Colors
stCol = if stChange > 0
    red
else
    green
plot(stChange, title='Inventory Level Changes (In %)', color=stCol,linewidth=3,style=columns)