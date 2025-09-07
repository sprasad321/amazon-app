# 1. Start with a base image
FROM ubuntu:24.04

# 2. Install Java (needed for Tomcat)
RUN apt-get update && apt-get install -y openjdk-11-jdk wget ca-certificates tar \
    && rm -rf /var/lib/apt/lists/*

# 3. Download and install Tomcat
RUN wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.108/bin/apache-tomcat-9.0.108.tar.gz -P /tmp \
    && tar xzvf /tmp/apache-tomcat-9.0.108.tar.gz -C /opt \
    && mv /opt/apache-tomcat-9.0.108 /opt/tomcat \
    && rm /tmp/apache-tomcat-9.0.108.tar.gz

# 4. Set working directory
WORKDIR /opt/tomcat

# 5. Copy your WAR file into Tomcat
COPY Amazon.war /opt/tomcat/webapps/

# 6. Expose port 8080 for Tomcat
EXPOSE 8080

# 7. Start Tomcat
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
