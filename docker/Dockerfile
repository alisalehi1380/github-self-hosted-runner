FROM ubuntu:20.04

LABEL maintainer="Ali Salehi <alisalehi.dev@gmail.com>"

ARG RUNNER_VERSION="2.329.0"
ARG DEBIAN_FRONTEND=noninteractive
ARG RUNNER_USERNAME="runner"
ARG RUNNER_HOME_PATH="/home/${RUNNER_USERNAME}"
ARG RUNNER_DIRECTORY="github-self-hosted-runner"

# Update and upgrade the system
RUN apt update -y && apt upgrade -y

# Add a user named runner
RUN useradd -m ${RUNNER_USERNAME}

# Install necessary packages & Docker CLI
RUN apt install -y --no-install-recommends \
    curl \
    build-essential \
    libssl-dev \
    libffi-dev \
    python3 \
    python3-venv \
    python3-dev \
    python3-pip \
    jq \
    docker.io

RUN apt-get -yqq install ssh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set up the actions runner
RUN cd ${RUNNER_HOME_PATH} && \
    mkdir ${RUNNER_DIRECTORY}  && \
    cd ${RUNNER_DIRECTORY} && \
    curl -sSL -o actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
    tar xzf actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
    rm actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

# Change ownership to runner user and install dependencies
RUN chown -R ${RUNNER_USERNAME}:${RUNNER_USERNAME} ${RUNNER_HOME_PATH} && ${RUNNER_HOME_PATH}/${RUNNER_DIRECTORY}/bin/installdependencies.sh

# Copy the start script and make it executable
COPY --chmod=+x start.sh /start.sh

# Switch to runner user
USER ${RUNNER_USERNAME}

# Define the entrypoint
ENTRYPOINT ["/start.sh"]
