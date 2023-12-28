# 베이스 이미지를 설정합니다. 여기서는 OpenJDK 8을 사용합니다.
FROM openjdk:17-ea-3-jdk-slim

# Gradle 빌드를 위해 필요한 환경 변수를 설정합니다.
ENV GRADLE_HOME /opt/gradle
ENV GRADLE_VERSION 7.2

# Gradle 빌드 도구를 다운로드하고 설치합니다.
RUN set -o errexit -o nounset \
    && echo "Downloading Gradle" \
    && wget --no-verbose --output-document=gradle.zip "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" \
    && echo "Installing Gradle" \
    && unzip gradle.zip \
    && rm gradle.zip \
    && mv "gradle-${GRADLE_VERSION}" "${GRADLE_HOME}/" \
    && ln --symbolic "${GRADLE_HOME}/bin/gradle" /usr/bin/gradle \
    && printf "Done installing Gradle\n"

# 작업 디렉토리를 설정합니다.
WORKDIR /app

# 호스트 OS의 프로젝트 디렉토리를 Docker 컨테이너의 작업 디렉토리에 복사합니다.
COPY . .

# Gradle 빌드를 수행합니다.
RUN gradle build --no-daemon

# 빌드 결과물인 jar 파일을 실행합니다.
ENTRYPOINT ["java","-jar","/app/build/libs/docker-0.0.1-SNAPSHOT.jar"]
