FROM debian:slim

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install essential packages, Java, Maven, and Chrome dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    gnupg \
    ca-certificates \
    curl \
    unzip \
    openjdk-17-jdk \
    maven \
    libglib2.0-0 \
    libnss3 \
    libgconf-2-4 \
    libfontconfig1 \
    && rm -rf /var/lib/apt/lists/*

# Installer git
RUN apt-get update && apt-get install -y git

# Install Chrome (needed for ChromeDriver)
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
    && apt-get update \
    && apt-get install -y google-chrome-stable \
    && rm -rf /var/lib/apt/lists/*

# Install ChromeDriver
# Note: This gets the latest version. You might want to pin to a specific version for stability
RUN CHROME_VERSION=$(google-chrome --version | awk -F '[ .]' '{print $3"."$4"."$5}') \
    && CHROMEDRIVER_VERSION=$(curl -s "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$CHROME_VERSION") \
    && wget -q "https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip" \
    && unzip chromedriver_linux64.zip \
    && mv chromedriver /usr/local/bin/chromedriver \
    && chmod +x /usr/local/bin/chromedriver \
    && rm chromedriver_linux64.zip

# Verify installations
RUN java -version && mvn -version && chromedriver --version

# Set working directory
WORKDIR /app

# Keep container running (optional, for debugging)
# CMD ["tail", "-f", "/dev/null"]