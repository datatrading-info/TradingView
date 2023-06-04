
//@version=3
study("Swing Indicator", overlay=true)

////////////////////////////////////////////////////////////////////////////////
// Swing Dectection Indicator
////////////////////////////////////////////////////////////////////////////////

barsback = input(7, title='Bars back to check for a swing')
showsig = input(false, title='Show Signal Markers')

swing_detection(index)=>
    swing_high = false
    swing_low = false
    start = (index*2) - 1 // -1 so we have an even number of
    swing_point_high = high[index]
    swing_point_low = low[index]

    //Swing di Massimi
    for i = 0 to start
        swing_high := true
        if i < index
            if high[i] > swing_point_high
                swing_high := false
                break
        // Fare separatamente i controlli prima del pivot e dopo perché possiamo ottenere
        // due massimo dello stesso valore di fila. Notare la differenza > e >=
        if i > index
            if high[i] >= swing_point_high
                swing_high := false
                break

    //Swing di Minimi
    for i = 0 to start
        swing_low := true
        if i < index
            if low[i] < swing_point_low
                swing_low := false
                break
        // Fare separatamente i controlli prima del pivot e dopo perché possiamo ottenere
        // due minimi dello stesso valore di fila. Notare la differenza > e >=
        if i > index
            if low[i] <= swing_point_low
                swing_low := false
                break

    [swing_high, swing_low]

// Controllo per uno swing
[swing_high, swing_low] = swing_detection(barsback)

// Graifco
plotshape(swing_high, style=shape.arrowdown, location=location.abovebar, color=red, text='SH', offset=-barsback)
plotshape(swing_low, style=shape.arrowup, location=location.belowbar, color=green, text='SL', offset=-barsback)
plotshape(showsig ? swing_high : na, style=shape.arrowdown, location=location.abovebar, color=blue, text='Sig')
plotshape(showsig ? swing_low : na, style=shape.arrowup, location=location.belowbar, color=blue, text='Sig')