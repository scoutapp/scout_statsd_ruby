# ScoutStatsd

[![Build Status](https://travis-ci.org/scoutapp/scout_statsd_ruby.svg?branch=master)](https://travis-ci.org/scoutapp/scout_statsd_ruby)

Want your Rails performance KPIs in your StatsD-compatible metric system with _almost_ zero effort? Of course you do! Meet `scout_statsd`! This gem is an extension of the [Scout](https://scoutapp.com) Ruby monitoring agent ([`scout_apm`](https://github.com/scoutapp/scout_apm_ruby)), and makes it easy to create an app performance dashboard.

A [Scout](https://scoutapp.com) account isn't required, but it certainly makes getting to the source of app performance easier 😉.

## Metrics 

The following metrics are reported w/o any custom instrumentation steps:

| Metric Name | Type | Description |
| - | - | - |
web.duration_ms | timer | The total duration of web requests in milliseconds
job.duration_ms | timer | The total duration of background jobs (Sidekiq, DelayedJob, etc.) in milliseconds
web.error_count | counter | A count of web requests that throw an exception
job.error_count | counter | A count of background jobs that throw an exception
web.queue_time_ms | gauge | The [time spent in request queuing](http://help.apm.scoutapp.com/#request-queuing) in milliseconds
job.queue_time_ms | gauge | The time between when a job is inserted into a background job queue and when execution begins in milliseconds

## Tags

These metrics are tagged too! Slice and dice! The following tags are added to each metric:

| Tag Name | Description |
| - | - |
app | The name of the app. See the [name](http://help.apm.scoutapp.com/#name) Scout config option.
hostname | The hostname of the app. See the [hostname](http://help.apm.scoutapp.com/#hostname) Scout config option.

Now, you can correlate app performance metrics with all of your other system metrics.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'scout_statsd'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install scout_statsd

## Configuration

__1. Add a `config/initializers/scout_statsd.rb` file to your Rails app:__

```ruby
require 'datadog/statsd'
statsd = Datadog::Statsd.new('localhost', 8125)
ScoutStatsd.configure(statsd)
```

__2. Add a `config/scout_apm.yml` file to your Rails app:__

_This step isn't required if you are already using Scout._

```yaml
common: &defaults
  monitor: true

development:
  <<: *defaults
  monitor: false # set to true to test in your development environment

production:
  <<: *defaults
```

_Metrics are only sent if `monitor: true` for the associated Rails environment._

[See the Scout docs](http://help.apm.scoutapp.com/#ruby-agent) for advanced configuration instructions.

## How it works

After each transaction (a web request or background job), the metrics specific to that transaction are transmitted via the StatsD protocol via the client passed through to `ScoutStatsd#configure`. No code changes are required: the `scout_apm` gem automatically instruments Rails controller-actions and background jobs. Easy peasy!

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mike-stewart/scout_statsd_ruby.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

