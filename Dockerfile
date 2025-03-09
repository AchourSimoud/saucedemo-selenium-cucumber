# Utiliser une image Debian légère comme base
FROM debian:bullseye-slim

# Mettre à jour les paquets et installer les dépendances nécessaires
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    gnupg \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Installer Java
RUN apt-get install -y openjdk-11-jdk

# Installer Maven
RUN apt-get install -y maven

# Installer Git
RUN apt-get install -y git

# Installer Google Chrome
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' \
    && apt-get update \
    && apt-get install -y google-chrome-stable \
    && rm -rf /var/lib/apt/lists/*

# Installer ChromeDriver
RUN CHROME_VERSION=$(google-chrome --version | grep -o '[0-9.]*' | head -1) \
    && CHROMEDRIVER_VERSION=$(curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE_$CHROME_VERSION) \
    && wget -O /tmp/chromedriver.zip https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip \
    && unzip /tmp/chromedriver.zip -d /usr/local/bin/ \
    && rm /tmp/chromedriver.zip

# Définir les variables d'environnement pour ChromeDriver
ENV CHROMEDRIVER_DIR /usr/local/bin
ENV PATH $CHROMEDRIVER_DIR:$PATH

# Exposer le port par défaut de ChromeDriver
EXPOSE 9515

# Définir le point d'entrée
ENTRYPOINT ["tail", "-f", "/dev/null"]
