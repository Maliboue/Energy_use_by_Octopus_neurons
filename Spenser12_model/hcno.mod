COMMENT
 This model of Ih current is used in Spencer's model. They use equations:
 
(1)  tau_h(v) = (125*exp( 10.44*(v + 50) / (273.16 + T) )) / (1 + exp( 34.81*(v + 50) / (273.16 + T) ))
(2)  hinf(v) = 1 / (1 + exp( (v + 66)/7 )).

The first eqn is 'tau1 = ...' in this *.mod by setting (!) celsius = 33 and frac = 1 (!) But 
no temp correction if celsius = 33...

McGinley 2012 found in his model that hcno.mod behave better with frac = 0.8
ENDCOMMENT

TITLE h current for Octopus cells of Cochlear Nucleus
: From Bal and Oertel (2000)
: M.Migliore Oct. 2001

NEURON {
	SUFFIX hcno
	NONSPECIFIC_CURRENT i
	RANGE  gbar, eh, thegna
	GLOBAL hinf, tau1,tau2
}

PARAMETER {
	gbar  (mho/cm2)	
								
	vhalf1  = -50	(mV)		: v 1/2 for forward
	vhalf2  = -84 	(mV)		: v 1/2 for backward	
	gm1   = 0.3	(mV)	        : slope for forward
	gm2   = 0.6      (mV)		: slope for backward
	zeta1   = 3 	(/ms)		
	zeta2   = 3 	(/ms)		
	a01 = 0.008 
	a02 = 0.0029
	frac= 0.8                       : That is from McGinley'12 paper. Spencer'12 uses
                                	: frac=1, celsius=33 (no temp correction)
                                  	: We use frac=0.8, celsius=37 (T=37)


	thinf  = -66 	(mV)		: inact inf slope	
	qinf  = 7 	(mV)		: inact inf slope 

	q10=4.5				: from Magee (1998)

	eh = -38		(mV)            : must be explicitly def. in hoc
	celsius
	v 		(mV)
}


UNITS {
	(mA) = (milliamp)
	(mV) = (millivolt)
	(pS) = (picosiemens)
	(um) = (micron)
} 

ASSIGNED {
	i 		(mA/cm2)
	thegna		(mho/cm2)
	hinf tau1 tau2 
}
 

STATE { h1 h2 }

BREAKPOINT {
        SOLVE states METHOD derivimplicit
        thegna = gbar*(h1*frac + h2*(1-frac))
	i = thegna * (v - eh)
} 

INITIAL {
	trates(v)
	h1=hinf
	h2=hinf
}

DERIVATIVE states {   
        trates(v)      
		h1' = (hinf - h1)/tau1
		h2' = (hinf - h2)/tau2
}

PROCEDURE trates(v) {  
        LOCAL  qt
        qt=q10^((celsius-33)/10)  

        tau1 = bet1(v)/(qt*a01*(1+alp1(v)))
        tau2 = bet2(v)/(qt*a02*(1+alp2(v)))

	hinf = 1/(1+exp((v-thinf)/qinf))
}

FUNCTION alp1(v(mV)) {
  alp1 = exp(1.e-3*zeta1*(v-vhalf1)*9.648e4/(8.315*(273.16+celsius)))
}

FUNCTION bet1(v(mV)) {
  bet1 = exp(1.e-3*zeta1*gm1*(v-vhalf1)*9.648e4/(8.315*(273.16+celsius))) 
}

FUNCTION alp2(v(mV)) {
  alp2 = exp(1.e-3*zeta2*(v-vhalf2)*9.648e4/(8.315*(273.16+celsius))) 
}

FUNCTION bet2(v(mV)) {
  bet2 = exp(1.e-3*zeta2*gm2*(v-vhalf2)*9.648e4/(8.315*(273.16+celsius))) 
}
