updown(s) =>  
    isEqual = s == s[1]
    isGrowing = s > s[1]    
    ud = isEqual ?
           0 :
           isGrowing ?
               (nz(ud[1]) <= 0 ?
                     1 :
                   nz(ud[1])+1) :
               (nz(ud[1]) >= 0 ?
                   -1 :
                   nz(ud[1])-1)