TITLE Ikht current for Spencer's (2012) octopus cells medel.The current formalism originally from Rothman & Mannis 2003c.


UNITS {
    (mA) = (milliamp)
    (mV) = (millivolt)
}

NEURON {    
    SUFFIX khtoz
    USEION k READ ek WRITE ik
    RANGE gbar, g, ik, ek
    GLOBAL ninf, pinf, ntau, ptau
}

PARAMETER {
    v (mV)
    celsius (degC)
    
    gbar =  0.0061 (mho/cm2) :  value for soma (Bal & Oertel 2001) from Spencer et al., 2012
    ek = -70 (mV)
    nf = 0.85
    q10 = 3
}

ASSIGNED {
    ik (mA/cm2)
    g (mho/cm2)
    
    ninf
    pinf
    ntau (ms)
    ptau (ms)
    
    qt
}


STATE {
    n
    p
}


BREAKPOINT {
    SOLVE states METHOD cnexp
    g = gbar*(nf*(n^2) + (1-nf)*p)
    ik = g*(v - ek)
}

UNITSOFF
INITIAL {
    rates(v)
    n = ninf
    p = pinf
}

DERIVATIVE states {
    rates(v)
    n' = qt*(ninf - n)/ntau
    p' = qt*(pinf - p)/ptau
    
}

PROCEDURE rates(v) {
    
    qt = q10^((celsius - 22)/10)
    
    ninf =  (1 + exp(-(v + 15) / 5))^-0.5
    pinf =  1 / (1 + exp(-(v + 23) / 6))
    
    ntau = (100 / (11*exp((v+60) / 24) + 21*exp(-(v+60) / 23))) + 0.7
    ptau = (100 / (4*exp((v+60) / 32) + 5*exp(-(v+60) / 22))) + 5
}

    