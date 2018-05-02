module ScoutStatsd
  # All access to the agent is thru this class method to ensure multiple Agent instances are not initialized per-Ruby process.
  def self.configure(statsd_client)
    @@client ||= statsd_client
    ScoutApm::Extensions::Config.add_transaction_callback(ScoutStatsd::TransactionCallback.new)
  end

  def self.client
    @@client
  end

  def self.rails?
    defined? Rails::Railtie
  end
end

require "scout_statsd/version"
require "scout_statsd/transaction_callback"
