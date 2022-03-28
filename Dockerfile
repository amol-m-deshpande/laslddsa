FROM quay.io/eclipse/che-nodejs12-community:7.37.2

USER root

RUN apt update && apt -y upgrade
RUN apt install -y curl sudo
RUN apt-get install -y make build-essential libssl-dev zlib1g-dev \
       libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
       libncurses5-dev libncursesw5-dev xz-utils tk-dev
RUN wget https://www.python.org/ftp/python/3.8.10/Python-3.8.10.tgz
RUN tar xvf Python-3.8.10.tgz
RUN Python-3.8.10/configure --enable-optimizations --with-ensurepip=install
RUN make -j 8
RUN make altinstall
RUN rm -rf Python-3.8.10.tgz
RUN rm -rf Python-3.8.10

RUN curl -sL https://raw.githubusercontent.com/IBM-Cloud/ibm-cloud-developer-tools/master/linux-installer/idt-installer | bash
RUN find /home/user/.bluemix -type d -exec chmod 777 {} \;
RUN find /home/user/.bluemix -type f -exec chmod 777 {} \;

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN sudo ./aws/install


RUN wget https://github.com/IBM/cpdctl/releases/download/v1.1.132/cpdctl_linux_amd64.tar.gz 
RUN tar zxf cpdctl_linux_amd64.tar.gz
RUN cp cpdctl /usr/local/bin/
COPY github.sh /
# RUN chown root: /usr/local/bin/gitinit

CMD sleep infinity