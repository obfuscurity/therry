# Therry

## Purpose

Provide a web service that caches Graphite metrics and exposes an endpoint for dumping or searching them.

## Deployment

Therry is a very basic Sinatra application. It uses rufus-scheduler to gather routine updates to the Graphite metrics store before caching them in memory.

### Service Dependencies

None.

### Configuration Vars

* `METRICS_UPDATE_INTERVAL` - How frequently to update the list of known metrics from the remote Graphite server. The more often you add new metrics, the lower this value should be. A reasonable default for most installations would be `1h` (time strings as understood by [Rufus scheduler](https://github.com/jmettraux/rufus-scheduler#the-time-strings-understood-by-rufus-scheduler)). If users complain that they don't see new metrics, it means that it hasn't synced since a new metric has been added. You can simply restart Therry, and optionally lower this value to suit your users' patience threshold, to manually update the metrics list.

* `GRAPHITE_URL` - Base URL for the Graphite server (e.g. `http://graphite.example.com`).

* `GRAPHITE_USER` - Basic Authentication username for the Graphite server (optional).

* `GRAPHITE_PASS` - Basic Authentication password for the Graphite server (optional).

### Development

Therry uses the Sinatra web framework under Ruby 1.9. Anyone wishing to run Therry as a local service should be familiar with common Ruby packaging and dependency management utilities such as RVM and Bundler. If you are installing a new Ruby version with RVM, make sure that you have the appropriate OpenSSL development libraries installed before compiling Ruby.

All environment variables can be set from the command-line, although it's suggested to use `.env` instead. This file will automatically be picked up by foreman, which is also helpful when debugging (e.g. `foreman run pry`). This file will not be committed (unless you remove or modify `.gitignore`) so you shouldn't have to worry about accidentally leaking credentials.

```bash
$ rvm use 1.9.2
$ bundle install
$ foreman start
```

### Production

```bash
$ export DEPLOY=production/staging/you
$ heroku create -r $DEPLOY -s cedar
$ heroku config:set -r $DEPLOY GRAPHITE_URL=...
$ heroku config:set -r $DEPLOY METRICS_UPDATE_INTERVAL=1h
$ heroku config:set -r $DEPLOY RAKE_ENV=production
$ git push $DEPLOY master
$ heroku scale -r $DEPLOY web=1
```

## LICENSE

Therry is distributed under the MIT license. Third-party software libraries included with this project are distributed under their respective licenses.
