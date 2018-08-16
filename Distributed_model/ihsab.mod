TITLE Hyperpolarization-activated Ih after Spencer 2012

UNITS {
    (mA) = (milliamp)
    (mV) = (millivolt)
}


NEURON {
    SUFFIX ihsab
     NONSPECIFIC_CURRENT ih
     RANGE gbar, gh, eh
     GLOBAL rinf, rtau 
 }

PARAMETER {
    celsius (degC)
    treference = 33 (degC) : 
    eh = -38(mV)
    gbar = 0.0076 (mho/cm2) 
    q10 = 4.5
}

STATE {
    r
}

ASSIGNED {
    v (mV)
    ih (mA/cm2)
    gh (mho/cm2)
    rinf
    rtau (ms)
}

BREAKPOINT {
    SOLVE states METHOD cnexp
    gh = gbar*r
    ih = gh*(v-eh)
}

INITIAL {
    setrates(v)
    r = rinf
}

LOCAL qt

DERIVATIVE states {
    setrates(v)
    
    r' = qt*(rinf - r)/rtau
}


PROCEDURE setrates() {: computes minf, hinf, mtau, htau at current v
    qt = q10^((celsius - treference)/10.0)
    rinf = 1 / ( 1 + exp((v+66)/7))
    rtau = 125*exp(10.44*(v+50)/(273.16 + celsius)) / (1 + exp(34.81*(v+50)/(273.1+celsius)))
}
