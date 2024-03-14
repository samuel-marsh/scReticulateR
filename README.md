
# scReticulateR

Scripts for passing single cell analyses from R objects to python
packages and back.

## Required packages

In order to run these scripts users must have python installed. The
following R packages are required for communication with python
installation and running scripts.

    # Install R packages
    install.packages("Seurat")
    install.packages("scCustomize")
    install.packages("reticulate)

## Python Packages

Scripts are present for the following python packages/workflows:  
- anticor/pyminer_norm (Detection of anticorrelated features).  
- scDRS (Calculate disease relevance score at single cell level).  
- More to come!

## Full Package

Time permitting (and approved by original authors) I may turn this repo
into R package, ideally on CRAN. However, for now code can be copied
from provided scripts.
