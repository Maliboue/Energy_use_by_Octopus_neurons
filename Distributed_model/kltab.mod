TITLE lktab.mod Low threshold K current (based on Rothman and Manis 2003)

COMMENT

This is a slight modification of the kht.mod from ModelDB 37857

ENDCOMMENT



UNITS {
    (mA) = (milliamp)
    (mV) = (millivolt)
    (S) = (siemens)
}


NEURON {
    SUFFIX kltab                   : to use in .hoc
    USEION k READ ek WRITE ik      : ion
    RANGE gbar, gklt, ik        : parameters that can change with geometry
    GLOBAL winf, zinf, wtau, ztau  : global parameters
}

PARAMETER {
    celsius (degC)
    treference = 22 (degC)
    gbar = 0.016 (mho/cm2)
    zss = 0.5 <0,1>  : steady-state inactivation of glt
    q10 = 3.0
    ek = -70 (mV)        
}


ASSIGNED {
    v (mV)
    ik (mA/cm2)
    gklt (S/cm2)
    winf zinf
    wtau (ms) ztau (ms)
}

STATE { 
    w z
}


BREAKPOINT {
    SOLVE states METHOD cnexp
    gklt = gbar*(w^4)*z
    ik = gklt*(v-ek)
}

INITIAL {
    setrates(v)
    w = winf
    z = zinf
}

LOCAL qt

DERIVATIVE states {
    setrates(v)
    
    w' = qt*(winf - w)/wtau
    z' = qt*(zinf - z)/wtau
}


PROCEDURE setrates(){ : computes winf, zinf, wtau, ztau as functions of v
    :todo check q10 and usage of celsius 
    winf = (1 / (1 + exp(-(v + 48) / 6)))^0.25
    zinf = zss + ((1-zss) / (1 + exp((v + 71) / 10)))

    wtau =  (100 / (6*exp((v+60) / 6) + 16*exp(-(v+60) / 45))) + 1.5
    ztau =  (1000 / (exp((v+60) / 20) + exp(-(v+60) / 8))) + 50
    
    qt = q10^((celsius - treference)/10) : temperature coefficient
}