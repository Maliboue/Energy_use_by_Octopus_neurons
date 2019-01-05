TITLE Low voltage activated K+ current for octopus cells
:based on eqns from Rothman & Manis 2003c
:"The roles K_currents play in regulating the electrical activity of VCN neurons"

UNITS {
    (mV) = (millivolt)
    (mA) = (milliamp)
}

NEURON {
       SUFFIX Ikl 
       USEION k READ ek WRITE ik
       RANGE glt, gltma
       GLOBAL winf, zinf, tauw, tauz
}
   
PARAMETER {
       gltma = 0.016 (mho/cm2):  from Rothman & Manis 2003 
       ek = -77 (mV)
       zeta = 0.5 
   }
   
STATE { w z }

ASSIGNED {
         v (mV)
	 ik (mA/cm2)
	 glt (mho/cm2)
	 winf
	 zinf
	 tauw (ms)
	 tauz (ms)
     }
     
INITIAL {
	settables(v) 
        w = winf
	z = zinf		
    }
    
UNITSOFF
PROCEDURE settables(v (mV)) {
    
          TABLE winf, zinf, tauw, tauz FROM -100 TO 100 WITH 200
	  
	  winf = (1 / (1 + exp(-(v+48) / 6 ))^0.25)
	  tauw = (1.5 + 100 / (6*exp((v+60) / 6) + 16*exp(-(v+60) / 45)))

	  zinf = (zeta + (1-zeta) / (1 + exp((v+71) / 10)))
	  tauz = (50 + 1000 / (exp((v+60) / 20) + exp(-(v+60) / 8)))
      }
UNITSON
      
BREAKPOINT {
	   SOLVE states METHOD cnexp
	   glt = gltma*w*w*w*w*z
	   ik = glt*(v-ek)
       } 
       

DERIVATIVE states {
	    settables(v)
	    w' = ((winf-w)/tauw)
	    z' = ((zinf-z)/tauz)
	}
