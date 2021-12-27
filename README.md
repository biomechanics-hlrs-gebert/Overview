# Gebert Doctoral Project Workflow and Programs

My doctoral project results in a biomechanical workflow, for which this GitHub organization. The repositories for publishing the results are owned by my personal profile and biomechanics-hlrs. 

Following notation is used to group parts of the workflow:
| A | Auxiliary programs and modules |
|---|--------------------------------|
| I | Image (pre) processing         |
| M | Mechanical computations        |
| P | Post processing                |

Example:
```M-DDTC-Directly-Discretizing-Tensor-Computation```

The subgroups themselves are not ordered. While the steps of the mechanical analyzation enforce a specific procedure of computations, the image pre-processing and the auxiliary resositories often can be viewed as stand-alone programs.

## Nomenclature of the data
All programs of my doctoral project rely on a data driven workflow. A deep-dive into it is found in [A-DDFF-Data-Driven-File-Format](https://github.com/biomechanics-hlrs-gebert/A-DDFF-Data-Driven-File-Format)

#### General layout:
```Image_Origin_Purpose_Application_Features.Suffix```  

##### Image
* Type of bone
* Consecutive number of the bones
* Consecutive number of its scan  

##### Origin  
* 'cl' - clinical computed tomography scan
* 'mu' - Microfocus computed tomography scan
* 'tc' - Test case

##### Purpose
* 'Dev' - (Development) Data set for general research
* 'Pro' - (Production) Data set for use in publications  

##### App
* Application that last modified the data set.

##### Features [Optional]
*  Space for entering parameters in case of smaller studies with different parameterizations. 

##### Suffix
* '*.raw' to mark the binary blob
* '*.meta' to mark the meta data file
* ALWAYS both of them are required as they are inherently separated  

### Examples  of the Nomenclature
```FH01s1_mu_Dev_Filters_G3S31Sig20.meta  & *.raw```
1. ```FH01-1``` Femoral Head 1, Scan 1
2. ```mu``` - Microfocus computed tomogrpahy scan
3. ```Dev``` - Dataset used for research
4. ```Filters``` - Dataset used to gather information of filtering images
5. ```G3S31Sig20``` - Specific parameters (3D Gauss, Kernel size 31, Sigma = 2.0)

```FH01s3_cl_Pro_Downscaling_SF15.meta  & *.raw```
1. ```FH01-3``` Femoral Head 1, Scan 3
2. ```mu``` - Clinical computed tomography scan
3. ```Pro``` - Dataset used for research
4. ```Downscaling``` - Dataset used to prove validity compare to a high resolution scan
5. ```SF15``` - Specific parameters (Scale factor = 15)

## Centralized Sources

All the repositories of this doctoral project rely on a couple of centralized sources to prevent diverging standard routines.

Add them as a subtree as follows:

```
cd <repository root>
git subtree add --prefix central_src git@github.com:biomechanics-hlrs-gebert/A-CESO-Central_Sources.git  main --squash```

## Biomechanics @ HLRS
All of this research is conducted at the *High-Performance Computing Center Stuttgart* (HLRS) in the department of *Numerical Methods and Libraries*. 
