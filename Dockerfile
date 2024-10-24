# Użycie obrazu Eclipse Temurin jako bazowego
FROM eclipse-temurin:17-jdk-alpine

# Tworzenie wolumenu dla tymczasowych danych (nie jest to konieczne, ale typowe dla Spring Boot)
VOLUME /tmp

# Skopiowanie zbudowanego pliku JAR do kontenera
COPY target/todo-app-backend-0.0.1-SNAPSHOT.jar app.jar

# Ustawienie zmiennej środowiskowej dla portu, na którym ma nasłuchiwać aplikacja
ENV PORT=8080

# Ustawienie punktu wejścia dla uruchomienia aplikacji
ENTRYPOINT ["java", "-jar", "/app.jar"]
