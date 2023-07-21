FROM --platform=linux/amd64 public.ecr.aws/docker/library/ruby:3.2.1-alpine

# Install dependencies
RUN apk update && apk add --no-cache \
  build-base \
  postgresql-dev \
  tzdata \
  nodejs \
  yarn \
  libcurl \
  gcompat \
  chromium \
  chromium-chromedriver

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

EXPOSE 80 443
# Start the application
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3001", "-e", "production"]
