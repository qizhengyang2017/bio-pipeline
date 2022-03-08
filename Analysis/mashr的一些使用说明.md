[[2021-09-12#mashr]]

[[2021-09-15]]

Use `get_pairwise_sharing` to assess sharing of significant signals among each pair of conditions. Here the default definition of shared is “the same sign and within a factor 0.5 of each other”.
 

Tissue activity of cis expression and splicing QTLs, where  an eQTL was considered active in a tissue if it had a mashr local false sign rate (LFSR, equivalent to FDR) of <5%. This is shown for all cis-QTLs and only those that could be tested in all 49 tissues (red and blue).

Step 4: Extract Posterior Summaries

重要的概念
Data-driven covariances



a vector of strings indicating the matrices to be used: "identity" for the identity (effects are independent among conditions); "singletons" for the set of matrices with just one non-zero entry x_jj = 1 (j=1,...,R); (effect specific to condition j); "equal_effects" for the matrix of all 1s (effects are equal among conditions); "simple_het" for a set of matrices with 1s on the diagonal and all off-diagonal elements equal to 0.25, 0.5 or 0.75; see cov_simple_het for details; (effects are correlated among conditions).


