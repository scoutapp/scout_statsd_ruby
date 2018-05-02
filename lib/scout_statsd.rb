module ScoutStatsd
  def self.rails?
    defined? Rails::Railtie
  end
end

require "scout_statsd/version"
require "scout_statsd/transaction_callback"

ScoutApm::Extensions::Config.add_transaction_callback(ScoutStatsd::TransactionCallback.new)
