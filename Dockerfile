FROM ruby:2.6.6
RUN mkdir /webapp
RUN gem install bundler
ADD . /webapp
RUN bundle
