# ORIGINS
<img align="right" width="200" src="https://user-images.githubusercontent.com/40533412/165189419-0c5960a3-72ba-45c8-b91c-30c2713b5503.png">
R package that provides a function to compute activity of a Protein-protein Interaction Network (PPIN) asociated with differentiation for scRNA-seq data.
The differentiation PPIN is loaded within the package in the data directory.  

This package was originally created to identify stem and progenitor cells to select those cells as an origin when performing trajectory inference. 

## Installation

1. The remotes package is needed, if you don't have it type:

```
install.packages("remotes")
```

2. Once you have the remotes package installed you can install the origins package by typing:

```
remotes::install_github("danielasenraoka/ORIGINS")
```

## Example

1. Load origins:

```
library(ORIGINS)
```
2. Compute activity of a dataset. ```expression_matrix``` is a matrix or data frame, where each row is a gene and each column is a cell. ```differentiation_edges``` is a data frame containing the edges of the Protein-protein Interaction Network (PPIN) asociated with differentiation, it is already loaded within the package.

```
diff_activity <- activity(expression_matrix, differentiation_edges)
```

## Publication

If you use this code in your research, please cite our publication: [Senra, D., Guisoni, N., & Diambra, L. A. (2022). ORIGINS: A protein network-based approach to quantify cell pluripotency from scRNA-seq data. MethodsX, 9, 101778](https://www.sciencedirect.com/science/article/pii/S2215016122001583). 
Proper citation is essential for acknowledging the efforts and contributions of the original authors. Thank you!
