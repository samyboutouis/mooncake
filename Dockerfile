FROM ruby:2.6.6
RUN mkdir /webapp
WORKDIR /webapp

#install installers
RUN gem install bundler
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" |  tee /etc/apt/sources.list.d/yarn.list
RUN  apt update &&  apt install yarn -y

#install rails dependencies
ADD Gemfile .
ADD Gemfile.lock .
RUN bundle install


#install yarn and front end dependencies
ADD yarn.lock .
ADD package.json .
RUN yarn install --check-files
RUN yarn add datatables.net-dt

ADD  . .
