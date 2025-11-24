# Github Self‑Hosted Runner

[![Docker Pulls][docker-badge]][docker-url]
[![Build Status][build-badge]][build-file-url]

> [!WARNING]
> 🚧 This project is still in development (beta version).

Welcome to the GitHub Self‑Hosted Runner Dockerization project. 🚀🐳

This repository provides a fully containerized solution for deploying and managing self‑hosted GitHub Actions runners using Docker.

```bash
git clone https://github.com/alisalehi1380/github-self-hosted-runner.git
cd github-self-hosted-runner
cp .env.example .env
docker composer up -d
```


[docker-badge]: https://img.shields.io/docker/pulls/alisalehi1380/github-actions
[docker-url]: https://hub.docker.com/r/alisalehi1380/github-actions
[build-badge]: https://github.com/alisalehi1380/github-self-hosted-runner/actions/workflows/build.yml/badge.svg
[build-file-url]: https://github.com/alisalehi1380/github-self-hosted-runner/actions/workflows/build.yml
