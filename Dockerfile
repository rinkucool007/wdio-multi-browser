FROM ubuntu:22.04

ENV CHROMEDRIVER_VERSION LATEST

# Update package lists and install essential tools
RUN apt-get update && \
    apt-get install -y curl wget gnupg2 ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Node.js 19.x
RUN curl -fsSL https://deb.nodesource.com/setup_19.x | bash -
RUN apt-get update && \
    apt-get install -y nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Print installed Node.js and npm versions
RUN node -v && npm -v


# Install Google Chrome browser
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list

RUN apt-get update && \
    apt-get install -y google-chrome-stable && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Print installed versions for verification
RUN google-chrome-stable --version

RUN npm install -g allure-commandline

# Update package lists and install essential tools
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Verify installed Java version
RUN java -version && \
    javac -version

# Install MS Edge
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
RUN install -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/
RUN sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-beta.list'
RUN rm microsoft.gpg
RUN apt update
RUN apt install -y microsoft-edge-beta


WORKDIR /app
ADD . /app
RUN npm install

RUN chmod +x /app/script/run.sh