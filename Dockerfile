FROM centos:centos6.9
LABEL author="hunna"	\
	  mail="seunghun.chan@gmail.com"

WORKDIR /opt

ENV CUBRID=/opt/CUBRID
ENV CUBRID_DATABASES=$CUBRID/databases
ENV CUBRID_CHARSET=en_US
ENV PATH=$CUBRID/bin:$CUBRID/cubridmanager:$PATH
ENV LD_LIBRARY_PATH=$CUBRID/lib:$LD_LIBRARY_PATH

RUN yum update -y && \
    yum install -y wget && \
    yum install -y tar

RUN wget ftp://ftp.cubrid.org/CUBRID_Engine/10.1/CUBRID-10.1.0.7663-1ca0ab8-Linux.x86_64.tar.gz
RUN tar xfz CUBRID-10.1.0.7663-1ca0ab8-Linux.x86_64.tar.gz
RUN mkdir -p $CUBRID_DATABASES/demodb
RUN cubrid createdb --db-volume-size=20M --log-volume-size=20M -F $CUBRID_DATABASES/demodb demodb en_US && \
	cubrid loaddb -u dba -s $CUBRID/demo/demodb_schema -d $CUBRID/demo/demodb_objects demodb

VOLUME ["/opt/CUBRID/log/"]

EXPOSE 8001 30000 33000

CMD cubrid service start && cubrid server start demodb && tail -f $CUBRID/log/server/*.err && tail -f $CUBRID/log/broker/sql_log/*.sql.log
