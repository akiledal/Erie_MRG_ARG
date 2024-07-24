# Analysis of select antimicrobial and metal resistance genes in Lake Erie

Code in this repository was used to conduct analyses of antimicrobial and metal resistance genes in metagenomic datasets and generate figures for Reddy & Kiledal (2024).

Snakemake was used to process metagenomic datasets collected from the Great Lakes Atlas of Multi-omics Research [GLAMR](http://greatlakesomics.org). As such, most initial data processing steps are contained in the Snakefile. Subsequent summarization, statistical analysis, and figure generation were conducted with R and code can be found in .Rmd files in the [code](/code) directory.

---

*N.B. The code contained here is largely the work of Saahith Reddy with supervision by Anders Kiledal (kiledal@umich.edu), who also assisted with upload to GitHub.*