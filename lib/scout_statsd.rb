module ScoutStatsd
  @@prefix ||= nil

  def self.configure(options = {})
    @@prefix ||= options[:prefix]
  end

  def self.prefix
    @@prefix ? "#{@@prefix}." : ''
  end

  def self.rails?
    defined? Rails::Railtie
  end
end

require "scout_statsd/version"
require "scout_statsd/transaction_callback"

ScoutApm::Extensions::Config.add_transaction_callback(ScoutStatsd::TransactionCallback.new)
