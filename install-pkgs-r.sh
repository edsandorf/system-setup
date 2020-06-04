# Install basic R packages
#
# Description:
#   Whenever I do a fresh system install, I run this script. The script install.packages
#   the packages that I use most frequently.
#
# Author:
#   Erlend Dancke Sandorf <edsandorf [:at:] gmail.com>
#

# Set up a personal library, install packages and run IRkernel
R -e "dir.create(Sys.getenv('R_LIBS_USER'), recursive = TRUE);
      .libPaths(Sys.getenv('R_LIBS_USER'));
      install.packages(
        c(
          'tidyverse', 'lobstr', 'pryr', 'rlang', 'progress', 'R6',
          'dtplyr', 'dbplyr', 'crayon', 'bench', 'haven', 'lintr',
          'devtools', 'rsconnect', 'roxygen2', 'testthat', 'feather',
          'shiny', 'DT', 'shinyjs', 'shinyWidgets', 'janitor', 'broom',
          'knitr', 'rticles', 'bookdown', 'patchwork', 'pool', 'config',
          'kableExtra', 'patchwork',
          'aws.s3', 'RMariaDB', 'data.table',
          'maxLik', 'trustOptim', 'nloptr', 'numDeriv', 'ucminf',
          'Rfast', 'matrixStats',
          'apollo', 'gmnl', 'mlogit',
          'randtoolbox', 'cartography', 'sf', 'AER', 'car', 'psych',
          'xtable', 'microbenchmark', 'swirl', 'cli',
          'IRkernel', 'languageserver',
          'doParallel', 'foreach',
          'msm'
        ),
        repos = 'http://cran.rstudio.com'
      );
      IRkernel::installspec()"
