TITLE Sodium current after Spencer 2012 -> Rothman,Young,Manis-1993


UNITS {
    (mA) = (milliamp)
    (mV) = (millivolt)
}


NEURON {
    SUFFIX nasab
    USEION na READ ena WRITE ina
    RANGE gbar, gna, ina
    GLOBAL hinf, minf, htau, mtau
}

PARAMETER {
    celsius (degC)
    treference= 22 (degC) : room temp in Baltimore :)
    ena (mV)
    gbar = 0.07958 (mho/cm2) : that is what RM-03 used
    q10 = 3.0
    q10h = 10.0
}

STATE {
    m h
}

ASSIGNED {
    v (mV)
    ina (mA/cm2)
    gna (mho/cm2)
    minf hinf
    mtau (ms) htau (ms)
}

BREAKPOINT {
    SOLVE states METHOD cnexp
    gna = gbar*(m^3)*h
    ina = gna*(v-ena)
}

INITIAL {
    setrates(v)
    m = minf
    h = hinf
}


LOCAL qt,qth, malpha, mbeta, halpha, hbeta

DERIVATIVE states {
    setrates(v)
    
    :m' = qt*(minf - m)/mtau
    :h' = qt*(hinf - h)/htau
    m' = malpha*(1-m) - mbeta*m
    h' = halpha*(1-h) - hbeta*h
}



PROCEDURE setrates() {: computes minf, hinf, mtau, htau at current v
    qt = q10^((celsius - treference)/10.0)
    qth = q10h^((celsius - treference)/10.0)
    
    malpha = -0.36*qt*(v + 49)/(exp(-(v+49)/3)-1)
    mbeta = 0.4*qt*(v+58)/(exp((v+58)/20) -1)
    
    halpha = 2.4*qt/(1 + exp((v+68)/3)) + 0.8*qth/(1 + exp(v+61.3))
    hbeta = 3.6*qt/(1+exp(-(v+21)/10))
    
    minf = 1 / (1 + mbeta/malpha)
    hinf = 1/ (1 + hbeta/halpha)
    
    mtau = 1/(malpha + mbeta)
    htau = 1/(halpha + hbeta)
}


