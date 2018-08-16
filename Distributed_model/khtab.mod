TITLE kht -- high threshold K current after Rothman and Manis 2003

COMMENT

This is a slight modification of the kht.mod from ModelDB 37857

ENDCOMMENT


UNITS {
    (mA) = (milliamp)
    (mV) = (millivolt)
}


NEURON {
    SUFFIX khtab
    USEION k READ ek WRITE ik
    RANGE gbar, gkht, ik
    GLOBAL ninf, pinf, ntau, ptau
}

PARAMETER {
    celsius (degC)
    treference = 22 (degC)
    ek = -70 (mV)
    gbar = 0.01592 (mho/cm2) : as in RM-03
    nf = 0.85                   : proportion of n vs p kinetics
    q10 = 3.0
}

STATE {
    n p 
}

ASSIGNED {
    v (mV)
    gkht (mho/cm2)
    pinf ninf
    ptau (ms) ntau(ms)
    ik (mA/cm2)
}

BREAKPOINT {
    SOLVE states METHOD cnexp : is there a better/faster method?
    gkht = gbar*(nf*n*n + (1-nf)*p)
    ik = gkht*(v-ek)
}

INITIAL {
    setrates(v)
    p = pinf
    n = ninf
}

LOCAL qt 


DERIVATIVE states {
    setrates(v)
    
    n' = qt*(ninf - n)/ntau
    p' = qt*(pinf - p)/ptau
}



PROCEDURE setrates (v){
    
    qt = q10^((celsius - treference)/10)
    
    ninf =   (1 + exp(-(v + 15) / 5))^-0.5
    pinf =  1 / (1 + exp(-(v + 23) / 6))
    
    ntau =  (100 / (11*exp((v+60) / 24) + 21*exp(-(v+60) / 23))) + 0.7
    ptau = (100 / (4*exp((v+60) / 32) + 5*exp(-(v+60) / 22))) + 5

}


