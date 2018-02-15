#!/bin/bash
if [ "$1" = "sidekiq" ]; then
	bundle
	bundle exec sidekiq
	sleep 99
	exit
fi;
if [ -e /myapp/.production ]; then
	export RAILS_ENV=production
	echo "============ Precompiling Assets ============"
	bundle exec rake assets:precompile || exit
	echo "============ Migrating Database ============="
	bundle exec rake db:migrate || exit
	echo "============ Starting Passenger ============="
	export SECRET_KEY_BASE=production
	rails s -b 0.0.0.0
	echo "=============== Serer Stopped  ================"
else
	rm tmp/pids/server.pid
	bundle
	rails s -b 0.0.0.0
	echo "=============== Serer Stopped  ================"
	sleep 99
fi;
