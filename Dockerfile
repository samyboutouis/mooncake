FROM ruby:2.6.6
RUN mkdir /webapp
WORKDIR /webapp
RUN gem install bundler
ADD Gemfile .
ADD Gemfile.lock .
RUN bundle
ADD . /webapp
