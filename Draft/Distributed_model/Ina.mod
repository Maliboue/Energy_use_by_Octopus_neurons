TITLE Sodium current for octopus cells
:based on eqns from Rothman & Manis 2003c
:"The roles K_currents play in regulating the electrical activity of VCN neurons"

UNITS {
    (mV) = (millivolt)
    (mA) = (milliamp)
}

NEURON {
    SUFFIX Ina
    USEION na READ ena WRITE ina
    RANGE gna, gnama
    GLOBAL minf, hinf, taum, tauh
}

PARAMETER {
    gnama = 0.07958 (mho/cm2)
    ena = 55 (mV)
}

STATE {
    m
    h
}

ASSIGNED {
    v (mV)
    ina (mA/cm2)
    gna (mho/cm2)
    minf
    hinf
    taum (ms)
    tauh (ms)
}

INITIAL {
    settables(v)
    m = minf
    h = hinf
}

UNITSOFF
PROCEDURE settables(v (mV)) {
    
    TABLE minf, hinf, taum, tauh FROM -100 TO 100 WITH 200
    
    minf = (1 / (1+exp(-(v+38) / 7)))
    taum = (10 / (5*exp((v+60) / 18) + 36*exp(-(v+60) / 25)) + 0.04)
    
    hinf = (1 / (1+ exp((v+65) / 6)))
    tauh = (100 / (7*exp((v+60)/11) + 10*exp(-(v+60) / 25)) + 0.6)
}
UNITSON

BREAKPOINT {
    SOLVE states METHOD cnexp
    gna = gnama*m*m*m*h
    ina = gna*(v-ena)
}

DERIVATIVE states {
    settables(v)
    m' = ((minf - m) / taum)
    h' = ((hinf - h) / tauh)
}

