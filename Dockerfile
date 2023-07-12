FROM rocker/rstudio

LABEL maintainer "Weiqiang Chen <weiqiang.chen@maxperutzlabs.ac.at>"

# install tinytex linux dependencies, pandoc, and rmarkdown
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    wget \
    graphviz \
    perl && \
    /rocker_scripts/install_pandoc.sh && \
    install2.r rmarkdown

# install tinytex
RUN Rscript -e 'tinytex::install_tinytex()'

# install r packages.
RUN Rscript -e "install.packages(c('tidyverse', 'ggfortify', 'fpc', 'RColorBrewer', 'dendextend', 'pals'));"
RUN R -e "install.packages('BiocManager'); library('BiocManager'); BiocManager::install(c('limma'))"



# copy the app to the image
RUN mkdir /home/rstudio/Cassiopeia_LFQ
COPY . /home/rstudio/Cassiopeia_LFQ

EXPOSE 8787

WORKDIR "/home/rstudio/Cassiopeia_LFQ"