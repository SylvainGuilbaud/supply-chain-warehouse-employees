ARG IMAGE=containers.intersystems.com/intersystems/iris:latest-em
FROM $IMAGE

USER root

COPY cert /opt/cert 

RUN apt-get update && apt-get install -y \
    # openjdk-21-jdk \
	sudo && \
	/bin/echo -e ${ISC_PACKAGE_MGRUSER}\\tALL=\(ALL\)\\tNOPASSWD: ALL >> /etc/sudoers && \
	sudo -u ${ISC_PACKAGE_MGRUSER} sudo echo enabled passwordless sudo-ing for ${ISC_PACKAGE_MGRUSER} && \
    chmod -R +rx /opt/cert

ENV EXTERNAL_DATA_DIRECTORY=/volumes/IRIS
RUN mkdir -p $EXTERNAL_DATA_DIRECTORY && chown -R ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_MGRUSER} $EXTERNAL_DATA_DIRECTORY

ENV ISC_PACKAGE_MGRUSER=irisowner
USER ${ISC_PACKAGE_MGRUSER}
WORKDIR /home/irisowner/dev

ENV PYTHON_PATH=/usr/irissys/bin/irispython
ENV SRC_PATH=/opt/irisapp
ENV IRISUSERNAME=SuperUser
ENV IRISPASSWORD=SYS
ENV IRISNAMESPACE=USER
# ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk-arm64/
# ENV JRE_HOME=/usr/lib/jvm/java-21-openjdk-arm64/
# ENV CLASSPATH=.:/usr/irissys/dev/java/lib/1.8/*
# ENV PATH="/home/irisowner/iris_env/bin:/home/irisowner/.local/bin:/usr/irissys/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/irisowner/bin:${JAVA_HOME}/bin:${PATH}"
ENV PATH="/home/irisowner/iris_env/bin:/home/irisowner/.local/bin:/usr/irissys/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/irisowner/bin"

COPY key/iris.key /usr/irissys/mgr/iris.key

RUN --mount=type=bind,src=.,dst=. \
    # export JAVA_HOME && \ 
    # export JRE_HOME && \
    # export CLASSPATH && \
    # python3 -m venv ~/py_envs && \
    # . ~/py_envs/bin/activate && \
    # pip3 install -r requirements.txt && \
    iris start IRIS && \
    iris merge IRIS ./build/merge-build-1.cpf && \
    iris session IRIS < ./build/iris-build.script && \
    iris merge IRIS ./build/merge-build-2.cpf && \
    iris stop IRIS quietly && \
    python3 -m pip install --target /usr/irissys/mgr/python pandas