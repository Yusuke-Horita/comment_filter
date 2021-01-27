FROM ruby:2.5.7

RUN apt-get update -qq && \
apt-get install -y build-essential \
									 libpq-dev \
									 nodejs \
									 default-mysql-client \
									 vim

RUN mkdir /API_app

WORKDIR /API_app

COPY Gemfile /API_app/Gemfile
COPY Gemfile.lock /API_app/Gemfile.lock

RUN bundle install

COPY . /API_app