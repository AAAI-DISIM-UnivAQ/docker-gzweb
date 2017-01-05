# Taken from http://github.com/osrf/docker_images/blob/master/gazebo/gazebo7/gzweb7/Dockerfile

# This is an auto generated Dockerfile for gazebo:gzweb7
# generated from templates/docker_images/create_gzweb_image.Dockerfile.em
# generated on 2016-10-13 17:16:25 +0000
FROM gazebo:libgazebo7
# originally from MAINTAINER Steven Peters scpeters+buildfarm@osrfoundation.org
MAINTAINER Giovanni De Gasperis giovanni@giodegas.it

# install packages
RUN apt-get update && apt-get upgrade -q-y & apt-get install -q -y \
    build-essential \
    cmake \
    imagemagick \
    libboost-all-dev \
    libgts-dev \
    libjansson-dev \
    libtinyxml-dev \
    mercurial \
    nodejs \
    nodejs-legacy \
    npm \
    pkg-config \
    psmisc\
    && rm -rf /var/lib/apt/lists/*

# install gazebo packages
RUN apt-get install -q -y \
    libgazebo7-dev=7.3.1* \
    && rm -rf /var/lib/apt/lists/*

# clone gzweb
RUN hg clone https://bitbucket.org/osrf/gzweb ~/gzweb

# build gzweb
RUN cd ~/gzweb \
    && hg up default \
    && ./deploy.sh -m

# setup environment
EXPOSE 8080
EXPOSE 7681

# run gzserver and gzweb
CMD ./root/gzweb/start_gzweb.sh && gzserver
