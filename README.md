# Extracting useful signals from flawed sensor data: developing hybrid data-driven approaches with physical factors

**Cheng Yang<sup>a</sup>, Glen T. Daigger<sup>a</sup>, Evangelia Belia<sup>a</sup>, B. Kerkez<sup>a</sup>**

<sup>a</sup> Civil and Environmental Engineering, University of Michigan, 2350 Hayward St, G.G. Brown Building, Ann Arbor, MI 48109, US  
<sup>b</sup> Primodal Inc., 145 Rue Aberdeen, Quebec City, Quebec, CA 

**Abstract:** Increased availability and affordability of sensors, especially water quality sensors, is poised to improve process control and modelling in water and wastewater systems. Sensor measurements are often flawed by unavoidable influent complexity and sensor instability, making extraction of useful signals problematic. Although a natural reaction is to put extra effort into sensor maintenance to achieve more reliable measurements, useful signals can be extracted from those unqualified signals by appropriate usage of available data-driven tools instructed by physical factors (e.g. prior process knowledge, physical constraints, phenomenal observations). Such methodology is herein defined as hybrid approaches. While the concept of coupling physical factors into data-driven tools is not new in downstream applications such as process modelling and control, little literature has explicitly applied it in the first and equally important step - signal processing.  With flawed influent five-day biochemical oxygen demand (BOD5) sensor measurements as an example, this paper provides a comprehensive case study demonstrating how physical factors were incorporated throughout the procedures of processing a flawed signal for its maximum value. Results showed that useful signals were extracted and validated via an assembly of well-established machine learning tools, whose performance was improved with physical factors. An Improved Standard Signal Processing Architecture (ISSPA) is also proposed based on the results of this research.  


<img align="center" src="Graphical Abstract.png" width="800">

**Publication DOI:** 

## Overview 
This repo provides the source code and implementation details of this paper. While the authors are not allowed to share meta-information of sensor data, the research data are anonymized without date and they have already been processed.

## Contents 

### Implementation 

`Paper_Code_Implementation.mlx` 

This MATLAB live script contains the implementation details of the paper, including the source codes that generating figures in the paper 

### Anonymous data 

- `xBOD.mat`, the dataset used in this study, whose rows are daily BOD5 sensor signal profiles. A 688-by-720 matrix. 
- `data_label.mat`, the labels of wheather a day is a clearn or dirty signal profile. `0` for clean and `1` for dirty. A 688-by-1 vector.
- `yBOD.mat`, the composite data analyzed by APHA methods. A 688-by-1 vector
- `xflow`, the realtime flow sensor measurements. A 688-by-720 matrix. 
- `xDiurnal.mat`, the separated daily diurnal patterns in this study. A 688-by-720 matrix 
- `xLeachate.mat`, the separated daily Leachate patterns in this study. A 688-by-720 matrix 

### Functions 
- `separatePattern.m` The function used to separate the diurnal patterns and leachate patterns in this paper. 
- `hhlsngd.m` Huber-Hinge least squares Nesterov's accelerate gradient descent function.  Used to solve the equation (3) in paper 
- `hubhin.m` The Huber-Hinge loss function. 
- `dhubhun.m` The derivative Huber-Hinge function. 
- `singleTSplot.m` A function to plot daily profiles, serves a purpose of formating the ticks, labels and axes in a figure. 
- `gapFilling.m` a data remediation algorithm to fill in large gaps in dirty signals.(Still under development). 


### Scripts 
`separatePatternScript.m` A script to separate all daily profiles. 


### Folders 
`688Results` 
- `clean` a folder stores pictures whose days are labelled as clean 
- `dirty` a folder stores pictures whose days are labelled as drity 
- `Misclassification cases` a folder stores misclassified results 
  - `Without SI - logistic regression on distribution` False negative + False postive cases
  - `With SI - logistic regression on distribution` Improved results with SI, False negative + False postive cases + reduced cases of False negative 
  
## Additional Note 
Related algorithms are highly customized for this study, including hyperparameters (e.g. the Fourier terms, Huber-Hinge regularization, penalty coefficient etc.) and the way functions are evaluated. Applying these algoritms to other studys requires additional and careful effort of customization. Besides, the gradient descent solver function `hhlsngd.m` is quite coarse and maybe unstable under some conditions.
