FROM ubuntu:14.04

# Update and get Python, pip and other built tools
RUN apt-get update
RUN apt-get -y install sudo
RUN sudo apt-get -y update && sudo apt-get install -y build-essential bison flex libxml2 libxml2-dev libz-dev libglpk-dev zlib1g-dev libgmp3-dev libblas-dev liblapack-dev libarpack2-dev libcairo2-dev libffi-dev git libtool m4 automake
RUN git clone https://github.com/igraph/python-igraph.git && git clone https://github.com/statsmodels/statsmodels.git
RUN sudo apt-get -y install software-properties-common
RUN sudo add-apt-repository -y ppa:deadsnakes/ppa
RUN sudo apt -y install curl
RUN sudo apt-get -y update
RUN sudo apt-get -y install python3.6
RUN sudo curl https://bootstrap.pypa.io/ez_setup.py -o - | sudo python3.6
RUN sudo easy_install pip
RUN echo $(pip3 -V)

# Install Jupyter and libraries
#RUN pip3 install --upgrade pip
RUN echo $(pip3 -V)

RUN sudo apt-get install -y python3-setuptools
#RUN pip3 uninstall --yes setuptools
#RUN pip3 install setuptools
RUN pip3 install python-igraph
#RUN pip3 install --upgrade setuptools
RUN pip3 install cython jupyter cffi cairocffi numpy scipy 'pandas<0.20.0' xlrd matplotlib sklearn seaborn nltk gensim pyLDAvis wordcloud --ignore-installed six networkx mlxtend
RUN pip3 install statsmodels --upgrade
#RUN cd statsmodels && pip3 install .
#RUN rm -rf /tmp/statsmodels

RUN sudo apt-get -y install autotools-dev
RUN sudo apt-get -y install automake
RUN echo $(ls ./python-igraph)
#RUN cd python-igraph && ./bootstrap.sh && ./configure && make && make #install

# Add user, change to it and to working directory
RUN useradd -ms /bin/bash jupyter
USER jupyter
WORKDIR /home/jupyter

# Run Jupyter
CMD jupyter notebook --ip 0.0.0.0 --no-browser --allow-root
