# docker-gzweb
Docker image for robotics simulator Gazebo with a in-browser WebGL GUI

    docker pull giodegas/gzweb
    docker run -it -p 7681:7681 -p 8080:8080 --name gzweb giodegas/gzweb /bin/bash
    # ./root/gzweb/start_gzweb.sh && gzserver

