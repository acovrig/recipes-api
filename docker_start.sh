#!/bin/bash
if [ "$1" = "sidekiq" ]; then
	bundle
	bundle exec sidekiq
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
	bundle
	rails s -b 0.0.0.0
	echo "=============== Server Stopped  ================"
	sleep 99
fi;
