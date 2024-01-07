# Rockolify

## Overview

Welcome to the Spotify Voting System repository! This project serves as my personal sandbox, where I experiment with new technologies and learn by implementing a fun and interactive voting system for Spotify playlists. The idea is to allow a host to choose a playlist, have the app randomly select songs from that playlist, and engage guests in a voting process where the winning song is queued to play next.

## Table of Contents

- [Features](#features)
- [Architecture](#architecture)
  - [Technology Stack](#technology-stack)
  - [Deployment with Terraform](#deployment-with-terraform)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)

## Features

<!-- TODO: change this boring generic list for screenshots -->
- Connects to Spotify to access playlists and songs.
- Randomly selects songs from a chosen playlist.
- Initiates a voting process among guests.
- Declares a winner a few seconds before the current song ends.
- Queues the winning song to play next on Spotify.

## Architecture

The Rockolify app is built as a Ruby on Rails application with a frontend powered by React components, rendered using the `react_on_rails` gem. The entire infrastructure is hosted on an EC2 instance, and the deployment and management of resources are handled through Terraform.

### Technology Stack

- **Ruby on Rails**: Both frontend and backend uses the RoR framework, and asynchronous jobs are executed using `sidekiq`.

- **React with `react_on_rails`**: Originally the frontend was a React SPA, meant to interact with the backend API through the JS fetch api. I decided to make this project a monolith wich serves the front end using the `react_on_rails` gem. This made the infra a lot easier to manage.

- **EC2 Instance**: The application is hosted on an AWS EC2 instance. Since it's a classic rails monolith, we only need a simple container to run the app, and one additional one to run the sidekiq jobs.

- **Terraform**: The infrastructure is described as code using Terraform. This enables me to spin up the complete infrastructure reliably, and not having to click around for hours whenever I want to showcase the app

### Deployment with Terraform

The `infra` directory contains the Terraform configuration files that define the infrastructure. These files describe the AWS resources needed, such as the EC2 instance, security groups, database, and other dependencies.

I never got around to automating the deployment process, so it's a manual `terraform apply` at the moment.
## Getting Started

### Prerequisites

TODO

### Installation
TODO


## Useful Snippets
### Debugging console logs from the selenium chrome driver
In your js code, put a bunch of `console.warn('whatever')`
retrieve logs with `page.driver.browser.logs.get(:browser)`
### Monitor tests log:
tail -f log/test.log