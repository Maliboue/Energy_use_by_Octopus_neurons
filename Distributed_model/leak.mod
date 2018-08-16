TITLE passive  (leak) membrane channel

UNITS {
	(mV) = (millivolt)
	(mA) = (milliamp)
}

NEURON {
	SUFFIX leak
	NONSPECIFIC_CURRENT i
	RANGE g, erev
}

PARAMETER {
	g = 0.002	(mho/cm2) : as in Spencer et al 2012
	erev = -62	(mV)      : as in Spencer et al 2012       
    }
    
ASSIGNED { 
    v   (mV)        
    i	(mA/cm2)}

BREAKPOINT {
	i = g*(v - erev)
}


