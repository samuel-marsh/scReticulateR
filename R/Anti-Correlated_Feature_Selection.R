#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#################### Anti-Correlated Feature Selection ####################
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


# Package & Method Information ----------------------------------------------------------------
# For details of method see original publication:
    # Tyler, S.R., Lozano-Ojalvo, D., Guccione, E. et al. Anti-correlated feature selection prevents false
    # discovery of subpopulations in scRNAseq. Nat Commun 15, 699 (2024). https://doi.org/10.1038/s41467-023-43406-

# Required Python Installations
    # https://bitbucket.org/scottyler892/pyminer_norm/src/master/
    # python3 -m pip install bio-pyminer-norm
    # OR
    # reticulate::py_install("pyminer_norm")

    # https://bitbucket.org/scottyler892/anticor_features/src/main/
    # python3 -m pip install anticor_features
    # OR
    # reticulate::py_install("anticor_features")



# Run pyminer_norm ----------------------------------------------------------------------------

# COMING SOON


# Run anticor features: --------------------------------------------------------------------------------
# Scripts are for use with Seurat Objects


anti_cor_features <- function(
    seurat_object,
    features = NULL,
    species
) {
  # Check reticulate installed
  reticulate_check <- rlang::is_installed(pkg = "reticulate")
  if (isFALSE(x = reticulate_check)) {
    cli::cli_abort(message = c(
      "Please install the {.val reticulate} package to use {.code as.anndata}.",
      "i" = "This can be accomplished with the following commands: ",
      "----------------------------------------",
      "{.field `install.packages({symbol$dquote_left}reticulate{symbol$dquote_right})`}",
      "----------------------------------------"
    ))
  }

  # species
  if (species == "human") {
    species_use <- "hsapiens"
  }

  # features to use
  features_use <- features %||% Seurat::Features(seurat_object)

  # Python Package Import
  pd <- reticulate::import("pandas", convert = FALSE)
  anti_corr <- reticulate::import("anticor_features.anticor_features", convert = FALSE)
  pyminer_norm <- reticulate::import("pyminer_norm.downsample", convert = FALSE)

  # Get count data
  count_matrix <- LayerData(object = object)

  # Run anticor
  res <- anti_corr$get_anti_cor_genes(object,
                                      features,
                                      species=species_use)

  # convert for R output
  res_r <- reticulate::py_to_r(res)

  # return results
  return(res_r)
}
