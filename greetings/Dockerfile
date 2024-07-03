FROM ruby:3.3.3

ENV RACK_ENV production
WORKDIR /srv
COPY Gemfile Gemfile.lock ./
RUN bundle config set deployment true && \
    bundle config set without development,test && \
    bundle install

EXPOSE 9292
COPY . .
CMD ["/srv/bin/rackup", "-o", "0.0.0.0"]

