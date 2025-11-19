function STATS = sandler(x1, x2, varargin)
%SANDLER Sandler's test for paired samples.
%
%   Syntax:
%       sandler(x1, x2)
%       sandler(x1, x2, alpha)
%       sandler(x1, x2, alpha, tail)
%       STATS = sandler(___)
%
%   Description:
%       SANDLER performs Sandler's test for paired samples to assess whether
%       there is a systematic difference between two paired measurements
%       (e.g., before vs after a treatment). The test computes Sandler's
%       A-value from the pairwise differences and then transforms it into
%       the Student's t statistic. The corresponding p-value and an
%       approximate statistical power are also reported.
%
%   Inputs:
%       x1      - Numeric vector of observations (first condition).
%       x2      - Numeric vector of observations (second condition).
%       alpha   - (Optional) Significance level. Default = 0.05.
%       tail    - (Optional) 1 for one-tailed test (default), 2 for two-tailed.
%
%   Outputs:
%       STATS.avalue   - Sandler's A value
%       STATS.tvalue   - t statistic
%       STATS.tdf      - degrees of freedom
%       STATS.tail     - number of tails
%       STATS.pvalue   - p-value
%       STATS.power    - approximate power
%
%   Example:
%       x1 = [77 79 79 80 80 81 81 81 81 82 82 82 82 83 83 84 84 84 84 85 ...
%             85 86 86 87 87];
%       x2 = [82 82 83 84 84 85 85 86 86 86 86 86 86 86 86 86 87 87 87 88 ...
%             88 88 89 90 90];
%       STATS = sandler(x1, x2);
%
%   GitHub:
%       https://github.com/dnafinder/sandler
%
%   Citation:
%       Cardillo G. (2025). sandler: MATLAB implementation of Sandler's test
%       for paired samples. Available at:
%       https://github.com/dnafinder/sandler
%
%   License:
%       Distributed under the terms of the repository license.
%
%   Author:
%       Giuseppe Cardillo
%       giuseppe.cardillo.75@gmail.com

% -----------------------------
% Input parsing and validation
% -----------------------------
p = inputParser;

addRequired(p, 'x1', @(x) validateattributes(x, ...
    {'numeric'}, {'vector','real','finite','nonnan','nonempty'}));
addRequired(p, 'x2', @(x) validateattributes(x, ...
    {'numeric'}, {'vector','real','finite','nonnan','nonempty'}));

addOptional(p, 'alpha', 0.05, @(x) validateattributes(x, ...
    {'numeric'}, {'scalar','real','finite','nonnan','>',0,'<',1}));

addOptional(p, 'tail', 1, @(x) isnumeric(x) && isscalar(x) && any(x == [1 2]));

parse(p, x1, x2, varargin{:});
x1    = p.Results.x1(:);
x2    = p.Results.x2(:);
alpha = p.Results.alpha;
tail  = p.Results.tail;

if numel(x1) ~= numel(x2)
    error('sandler:InputSizeMismatch', ...
        'x1 and x2 must contain the same number of elements.');
end

% -----------------------------
% Core test computations
% -----------------------------
n  = numel(x1);
df = n - 1;

d = x1 - x2;
sum_d  = sum(d);
sum_d2 = sum(d.^2);

if sum_d == 0
    warning('sandler:ZeroSumDifferences', ...
        'Sum of differences is zero; results may be unreliable.');
end

A = sum_d2 / (sum_d^2);
t = sqrt(df / (A*n - 1));

% -----------------------------
% p-value calculation
% -----------------------------
switch tail
    case 1
        pval = 1 - tcdf(t, df);
    case 2
        pval = 2 * (1 - tcdf(abs(t), df));
end

% -----------------------------
% Approximate power calculation
% -----------------------------
switch tail
    case 1
        crit = tinv(1 - alpha, df);
        if pval >= alpha
            tp = crit - t;
            Power = 1 - tcdf(tp, df);
        else
            tp = t - crit;
            Power = tcdf(tp, df);
        end
    case 2
        crit = tinv(1 - alpha/2, df);
        if pval >= alpha
            tp1 = crit - t;
            tp2 = t + crit;
            Power = 2 - tcdf(tp1, df) - tcdf(tp2, df);
        else
            tb1 = t - crit;
            tb2 = t + crit;
            Power = 1 - (tcdf(tb2, df) - tcdf(tb1, df));
        end
end

% -----------------------------
% Display table
% -----------------------------
if nargout == 0
    TBL = table(A, t, df, tail, alpha, pval, Power, ...
        'VariableNames', {'A','t','DF','tail','alpha','p_value','Power'});
    disp(TBL)
end

% -----------------------------
% Build output structure
% -----------------------------
if nargout > 0
    STATS.avalue = A;
    STATS.tvalue = t;
    STATS.tdf    = df;
    STATS.tail   = tail;
    STATS.pvalue = pval;
    STATS.power  = Power;
end

end
