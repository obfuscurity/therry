$stdout.sync = true
$:.unshift File.dirname(__FILE__) + '/lib'
require 'therry/web'

# seed our Metrics list at startup
Metric.load

# update our Metrics list at regular intervals
require 'rufus/scheduler'
scheduler = Rufus::Scheduler.start_new
scheduler.every ENV['METRICS_UPDATE_INTERVAL'] do
  Metric.update
end

run Rack::URLMap.new('/' => Therry::Web)
