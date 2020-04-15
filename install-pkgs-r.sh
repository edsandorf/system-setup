# Install basic R packages
#
# Description:
#   Whenever I do a fresh system install, I run this script. The script install.packages
#   the packages that I use most frequently.
#
# Author:
#   Erlend Dancke Sandorf <edsandorf [:at:] gmail.com>
#

# Set up a personal library
R -e "dir.create(Sys.getenv('R_LIBS_USER'), recursive = TRUE);
      .libPaths(Sys.getenv('R_LIBS_USER'))"

# Execute the following R command
R -e "install.packages(
  c(
    'tidyverse', 'lobstr', 'pryr', 'rlang', 'progress', 'R6',
    'dtplyr', 'dbplyr', 'crayon', 'bench', 'haven', 'lintr',
    'devtools', 'rsconnect', 'roxygen2', 'testthat', 'feather',
    'shiny', 'DT', 'shinyjs', 'shinyWidgets', 'janitor',
    'knitr', 'komadown', 'bookdown', 'patchwork', 'pool', 'config',
    'kableExtra',
    'aws.s3', 'RMariaDB', 'data.table',
    'maxLik', 'trustOptim', 'nloptr', 'numDeriv', 'ucminf',
    'Rfast', 'matrixStats',
    'apollo', 'gmnl', 'mlogit',
    'randtoolbox', 'cartography', 'sf', 'AER', 'car', 'psych',
    'xtable', 'microbenchmark', 'swirl', 'cli',
    'IRkernel', 'languageserver'
  ),
  repos = 'http://cran.rstudio.com'
)"

# Install the Jupyter kernel for current user only
R -e "IRkernel::installspec()"
