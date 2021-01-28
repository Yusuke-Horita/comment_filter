FROM ruby:2.5.7

RUN apt-get update -qq && \
apt-get install -y build-essential \
									 libpq-dev \
									 nodejs \
									 default-mysql-client \
									 vim

RUN mkdir /comment_filter

WORKDIR /comment_filter

COPY Gemfile /comment_filter/Gemfile
COPY Gemfile.lock /comment_filter/Gemfile.lock

RUN bundle install

COPY . /comment_filter