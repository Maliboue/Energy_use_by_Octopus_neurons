TITLE Iklt current for Spencer's (2012) octopus cells model

UNITS {
    (mV) = (millivolt)
    (mA) = (milliamp)
}

NEURON {
    SUFFIX kltoz
    USEION k READ ek WRITE ik
    RANGE gbar, g, ik
    GLOBAL winf, zinf, wtau, ztau
}

PARAMETER {
    celsius (degC)
    
    v (mV)
    ek = -70 (mV)
    gbar =  0.0407 (mho/cm2) : For soma (Spencer 2012) Dends need 0.0027
    
    zss = 0.5
    q10 = 3
}

ASSIGNED {
    ik (mA/cm2)
    g (mho/cm2)
    
    winf
    zinf
    wtau (ms)
    ztau (ms)
    
    qt
}

STATE { 
    w
    z
}

BREAKPOINT {
    SOLVE states METHOD cnexp
    g = gbar*(w^4)*z
    ik = g*(v - ek)
}
UNITSOFF
INITIAL {
    rates(v)
    w = winf
    z = zinf
}

DERIVATIVE states {
    rates(v)
    
    w' = qt*(winf - w)/wtau
    z' = qt*(zinf - z)/ztau
}

PROCEDURE rates(v) {
    
    qt = q10^((celsius - 22)/10)
    
    winf = (1 / (1 + exp(-(v + 48) / 6)))^0.25
    zinf = zss + ((1-zss) / (1 + exp((v + 71) / 10)))

    wtau =  (100 / (6*exp((v+60) / 6) + 16*exp(-(v+60) / 45))) + 1.5
    ztau =  (1000 / (exp((v+60) / 20) + exp(-(v+60) / 8))) + 50
}
UNITSON

