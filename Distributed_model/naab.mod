TITLE Sodium current after Rothman and Manis 2003

COMMENT

This is a slight modification of the kht.mod from ModelDB 37857

ENDCOMMENT


UNITS {
    (mA) = (milliamp)
    (mV) = (millivolt)
}


NEURON {
    SUFFIX naab
    USEION na READ ena WRITE ina
    RANGE gbar, gna, ina
    GLOBAL hinf, minf, htau, mtau
}

PARAMETER {
    celsius (degC)
    treference = 22 (degC) : room temp in Baltimore :)
    ena (mV)
    gbar = 0.07958 (mho/cm2) : that is what RM-03 used
    q10 = 3.0
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

DERIVATIVE states {
    setrates(v)
    
    m' = q10*(minf - m)/mtau
    h' = q10*(hinf - h)/htau
}

LOCAL qt

PROCEDURE setrates() {: computes minf, hinf, mtau, htau at current v
    qt = q10^((celsius - treference)/10.0)
    
    minf = 1 / (1+exp(-(v + 38) / 7))
    hinf = 1 / (1+exp((v + 65) / 6))

    mtau =  (10 / (5*exp((v+60) / 18) + 36*exp(-(v+60) / 25))) + 0.04
    htau =  (100 / (7*exp((v+60) / 11) + 10*exp(-(v+60) / 25))) + 0.6
}

