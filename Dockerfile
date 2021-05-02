FROM ruby:3.0.0
LABEL author="Austin Covrig <accovrig@gmail.com>"
ENV HOME /app
ENV RAILS_ENV=production
CMD ["./docker_start.sh"]

RUN if [ ! -e /app ]; then mkdir /app; fi
WORKDIR /app

RUN apt update \
  && apt install -y curl gnupg \
  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt update \
  && DEBIAN_FRONTEND=noninteractive apt install -y \
    build-essential \
    git \
    graphviz \
    imagemagick \
    libmagickwand-dev \
    libpq-dev \
    libssl-dev \
    make \
    nodejs \
    openssl \
    ruby-dev \
    wget \
    yarn \
    zlib1g-dev \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN gem install bundler rails

ADD Gemfile Gemfile.lock /app/
RUN bundle install
ADD package.json yarn.lock /app/
RUN yarn install
COPY . /app
RUN touch /app/.production
RUN RAILS_ENV=production SECRET_KEY_BASE=production rake assets:precompile && bin/webpack
