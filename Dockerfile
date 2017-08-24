FROM redash/redash:latest
USER root

RUN apt-get update -qq && \
    apt-get install -y \
      ruby ruby-dev build-essential nodejs libcurl4-openssl-dev libxml2-dev libxslt-dev libssl-dev libsqlite3-dev
RUN gem update --system && gem install bundler

RUN mkdir -p /rails_app
COPY . /rails_app

RUN cd /rails_app && bundle install

COPY ruby.py /app/redash/query_runner/

USER redash
