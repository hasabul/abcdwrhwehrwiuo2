FROM centos:7

MAINTAINER Ha Hong Jung in UNIFOCOMPANY

# Set one or more individual labels
LABEL com.example.version="0.0.0-beta"
LABEL vendor="UNIFOCOMPANY"
LABEL com.example.release-date="2018-01-04"
LABEL com.example.version.is-production=""

RUN \
	echo "# MariaDB 10.3 CentOS repository list - created 2018-01-04 05:18 UTC" > /etc/yum.repos.d/mariadb.repo && \
	echo "# http://downloads.mariadb.org/mariadb/repositories/" >> /etc/yum.repos.d/mariadb.repo && \
	echo "[mariadb]">> /etc/yum.repos.d/mariadb.repo && \
	echo "name = MariaDB" >> /etc/yum.repos.d/mariadb.repo && \
	echo "baseurl = http://yum.mariadb.org/10.3/centos7-amd64" >> /etc/yum.repos.d/mariadb.repo && \
	echo "gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB" >> /etc/yum.repos.d/mariadb.repo && \
	echo "gpgcheck=1" >> /etc/yum.repos.d/mariadb.repo && \
	yum install -y MariaDB-server|tee -a /opt/result.log && yum clean all && \
	rm -rf /var/lib/mysql/* && \
	chown mysql:mysql /var/lib/mysql 
RUN	echo $(cat /opt/result.log |grep password|tail -1|awk '{print $5}') > /var/lib/mysql/access.info && \
	rm -rf /opt/result.log && \
	yum install -y epel-release && \
	yum -y install pwgen net-tools && \
	yum clean all
	

COPY container-files /
	
VOLUME /var/lib/mysql
EXPOSE 3306
CMD ["./run.sh"]
