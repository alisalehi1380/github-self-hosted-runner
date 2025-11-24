# GitHub Self‑Hosted Runner Dockerization 🚀🐳

[![Docker Pulls][docker-badge]][docker-url]
[![Build Status][build-badge]][build-file-url]

> [!WARNING]
> 🚧 This project is still in development (beta version).

Welcome to the GitHub Self‑Hosted Runner Dockerization project.

This repository provides a fully containerized solution for deploying and managing self‑hosted GitHub Actions runners using Docker.

## Features

- **Docker Compose Setup** – Easily deploy self‑hosted runners using Docker Compose.
- **Customizable** – Use the provided Docker image or build your own with the included Dockerfile.
- **Scalable** – Deploy multiple runner replicas with resource constraints.

## Getting Started

### Prerequisites

- Docker
- Docker Compose

1. **Clone the repository:**
   ```sh
   git clone https://github.com/alisalehi1380/github-self-hosted-runner.git
   cd github-self-hosted-runner
   ```

2. **Configure the environment variables:**  
   Copy the example environment file and edit it to specify your `REPO`, `GITHUB_PERSONAL_TOKEN`, and `RUNNER_NAME`.  
   Your [personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#about-personal-access-tokens) must have **"Administration"** repository permissions (write access).

   ```sh
   cp .env.example .env
   ```

3. **Deploy the self‑hosted runner:**
   ```sh
   docker-compose up -d
   ```

4. **Verify the runner:**  
   Once the container is up, go to your repository’s **Settings › Actions › Runners** page to confirm that the runner is registered and online.

[docker-badge]: https://img.shields.io/docker/pulls/alisalehi1380/github-actions
[docker-url]: https://hub.docker.com/r/alisalehi1380/github-actions
[build-badge]: https://github.com/alisalehi1380/github-self-hosted-runner/actions/workflows/build.yml/badge.svg
[build-file-url]: https://github.com/alisalehi1380/github-self-hosted-runner/actions/workflows/build.yml
