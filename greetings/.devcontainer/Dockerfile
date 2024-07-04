FROM ruby:3.3.3-alpine

ENV RACK_ENV development
RUN apk --update --no-cache add git curl bash fish neovim

WORKDIR /srv
COPY Gemfile Gemfile.lock ./
RUN bundle install

EXPOSE 9292
COPY . .
CMD ["sleep", "infinity"]

