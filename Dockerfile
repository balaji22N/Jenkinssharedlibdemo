FROM openjdk:8-jdk-alpine
WORKDIR /app
COPY ./target/kubernetes-configmap-reload-0.0.1-SNAPSHOT.jar  kubernetes-configmap-reload-0.0.1-SNAPSHOT.jar
#CMD ["java", "-jar", "app.jar"]
#CMD ["sleep", "1d"]
CMD ["java", "-jar", "kubernetes-configmap-reload-0.0.1-SNAPSHOT.jar"]
