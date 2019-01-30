FROM rhel7.5:1.0

# 首先确定容器的环境变量
ENV USERID appuser
ENV HOMEDIR /home/${USERID}
ENV CATALINA_HOME ${HOMEDIR}/tomcat-8
ENV LANG=zh_CN.UTF-8
ENV JAVA_HOME=${HOMEDIR}/jre8
ENV PATH=${CATALINA_HOME}/bin:${JAVA_HOME}/bin:$PATH
ENV CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

# 确定容器的工作目录
WORKDIR $HOMEDIR

# 添加文件至相应目录
ADD tomcat-8.tar.gz .
ADD jre8.tar.gz .
COPY iammonitor.war $CATALINA_HOME/webapps/iammonitor.war 

# 运行初始化容器的RUN命令
RUN groupadd ${USERID} && useradd -g ${USERID} ${USERID} -d $HOMEDIR && /bin/echo '${USERID}:123456'|chpasswd
RUN chown -R ${USERID}:${USERID} ${HOMEDIR}

# 服务执行用户
USER ${USERID}

# 执行服务
ENTRYPOINT ${CATALINA_HOME}/bin/startup.sh \
&& tail -f ${CATALINA_HOME}/logs/catalina.out
