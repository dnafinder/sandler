function STATS=sandler(x1,x2,varargin)
% Sandler's test for paired samples.
% This file use the Sandler's test to evaluate if exist a difference after a
% treatment. The Sandler's A-value can be transformed in the Student's t-value.
% 
% Syntax: 	SANDLER(X1,X2,ALPHA,TAIL)
%      
%     Inputs:
%           X1 and X2 - data vectors (mandatory). 
%           ALPHA - significance level (default = 0.05).
%           TAIL - 1-tailed test (1) or 2-tailed test (2). (default = 1).
%     Outputs:
%           - A value.
%           - t value.
%           - degrees of freedom.
%           - Critical value.
%           - p-value.
% 
%      Example: 
% 
%           X1=[77 79 79 80 80 81 81 81 81 82 82 82 82 83 83 84 84 84 84 85 ...
%           85 86 86 87 87];
% 
%           X2=[82 82 83 84 84 85 85 86 86 86 86 86 86 86 86 86 87 87 87 88 ...
%           88 88 89 90 90];
% 
%           Calling on Matlab the function: sandler(X1,X2)
% 
%           Answer is:
% 
%        A          t       DF    tail    alpha    p_value    Power
%     ________    ______    __    ____    _____    _______    _____
% 
%     0.042097    21.396    24    1       0.05     0          1    
%   
% STATS=SANDLER(...) returns a structure with all test(s) statistics
%
%           Created by Giuseppe Cardillo
%           giuseppe.cardillo-edta@poste.it
% 
% To cite this file, this would be an appropriate format:
% Cardillo G. (2006). Sandler Test: a function to calculate the Sandler test for paired samples.
% http://www.mathworks.com/matlabcentral/fileexchange/12700


%Input error handling
p = inputParser;
addRequired(p,'x1',@(x) validateattributes(x,{'numeric'},{'row','real','finite','nonnan','nonempty'}));
addRequired(p,'x2',@(x) validateattributes(x,{'numeric'},{'row','real','finite','nonnan','nonempty'}));
addOptional(p,'alpha',0.05, @(x) validateattributes(x,{'numeric'},{'scalar','real','finite','nonnan','>',0,'<',1}));
addOptional(p,'tail',1, @(x) isnumeric(x) && isreal(x) && isfinite(x) && isscalar(x) && (x==1 || x==2));
parse(p,x1,x2,varargin{:});
assert(length(p.Results.x1)==length(p.Results.x2))
x1=p.Results.x1; x2=p.Results.x2; alpha=p.Results.alpha; tail=p.Results.tail;
clear p

n=length(x1); %numbers of elements
d=x1-x2; %difference
A=sum(d.^2)/(sum(d)^2); %Sandler A-value
t=realsqrt((n-1)/(A*n-1)); %Student t-value
p=(1-tcdf(t,n-1))*tail; %t-value associated p-value
switch tail
    case 1
        if p>=alpha
            tp = tinv(1-alpha,n-1) - t;  %Power estimation.
            Power=1-tcdf(tp,n-1);
        else
            tp = t - tinv(1-alpha,n-1);  %Power estimation.
            Power=tcdf(tp,n-1);
        end
    case 2
        if p>=alpha
            tp1 = tinv(1-alpha/2,n-1) - t;  %Power estimation.
            tp2 = t + tinv(1-alpha/2,n-1);
            Power=2-tcdf(tp1,gl)-tcdf(tp2,n-1);
        else
            tb1=t - tinv(1-alpha/2,n-1);  %Power estimation.
            tb2=t + tinv(1-alpha/2,n-1);
            Power=1 - (tcdf(tb2,n-1)-tcdf(tb1,n-1));
        end
end

%display results
TBL=table(A,t,n-1,tail,alpha,p,Power);
TBL.Properties.VariableNames = {'A' 't' 'DF' 'tail' 'alpha' 'p_value' 'Power'};
disp(TBL)

if nargout
    STATS.avalue=A;
    STATS.tvalue=t;
    STATS.tdf=n-1;
    STATS.tail=tail;
    STATS.pvalue=p;
    STATS.power=Power;
end