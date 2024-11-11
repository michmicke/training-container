FROM docker.io/ruby:3.3.3-alpine

RUN apk --no-cache --update add g++ make

WORKDIR /srv/app

ENV RACK_ENV=production
COPY Gemfile Gemfile.lock ./
RUN bundle config set deployment true && \
  bundle config set without development,test && \
  bundle install

COPY . .

EXPOSE 9292
CMD ["bin/rackup", "-o", "0.0.0.0"]
