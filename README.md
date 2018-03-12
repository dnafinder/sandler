# sandler
Sandler's test for paired samples.<br/>
This file use the Sandler's test to evaluate if exist a difference after a
treatment. The Sandler's A-value can be transformed in the Student's t-value.

Syntax: 	SANDLER(X1,X2,ALPHA,TAIL)
     
    Inputs:
          X1 and X2 - data vectors (mandatory). 
          ALPHA - significance level (default = 0.05).
          TAIL - 1-tailed test (1) or 2-tailed test (2). (default = 1).
    Outputs:
          - A value.
          - t value.
          - degrees of freedom.
          - p-value.
          - Power

     Example: 

          X1=[77 79 79 80 80 81 81 81 81 82 82 82 82 83 83 84 84 84 84 85 ...
          85 86 86 87 87];

          X2=[82 82 83 84 84 85 85 86 86 86 86 86 86 86 86 86 87 87 87 88 ...
          88 88 89 90 90];

          Calling on Matlab the function: sandler(X1,X2)

          Answer is:

       A          t       DF    tail    alpha    p_value    Power
    ________    ______    __    ____    _____    _______    _____

    0.042097    21.396    24    1       0.05     0          1    
  
STATS=TESTT(...) returns a structure with all test(s) statistics

          Created by Giuseppe Cardillo
          giuseppe.cardillo-edta@poste.it

To cite this file, this would be an appropriate format:
Cardillo G. (2006). Sandler Test: a function to calculate the Sandler test for paired samples.
http://www.mathworks.com/matlabcentral/fileexchange/12700
