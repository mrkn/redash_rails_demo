FROM redash/redash:latest
USER root

RUN apt-get update -qq && \
    apt-get install -y \
      ruby ruby-dev build-essential nodejs libcurl4-openssl-dev libxml2-dev libxslt-dev libssl-dev libsqlite3-dev tzdata

RUN echo 'install: --no-document' >> /etc/gemrc && \
    echo 'update: --no-document' >> /etc/gemrc

RUN gem update --system && \
    gem install bundler && \
    gem install pkg-config -v "~> 1.1.7"
RUN gem install nokogiri -- --with-system-libraries

RUN mkdir -p /rails_app
COPY . /rails_app

ENV BUNDLE_PATH=/bundle

RUN cd /rails_app && bundle install -j 4
RUN cd /rails_app && bundle exec rake db:drop db:create db:migrate db:seed

RUN chown -R redash /rails_app
COPY python/redash_rails/query_runner/rails.py /app/redash/query_runner/

# ENV PYTHONPATH=/rails_app/python

USER redash
