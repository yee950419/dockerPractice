FROM amazoncorretto:17
ARG JAR_PATH=./build/libs
ARG JAR_FILE=docker-0.0.1-SNAPSHOT.jar
COPY ${JAR_PATH}/${JAR_FILE} ${JAR_PATH}/dockertest.jar
ENTRYPOINT ["java","-jar","./build/libs/dockertest.jar"]