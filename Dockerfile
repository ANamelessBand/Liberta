FROM ruby:2.6.0-alpine3.8

RUN apk add --no-cache build-base \
  sqlite \
  sqlite-dev \
  nodejs \
  npm \
  tzdata

ENV RAILS_ROOT /var/www/liberta

WORKDIR $RAILS_ROOT

ENV RAILS_ENV='production'
ENV RACK_ENV='production'

ENV SECRET_KEY_BASE='production-secret-key'

RUN npm install -g yarn

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install --jobs 4 --retry 5 --without development test

COPY . .

RUN bundle exec rails assets:precompile

EXPOSE 3000
