TITLE mujpow.mod energy consumption calculator based on Moujahid & D'Anjou

UNITS {
    (mA) = (milliamp)
    (mV) = (millivolt)
    (S) = (siemens)
    (pJ) = (picojoule)
}


NEURON {
    SUFFIX mujpow
    USEION k READ ik, ek 
    USEION na READ ina, ena
    POINTER i_ih
    POINTER gh
    RANGE erate
    GLOBAL eh
}


PARAMETER {
    ihna (mA/cm2)
    ihk (mA/cm2)
    gratio = 5
    ena (mV)
    ek (mV)
    eh = -43 (mV)
}

ASSIGNED {
    v (mV)
    ik (mA/cm2)
    ina (mA/cm2)
    erate (pJ/cm^2)
    i_ih (mA/cm2)  
    gh (S/cm2)
    
}

LOCAL gnah  
LOCAL acc
LOCAL gr
LOCAL denom

BREAKPOINT {
    gr = (ena-eh)/(eh-ek)
    
    denom = (v*(gr+1) - gr*ek - ena)
    
    : this is not so smart...
    if ( fabs(v-eh) < 1) {
        gnah = gh/((ena-v)/(v-ek) + 1) 
	:(ena-eh)/(eh-ek), (ena-v)/(v-ek)
    }
    else{
        gnah = i_ih/denom
    }
    
    ihna = gnah*(v-ena)
    ihk = gr*gnah*(v-ek)
    
    acc = (ina + ihna)*(v-ena) + (ik + ihk)*(v-ek)
    erate = (1e6)*acc
}


