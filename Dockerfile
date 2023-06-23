FROM --platform=linux/amd64 ruby:3.2.1-alpine

ENV SPOTIFY_CLIENT_ID
ENV SPOTIFY_SECRET
ENV SENTRY_DSN

# Install dependencies
RUN apk update && apk add --no-cache \
  build-base \
  postgresql-dev \
  tzdata \
  nodejs \
  yarn \
  libcurl \
  gcompat

WORKDIR /home/democratify

# Install gems
COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v $(tail -n1 Gemfile.lock)
RUN bundle install

# Install Node.js packages
COPY package.json yarn.lock ./
RUN yarn install --check-files

# Copy the application code
COPY . .

# Precompile assets
RUN bundle exec rails assets:precompile

# Start the application
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3001", "-e", "production"]
