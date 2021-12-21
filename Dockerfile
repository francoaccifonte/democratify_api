# docker build ./ --rm -t accifontefranco/democratify_api:latest
# docker push accifontefranco/democratify_api:latest
FROM ruby:3.0.3-alpine as builder

ARG bundler_ignored_groups="development test"
ARG commit_sha
ARG port=3000

RUN apk add --update --no-cache bash build-base libcurl tzdata shared-mime-info postgresql-client postgresql-dev \
                                imagemagick ttf-liberation curl

RUN addgroup democratify
RUN adduser --disabled-password --ingroup democratify democratify

USER democratify
RUN mkdir $HOME/app
WORKDIR /home/democratify/app

COPY --chown=democratify:democratify Gemfile Gemfile.lock ./
# RUN bundle config set --local path 'vendor/bundle'
RUN bundle config set without $bundler_ignored_groups
RUN bundle install

COPY --chown=democratify:democratify . .

ARG port=3000
EXPOSE $port
