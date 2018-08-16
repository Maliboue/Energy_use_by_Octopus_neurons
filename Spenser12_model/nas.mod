TITLE Na current for [Spencer et al., 2012]'s octopus cell model initial segment. 

NEURON {
    SUFFIX nas
    USEION na READ ena WRITE ina
    RANGE gbar, g, ina
    GLOBAL minf, mtau, hinf, htau
}

UNITS {
    (mA) = (milliamp)
    (mV) = (millivolt)
}

PARAMETER {
    celsius (degC)
    v (mV)
    ena = 55 (mV) : from Spencer et al 2012
    gbar = 4.2441 (mho/cm2) : from Spencer et al 2012
}

ASSIGNED {
    ina (mA/cm2)
    g (mho/cm2)
    
    minf
    hinf
    mtau (ms)
    htau (ms)
    
    :qt
    :qt2
}

STATE {
    m h
}


BREAKPOINT {
    SOLVE states METHOD cnexp
    g = gbar*(m^3)*h
    ina = g*(v-ena)
}

INITIAL {
    rates(v)
    h = hinf
    m = minf
}

UNITSOFF
LOCAL qt, qt2

DERIVATIVE states {
    rates(v)
    m' = (minf-m)/mtau
    h' = (hinf-h)/htau
}


PROCEDURE rates(v) {
    
    LOCAL hlp
    
    qt = 3^((celsius - 22)/10)
    :qt2 = 10^((celsius - 33)/10) : Oops... Mistake here: Rothman'93 has qt2=10^((cel-22)/10)
    qt2 = 10^((celsius - 22)/10) : 23.07.16 corrected -> AP faster 
    : T corrections as in Rothman 1993:
    
    minf = 1/(1-(1.11*(v+58)/(v+49))*(exp(-(v+49)/3)-1)/(exp((v+58)/20)-1))
    mtau = 1/(0.4*qt*((v+58)/(exp((v+58)/20)-1)) - 0.36*qt*((v+49)/(exp(-(v+49)/3)-1)))
   
    hlp = 2.4*qt/(1+exp((v+68)/3)) + 0.8*qt2/(1+exp(v+61.3))
    
    hinf = hlp/(hlp + 3.6*qt/(1+exp(-(v+21)/10)))
    htau = 1/(hlp + 3.6*qt/(1+exp(-(v+21)/10)))
    
}
UNITSON

COMMENT 
FUNCTION vtrap(x,y) {  :Traps for 0 in denominator of rate eqns.
        if (fabs(x/y) < 1e-6) {
                vtrap = y*(1 - x/y/2)
        }else{
                vtrap = x/(exp(x/y) - 1)
            }
	}
	
ENDCOMMENT
	


