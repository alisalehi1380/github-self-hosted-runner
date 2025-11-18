FROM ubuntu:20.04

ARG RUNNER_VERSION="2.329.0"
ARG RUNNER_HOME="/home/runner"
ARG DEBIAN_FRONTEND=noninteractive

# Update and upgrade the system
RUN apt update -y && apt upgrade -y

# Add a user named runner
RUN useradd -m runner

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
RUN cd ${RUNNER_HOME} \
    && mkdir actions-runner \
    && cd actions-runner \
    && curl -o actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && tar xzf actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

# Change ownership to runner user and install dependencies
RUN chown -R runner:runner ${RUNNER_HOME} && ${RUNNER_HOME}/actions-runner/bin/installdependencies.sh

# Copy the start script and make it executable
COPY --chmod=+x start.sh /start.sh

# Switch to runner user
USER runner

# Define the entrypoint
ENTRYPOINT ["/start.sh"]
