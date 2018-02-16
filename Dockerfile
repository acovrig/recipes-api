FROM ruby:2.4.2
LABEL author="Austin Covrig <austinc@iiw.org>"
ENV HOME /src
ENV RAILS_ENV=production
CMD ["./docker_start.sh"]

RUN apt update \
  && apt install -y \
		build-essential \
		liblzma-dev \
		patch \
		ruby-dev \
		zlib1g-dev \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
	&& mkdir /src \
	&& touch /src/Gemfile.lock

WORKDIR /src
ADD Gemfile /src
RUN bundle install

COPY . /src
RUN if [ -e /src/tmp/pids/server.pid ]; then \
			rm /src/tmp/pids/server.pid; \
		fi; \
		touch /src/.production