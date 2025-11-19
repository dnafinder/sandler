SANDLER — Sandler's Test for Paired Samples ⚖️📊

Overview
SANDLER is a MATLAB function that performs Sandler's test for paired data.  
It helps determine whether there is a systematic difference between two related
measurements, such as before vs after treatment. The function computes:

• Sandler's A value  
• The equivalent Student t statistic  
• Degrees of freedom  
• p-value  
• Approximate statistical power  

A clean summary table is displayed automatically, or a structured output can be
returned for further analysis.

Repository 🔗
https://github.com/dnafinder/sandler

Features ✨
• Works with any numeric paired vectors  
• Supports one-tailed and two-tailed tests  
• Configurable significance level alpha  
• Produces a structured output for automated workflows  
• Includes approximate statistical power estimation  
• No external dependencies beyond MATLAB + Statistics Toolbox  

Installation ⚙️
1. Download sandler.m from:
   https://github.com/dnafinder/sandler
2. Place it in any folder.
3. Add the folder to the MATLAB path:
     addpath('your_folder_here')
4. Verify installation:
     which sandler

Usage Example 📘
   x1 = [...];   % pre-treatment values
   x2 = [...];   % post-treatment values
   STATS = sandler(x1, x2);

If you do not request an output argument:
   sandler(x1, x2)
MATLAB will print a table containing A, t, DF, tail, alpha, p-value and power.

Input Arguments 🧩
x1     Paired numeric vector  
x2     Paired numeric vector (same length as x1)  
alpha  Optional significance level (default 0.05)  
tail   Optional: 1 for one-tailed, 2 for two-tailed (default 1)

Output Structure 📦
STATS.avalue   Sandler's A  
STATS.tvalue   t statistic  
STATS.tdf      degrees of freedom  
STATS.tail     number of tails used  
STATS.pvalue   p-value of the test  
STATS.power    approximate statistical power  

Interpretation 🧠
• p-value ≤ alpha → evidence of systematic difference between paired samples  
• Small A values correspond to larger t-values  
• Power is heuristic and intended only as an approximate sensitivity measure  

Citation 📝
Cardillo G. (2025). sandler: MATLAB implementation of Sandler's test for paired samples.  
Available at: https://github.com/dnafinder/sandler

Author 👤
Giuseppe Cardillo  
Email: giuseppe.cardillo.75@gmail.com  
GitHub: https://github.com/dnafinder

License 📄
See the LICENSE file in the GitHub repository.
