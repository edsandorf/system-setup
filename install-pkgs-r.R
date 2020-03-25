# Install basic R packages
#
# Description:
#   Whenever I do a fresh system install, I run this script. The script install.packages
#   the packages that I use most frequently.
#
# Author:
#   Erlend Dancke Sandorf <edsandorf [:at:] gmail.com>
#

# List packages ----
pkgs <- c(
  # Tidyverse
  "tidyverse", "lobstr", "pryr", "rlang", "progress", "R6",
  "dtplyr", "dbplyr", "crayon", "bench", "haven", "lintr",
  "devtools", "rsconnect", "roxygen2", "testthat", "feather",
  "shiny", "DT", "shinyjs", "shinyWidgets", "janitor",
  "knitr", "komadown", "bookdown", "patchwork", "pool", "config",
  # Markdown packages
  "kableExtra",
  # Database packages
  "aws.s3", "RMariaDB", "data.table",
  # Optimizers
  "maxLik", "trustOptim", "nloptr", "numDeriv", "ucminf",
  # Matrix operations
  "Rfast", "matrixStats",
  # Choice modelling
  "apollo", "gmnl", "mlogit",
  # Other
  "randtoolbox", "cartography", "sf", "AER", "car", "psych",
  "xtable", "microbenchmark", "swirl", "cli",
  # Atom related packages
  "IRkernel", "languageserver"
)

# Install packages ----
invisible(lapply(pkgs, install.packages, character.only = TRUE))

# Call out the warnings
warnings()
