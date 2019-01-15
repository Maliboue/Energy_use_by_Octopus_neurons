# Metabolic energy usage by mammalian auditory brainstem octopus cells

This repository provides routines for simulation and metabolic energy usage assessment in Hodgkin-Huxley-type models of temporally-precise octopus-cells (OC) of the rodent auditory brainstem ventral cochlear nucleus.

Two types of published models are implemented: 
 - point model (along with the neighbouring neurons, bushy and stellate cells) (RM03)
 - distributed model of the OC with simplified morphology (Sp12)

Two methods for energy usage estimation are implemented as well:
 - ion-counting approach (AL01) (in the view of the uq. 4 in AL01 and the direct approach)
 - gradient-dissipation approach (Mouj11)

# Background

Neuronal activity (synaptic processing, spiking, holding of the resting potential, etc.) accounts for about 50% of total neuronal metabolic energy usage (Sokol77); it is entirely dependent on ion pumps that use ATP energy to continuously generate transmembrane electrochemical gradients that  constitute the driving force for ion currents through ion channels of the plasma membrane.

Two methods were suggested to estimate energy consumption related to the neuronal activity:

 - Ion-counting approach (AL01) in which number of ATP molecules is calculated from the number of Na+ ions that pass into a neuron during a signaling-related proces using the stoichiometry of the Na/K ATPase. There is alternative way to estimate ATP turnover using the eq. 4 presented in the AL01.

 - Gradient-dissipation method (Mouj11) which estimates change in transmembrane electrochemical gradient after a signaling process. It is estimated as amount of total heat dissipated by the equivalent electric circuit.

The jupyter notebooks (each for either point or the distributed models) provide systematic comparison of total resting and activity-related energy consumption of the OCs to other neurons of teh VCN, cerebral or cerebellar neocortexes (How12)

# Content

This repository contains an extension of the gradient-dissipating method with possibility to take into account mixed currents.

The ‘Distributed model’ Jupyter notebook contains a class OctopusCell that allows to create the model with standard parameters (Sp12) or altered. Activation of synapses can be either set to be ordered according to tonotopy of the auditory nerve fibers that innervate VCN, or random. Synapses are organised as ‘Exp2Syn’ objects driven by ‘NetStim’ via ‘NetCon’ objects from Neuron package.

# Dependencies

 - NEURON 7.6 (https://www.neuron.yale.edu/neuron/)
 - eFEL (https://github.com/BlueBrain/eFEL)
 - pandas (https://github.com/pandas-dev/pandas)

# References

 - AL01 — Attwell & Laughlin, 2001 -- An Energy Budget for Signaling in the Grey Matter of the Brain 
 - Mouj11 — Moujahid et al., 2011 -- Energy and information in Hodgkin-Huxley neurons 
 - Sokol77 — Sokoloff et al., 1977 -- THE [14C]DEOXYGLUCOSE METHOD FOR THE MEASUREMENT OF LOCAL CEREBRAL GLUCOSE UTILIZATION: THEORY, PROCEDURE, AND NORMAL VALUES IN THE CONSCIOUS AND ANESTHETIZED ALBINO RAT
 - How12 — Howarth et al., 2012 -- Updated energy budgets for neural computation in the neocortex and cerebellum 
 - Sp12 — Spencer et al., 2012 -- An investigation of dendritic delay in octopus cells of the mammalian cochlear nucleus 


