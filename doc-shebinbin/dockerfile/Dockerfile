# Dockerfile
FROM centos:latest

MAINTAINER SHEBINBIN "shebinbin@tech.cebbank.com"

RUN /bin/echo -e "LANG=\"en_US.UTF-8\"" > /etc/locale.conf
RUN /usr/bin/localedef -c -f UTF-8 -i en_US en_US.utf8 && export LC_ALL=en_US.UTF-8
RUN /bin/echo 'root:123456'|chpasswd && groupadd redis && useradd -g redis redis && /bin/echo 'redis:123456'|chpasswd
RUN mkdir -p /home/redis/app

WORKDIR /home/redis/app

ADD apache-tomcat-7.0.92.tar.gz .
ADD iammonitor.war /home/redis/app/apache-tomcat-7.0.92/webapps/iammonitor.war 
ADD jre_8_191.tar.gz .
RUN chown -R redis:redis /home/redis/app
#COPY jdk1.8.0_191 jdk1.8.0_191
USER redis

ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV JAVA_HOME=/home/redis/app/jdk1.8.0_191
ENV PATH=$JAVA_HOME/bin:$PATH
ENV CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

ENTRYPOINT /home/redis/app/apache-tomcat-7.0.92/bin/startup.sh && tail -f /home/redis/app/apache-tomcat-7.0.92/logs/catalina.out  
#ENTRYPOINT ["/home/redis/app/apache-tomcat19.0.92/bin/startup.sh", "run"]


#CMD ["/home/redis/app/apache-tomcat-7.0.92/bin/startup.sh","run"]

# CMD 启动时执行的命令
# EXPOSE 8080
# VOLUME
# USER
# WORKDIR
# ONBUILD

# 启动之后(docker run 之后)执行的命令
# ENTRYPOINT ["/bin/echo", "test",">","sdf.txt"]
