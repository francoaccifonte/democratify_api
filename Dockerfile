# docker build ./ --rm -t accifontefranco/democratify:latest
FROM ruby:3.0.3-alpine

ARG BUNDLE_GITLAB__COM
ARG bundler_ignored_groups="development test"
ARG commit_sha
ARG port=3000
ARG sidekiq_env=production

ENV BUNDLE_WITHOUT=$bundler_ignored_groups
# ENV LANG=C.UTF-8
# ENV LC_ALL=C.UTF-8
# ENV IMAGE_TAG=$commit_sha
ENV SIDEKIQ_ENV=$sidekiq_env

RUN apk add --update --no-cache bash build-base libcurl git tzdata shared-mime-info postgresql-client postgresql-dev \
                                imagemagick ttf-liberation curl

RUN addgroup democratify
RUN adduser --disabled-password --ingroup democratify democratify

USER democratify
RUN mkdir $HOME/app
WORKDIR /home/democratify/app

COPY --chown=democratify:democratify Gemfile Gemfile.lock ./
RUN  bundle install

COPY --chown=democratify:democratify . .

EXPOSE $port
