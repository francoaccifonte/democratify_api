# FROM ruby:3.2.1-alpine as builder

# # RUN apk add --update --no-cache bash build-base libcurl tzdata shared-mime-info postgresql-client postgresql-dev \
# #                                 imagemagick ttf-liberation curl

# WORKDIR /home/democratify
# COPY ./ ./
# # RUN apk add --update nodejs=16.14.2
# RUN bundle install
# RUN yarn install




################################################# 
# FROM --platform=linux/amd64 ruby:3.2.1-alpine as builder
# RUN apt-get update && apt-get install -y build-essential libpq-dev
# RUN apk add --update --no-cache postgresql-client postgresql-dev
# WORKDIR /home/democratify
# COPY Gemfile Gemfile.lock ./
# RUN gem install bundler -v $(tail -n1 Gemfile.lock)
# RUN bundle pack



FROM --platform=linux/amd64 ruby:3.2.1-alpine

# Install dependencies
RUN apk update && apk add --no-cache \
  build-base \
  postgresql-dev \
  tzdata \
  nodejs \
  yarn

WORKDIR /home/democratify

# Install gems
COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v $(tail -n1 Gemfile.lock)
# RUN bundle config build.pg --with-pg-config=/usr/bin/pg_config
RUN bundle install

# Install Node.js packages
COPY package.json yarn.lock ./
RUN yarn install --check-files

# Copy the application code
COPY . .

# Precompile assets
RUN bundle exec rails assets:precompile

# Start the application
CMD ["bundle", "exec", "rails", "server", "-p", "3001"]
