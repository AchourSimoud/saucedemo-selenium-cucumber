# Utiliser une image Debian minimale
FROM debian:bullseye-slim

# Définir les variables d'environnement
ENV DEBIAN_FRONTEND=noninteractive
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

# Installer les dépendances nécessaires
RUN apt-get update && apt-get install -y \
    openjdk-11-jdk \
    maven \
    wget \
    curl \
    unzip \
    gnupg \
    ca-certificates \
    --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Installer git
RUN apt-get update && apt-get install -y git

# Installer Chrome
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && apt-get install -y google-chrome-stable

# Installer ChromeDriver
RUN CHROMEDRIVER_VERSION=$(curl -s "https://chromedriver.storage.googleapis.com/LATEST_RELEASE") && \
    CHROMEDRIVER_VERSION=114.0.5735.90 && \
    wget -q "https://chromedriver.storage.googleapis.com/${CHROMEDRIVER_VERSION}/chromedriver_linux64.zip" && \
    unzip chromedriver_linux64.zip && \
    mv chromedriver /usr/local/bin/ && \
    chmod +x /usr/local/bin/chromedriver && \
    rm chromedriver_linux64.zip


# Configurer le répertoire de travail
WORKDIR /app


# Définir le point d'entrée
CMD ["bash"]