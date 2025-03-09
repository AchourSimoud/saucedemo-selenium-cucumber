# Utiliser une image Debian minimale
FROM debian:bullseye-slim

# Set the user to root
USER root


# Définir les variables d'environnement
ENV DEBIAN_FRONTEND=noninteractive
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV XDG_CACHE_HOME=/tmp/.cache

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
    wget -q "https://chromedriver.storage.googleapis.com/${CHROMEDRIVER_VERSION}/chromedriver_linux64.zip" && \
    unzip chromedriver_linux64.zip && \
    mv chromedriver /usr/local/bin/chromedriver && \
    chmod +x /usr/local/bin/chromedriver && \
    rm chromedriver_linux64.zip

# Créer l'utilisateur seluser
RUN useradd -m -s /bin/bash seluser

# Ajouter un volume pour le ChromeDriver
# Ce volume permet de monter un répertoire local contenant chromeDriver à l'intérieur du conteneur
VOLUME ["/drivers:/usr/local/bin/chromedriver"]
VOLUME ["/home/seluser/.cache/selenium/chrome/user-data:/home/seluser/.cache/selenium/chrome/user-data"]

# Créer le répertoire de cache pour Selenium et ajuster les permissions
RUN mkdir -p /home/seluser/.cache/selenium && \
    chown -R seluser:seluser /home/seluser/.cache/selenium

# Revenir à l'utilisateur selenium pour exécuter Selenium en toute sécurité
USER seluser

# Exposer le port WebDriver
EXPOSE 4444