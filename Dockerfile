# Mitato is a term meaning "shelter" or "lodging" in Greek.
# Starting from this base image includes a basic Linux distro with a lot of
# ML-related tools such as  TensorFlow2, Keras, pandas, scipy, scikit-learn,
# bokeh, hdf5, and Facets. Outside Jupyter it also has TeX Live, git, and vim.
# The default user is name `jovyan`.
FROM jupyter/datascience-notebook

# Jupyter has a couple visual modes, Lab shows tabs and a workspace browser.
ENV JUPYTER_ENABLE_LAB=yes

# Setting this environment variable prevents apt from asking for user input.
ENV DEBIAN_FRONTEND=noninteractive

# Jupyter Stacks unsets the user or something. Must reset to user root to 
# install more stuff.
USER root

# Get some basics that aren't already included. 
# RUN is a Docker instruction to execute a command in the image being built.
# The Bash pattern `first && second` means run `first` and then if it exits
# without error run `second`. The backslash is a bash line-continuation.
RUN apt-get update && \
    apt-get install -y screen vim wget curl rsync \
    ffmpeg \
    # OCaml
    opam \
    ocaml \
    # Add in Scheme based on https://github.com/sritchie/mit-scheme-docker/blob/master/mit-scheme/Dockerfile
    build-essential \
    libx11-dev \
    m4 \
    rlwrap \
    texinfo \
    texlive \
    # Smalltalk
    gnu-smalltalk

# NLTK

# From https://www.nltk.org/install.html, minus user param.
RUN pip install nltk

# From https://www.nltk.org/data.html.
RUN python -m nltk.downloader -d /usr/local/share/nltk_data all

# Make an environment variable for nltk to find the example data.
ENV NLTK_DATA=/usr/local/share/nltk_data

# Tensorflow extras. See https://www.tensorflow.org/hub.
RUN pip install "tensorflow>=2.0.0"
RUN pip install --upgrade tensorflow-hub

# Scheme

# Set up environment variables to make the installation easier.
ENV SCHEME_VERSION 10.1.11
ENV SCHEME_DIR mit-scheme-${SCHEME_VERSION}
ENV SCHEME_TAR ${SCHEME_DIR}-x86-64.tar.gz

WORKDIR /tmp

# Get MIT-Scheme and install all the goodies, docs included.
RUN wget http://ftp.gnu.org/gnu/mit-scheme/stable.pkg/${SCHEME_VERSION}/${SCHEME_TAR} \
  && wget http://ftp.gnu.org/gnu/mit-scheme/stable.pkg/${SCHEME_VERSION}/md5sums.txt \
  && cat md5sums.txt | awk '/${SCHEME_TAR}/ {print}' | tee md5sums.txt \
  && tar xf ${SCHEME_TAR} \
  && cd ${SCHEME_DIR}/src \
  && ./configure && make && make install \
  && cd ../doc \
  && ./configure && make && make install-info install-html install-pdf \
  && cd ../.. \
  && rm -rf ${SCHEME_DIR} ${SCHEME_TAR} md5sums.txt

# Create a couple wrapper scripts instead of https://github.com/sritchie/mit-scheme-docker/blob/master/mit-scheme/resources/with_rlwrap.sh.
RUN echo -e '#!/bin/bash\nsleep 0.2\nexec rlwrap "${@}"' > /usr/local/bin/with-rlwrap && \
    chmod +x /usr/local/bin/with-rlwrap && \
    echo -e '#!/bin/bash\nwith-rlwrap mit-scheme' > /usr/local/bin/scheme && \
    chmod +x /usr/local/bin/scheme

# Copy completions from the host machine into the Docker image.
# This makes it possible to hit tab and get autocomplete suggestions.
COPY ./resources/scheme/mit-scheme_completions.txt /home/jovyan/.mit-scheme_completions

# Set the user back to original one from Jupyter Stacks.
USER $NB_UID

WORKDIR /home/jovyan

# Download examples for all the different software environments.
RUN cd /home/jovyan/ && \
    # NLTK
    git clone --depth 1 https://github.com/hb20007/hands-on-nltk-tutorial.git && \
    # Tensorflow hub
    git clone https://github.com/tensorflow/hub.git tf-hub
    
# Expose the tensorboard port.
EXPOSE 6006

# Start a Jupyter server by default. More shells can be opened via SSH.
# --LabApp.token='' removes password requirement.
CMD ["start-notebook.sh", "--LabApp.token=''"]