#
# jupyterhub
#
# https://github.com/echu/jupyterhub
#

# Base image
FROM ubuntu

# Update apt
RUN apt-get update

# Install git
RUN apt-get install -y git

# Install python
RUN \
    apt-get install -y python3-dev python3 python python-dev python-pip python3-pip

# Update pip
RUN \
    pip install -U pip

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

CMD ["jupyterhub"]


