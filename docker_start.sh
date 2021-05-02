#!/bin/bash
if [ "$1" = "sidekiq" ]; then

	bundle install
	bundle exec sidekiq -c 4
	sleep 99
	exit
elif [ "$1" = "webpack" ]; then
	bundle install
	yarn
	export WEBPACKER_DEV_SERVER_HOST=0.0.0.0
	export WEBPACKER_DEV_SERVER_PUBLIC=dev-recipes.thecovrigs.net
	export WEBPACKER_DEV_SERVER_HTTPS=true
	./bin/webpack-dev-server
	sleep 99
	exit
elif [ "$1" = "anycable" ]; then
	bundle install
	yarn
	bundle exec anycable
	sleep 99
	exit
fi;
if [ -e ./.production ]; then
	export RAILS_ENV=production
	echo "============ Migrating Database ============="
	bundle exec rake db:migrate || exit
	echo "============ Starting Passenger ============="
	export SECRET_KEY_BASE=production
	bundle exec puma -C config/puma.rb
	echo "=============== Server Stopped  ================"
else
	rm tmp/pids/server.pid
	bundle install
	./bin/webpack-dev-server &
	rails s -b 0.0.0.0
	echo "=============== Server Stopped  ================"
	sleep 99
fi;
