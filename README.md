Spectrum sensing through Energy detection
=========================================
Project summary
----------------
This project compares different primary user(PU) energy detection techniques currently applied for **spectrum sensing**.
A PU is the entity to which a specific bandwidth has originally allocated. A secondary user(SU) is an entity who wishes to use the already allocated bandwidth temporarily. 
Once we establish PU is absent, the bandwidth allocated to SU. It is reallocated back to PU, whenever PU returns. 
Since PU is the actual intended user, care should be taken by the algorithm to _never_ allocate a bandwidth whenever he is present.
Also for the service providers to have profit, false positive(PU is absent but algo says present) should be _reduced_.

###Problem Formulation
  
* Hypothesis H1 - PU Present
     `y=x+n`
* Hypothesis H0 - PU Absent
     `y=n`   

where `y` is the energy detected, `x` is the PU's energy and `n` is the noise.

We generate an observation period of H1 signals and run monte-carlo simulation for each technique and evaluate them based on the graph of probability of detection(Pd) vs probability of false alarm(Pfa).
  
* `Pd=Pr{H1/H1}`
* `Pfa=Pr{H1/H0}`
 
The various Techniques used are-
###Classical energy detection#
In this technique, a fixed threshold is predefined and any signal greater than this value is ascertained as PU present and any value less than it as PU absent.
  
###General Energy Detection#
It is similar to CED, but instead of taking the square of the amplitude of energy signals, this technique raises it to power p(p belongs to {1,2,3,4,5})
  
###Modified Energy detection#
This technique focuses on reducing false negetive(Type II error). In certain cases a impulsive change in the environment variables might cause detected energy to drop below threshold. 
This technique keeps an average of the past few detected energies(`y_avg`) in history. 

`if y>T`

    PU is present
`else`
   ` if y_avg>T`
   
    PU is present
`else `

	PU is absent

###Improved Energy detection#
This is an improvement over MED. It focuses on redcing false alarms caused by MED. After checking  mean of past values, it also checks for one penultimate value and then decides.

###Variable Threshold Energy detection#
All the previous algorithm considered the threshold to be constant. This algorithm implements noise variance effect on threshold, increasing or decreasing it by a factor of rho depending on the past observations.

Usage 
------
Run the files ied.m, ged.m and untitled8.m for IED, GED and VT. CED is coded in all the files. you get comparision of each technique with CED. 






