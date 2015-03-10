#
# jupyterhub
#
# https://github.com/echu/jupyterhub
#

# Base image
FROM ubuntu

# Update apt
RUN apt-get update

# Install git and curl
RUN apt-get install -y git curl

# Install python
RUN \
    apt-get install -y python3-dev python3 python python-dev

# Install pip by hand (to get latest)
RUN \
    curl -o get-pip.py https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    python3 get-pip.py

# Install node (this step isn't generic python... ::shrug::)
RUN \
    apt-get install -y npm nodejs-legacy && \
    npm install -g configurable-http-proxy

# Install Jupyter
RUN \
    git clone https://github.com/jupyter/jupyterhub && \
    cd jupyterhub && \
    pip3 install -r requirements.txt && \
    pip3 install . && \
    cd ..

# Add default user and password
RUN \
    groupadd -r jupyter && \
    useradd -r -g jupyter jupyter && \
    echo jupyter:jupyter | chpasswd && \
    mkdir /home/jupyter && \
    chown -R jupyter:jupyter /home/jupyter

RUN \
    pip3 install "ipython[notebook]" bokeh

# Install RISE for live slideshows, because we can!
RUN \
    git clone https://github.com/damianavila/RISE && \
    cd RISE && \
#    pip3 install -r requirements.txt && \
#    pip3 install . && \
    IPYTHONDIR=/home/jupyter/.ipython ipython profile create default && \
    IPYTHONDIR=/home/jupyter/.ipython python3 setup.py install && \
    chown -R jupyter /home/jupyter/.ipython && \
    cd ..


CMD ["jupyterhub"]

