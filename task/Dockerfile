#FROM store/intersystems/iris-community:2020.3.0.221.0
FROM containers.intersystems.com/intersystems/iris-community:2023.1.0.229.0 

ARG COMMIT_ID="unknown"

USER root
ENV DEBIAN_FRONTEND noninteractive

# Install sftp
RUN apt-get update && apt-get install -y ssh sshpass
RUN echo "\n\
Match group sftp \n\
ChrootDirectory /home \n\
X11Forwarding no \n\
AllowTcpForwarding no \n\
ForceCommand internal-sftp \n\
" >> /etc/ssh/sshd_config
RUN addgroup sftp && useradd -m sftp_user -g sftp && echo "sftp_user:sftp_password" | chpasswd && chmod 777 /home/sftp_user/ && echo "irisowner:irisowner" | chpasswd && usermod -aG sftp irisowner

USER irisowner

ENV INSTSCRDIR=task
ENV SRCDIR=task/src
COPY Installer.cls $INSTSCRDIR/
COPY src $SRCDIR/

RUN  iris start $ISC_PACKAGE_INSTANCENAME \ 
 && printf 'Do ##class(Config.NLS.Locales).Install("jpuw") h\n' | iris session $ISC_PACKAGE_INSTANCENAME -U %SYS \
 && printf 'Set tSC=$system.OBJ.Load("'$HOME/$INSTSCRDIR'/Installer.cls","ck") Do:+tSC=0 $SYSTEM.Process.Terminate($JOB,1) h\n' | iris session $ISC_PACKAGE_INSTANCENAME \
 && printf 'Set tSC=##class(MyApps.Installer).setup("task","'$HOME/$SRCDIR'") Do:+tSC=0 $SYSTEM.Process.Terminate($JOB,1) h\n' | iris session $ISC_PACKAGE_INSTANCENAME \
 && iris stop $ISC_PACKAGE_INSTANCENAME quietly

#++ until imageBuildSteps.sh is chnaged++
# imageBuildSteps makes appuser 'ForceChangePassword' state....
RUN mkdir -p incoming/in \
 && iris start $ISC_PACKAGE_INSTANCENAME nostu quietly \
 && printf "kill ^%%SYS(\"JOURNAL\") kill ^SYS(\"NODE\") h\n" | iris session $ISC_PACKAGE_INSTANCENAME -B | cat \
 && iris stop $ISC_PACKAGE_INSTANCENAME quietly bypass \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/journal.log \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/IRIS.WIJ \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/iris.ids \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/alerts.log \
 && rm -f $ISC_PACKAGE_INSTALLDIR/mgr/journal/* 
#-- until imageBuildSteps.sh is chnaged--

USER root
#RUN /usr/irissys/dev/Container/imageBuildSteps.sh

# need to be root because $SRCDIR's owner is root:root.
RUN rm -rf $SRCDIR
USER irisowner
RUN echo $COMMIT_ID > $HOME/commit.txt
