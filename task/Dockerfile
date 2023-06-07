#FROM store/intersystems/iris-community:2020.3.0.221.0
FROM containers.intersystems.com/intersystems/iris-community:2023.1.0.229.0 

ARG COMMIT_ID="unknown"

USER root
ENV DEBIAN_FRONTEND noninteractive

# Install sftp
RUN apt-get update && apt-get install -y ssh sshpass
RUN echo "\n\
Match user sftp_user \n\
 ChrootDirectory /home/sftp_user \n\
 X11Forwarding no \n\
 AllowTcpForwarding no \n\
 ForceCommand internal-sftp -u 2 \n\
Match user sftp_user1 \n\
 ChrootDirectory /home/sftp_user1 \n\
 X11Forwarding no \n\
 AllowTcpForwarding no \n\
 ForceCommand internal-sftp -u 2 \n\
Match user sftp_user2 \n\
 ChrootDirectory /home/sftp_user2 \n\
 X11Forwarding no \n\
 AllowTcpForwarding no \n\
 ForceCommand internal-sftp -u 2 \n\
Match user sftp_user3 \n\
 ChrootDirectory /home/sftp_user3 \n\
 X11Forwarding no \n\
 AllowTcpForwarding no \n\
 ForceCommand internal-sftp -u 2 \n\
" >> /etc/ssh/sshd_config
RUN addgroup sftp_user && useradd -m sftp_user -g sftp_user && echo "sftp_user:sftp_password" | chpasswd && chown root:root /home/sftp_user && chmod 655 /home/sftp_user
RUN addgroup sftp_user1 && useradd -m sftp_user1 -g sftp_user1 && echo "sftp_user1:sftp_password" | chpasswd && chown root:root /home/sftp_user1 && chmod 655 /home/sftp_user1
RUN addgroup sftp_user2 && useradd -m sftp_user2 -g sftp_user2 && echo "sftp_user2:sftp_password" | chpasswd && chown root:root /home/sftp_user2 && chmod 655 /home/sftp_user2 
RUN addgroup sftp_user3 && useradd -m sftp_user3 -g sftp_user3 && echo "sftp_user3:sftp_password" | chpasswd && chown root:root /home/sftp_user3 && chmod 655 /home/sftp_user3 
RUN mkdir -p /home/sftp_user/incoming/in /home/sftp_user/incoming/arc /home/sftp_user/incoming/folder /home/sftp_user/incoming/common && chown -R sftp_user:sftp_user /home/sftp_user/incoming && chmod g+w /home/sftp_user/incoming/*
RUN mkdir -p /home/sftp_user1/incoming/in /home/sftp_user1/incoming/arc /home/sftp_user1/incoming/folder1 /home/sftp_user1/incoming/common && chown -R sftp_user1:sftp_user1 /home/sftp_user1/incoming && chmod g+w /home/sftp_user1/incoming/*
RUN mkdir -p /home/sftp_user2/incoming/in /home/sftp_user2/incoming/arc /home/sftp_user2/incoming/folder2 /home/sftp_user2/incoming/common && chown -R sftp_user2:sftp_user2 /home/sftp_user2/incoming && chmod g+w /home/sftp_user2/incoming/*
RUN mkdir -p /home/sftp_user3/incoming/in /home/sftp_user3/incoming/arc /home/sftp_user3/incoming/folder3 /home/sftp_user3/incoming/common && chown -R sftp_user3:sftp_user3 /home/sftp_user3/incoming && chmod g+w /home/sftp_user3/incoming/*
RUN addgroup sftp && echo "irisowner:irisowner" | chpasswd && usermod -aG sftp,sftp_user,sftp_user1,sftp_user2,sftp_user3 irisowner

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
RUN mkdir -p incoming/in outgoing \
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
RUN echo $COMMIT_ID > $HOME/commit.txt && chmod 664 commit.txt
