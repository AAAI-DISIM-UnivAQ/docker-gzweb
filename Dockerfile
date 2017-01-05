# derived from http://github.com/osrf/docker_images/blob/master/gazebo/gazebo7/gzweb7/Dockerfile

FROM gazebo:libgazebo7
# originally from MAINTAINER Steven Peters scpeters+buildfarm@osrfoundation.org
MAINTAINER Giovanni De Gasperis giovanni@giodegas.it

# install packages
RUN apt-get update && apt-get upgrade -q -y && apt-get install -q -y \
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
    libgazebo7-dev \
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

# make a missing folder
CMD mkdir /root/gzweb/http/client/assets
# download models & assets
CMD cd /root/gzweb && ./deploy.sh -m -t

# run gzserver and gzweb
# CMD ./root/gzweb/start_gzweb.sh && gzserver
