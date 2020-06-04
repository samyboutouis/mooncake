FROM ruby:2.6.6
RUN mkdir /webapp
WORKDIR /webapp

#install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" |  tee /etc/apt/sources.list.d/yarn.list
RUN  apt update &&  apt install yarn -y

RUN gem install bundler
ADD Gemfile .
ADD Gemfile.lock .
RUN bundle
RUN yarn install --check-files
ADD . /webapp
