FROM ruby:2.6.6
RUN mkdir /webapp
WORKDIR /webapp

#install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" |  tee /etc/apt/sources.list.d/yarn.list
RUN  apt update &&  apt install yarn -y

#install gems and npm dependencies
RUN gem install bundler
ADD Gemfile .
ADD Gemfile.lock .
RUN bundle install --without development test
RUN yarn install --check-files

#add app to container
ADD . /webapp

# precomplie assets, these get synced over to the nginx container in a post container command
RUN rails assets:precompile

#fix openshift permissions
RUN chgrp -R 0 /src \
  && chmod -R g+rwX /src

#run migrations
RUN rails db:migrate

EXPOSE 3000
CMD rails s