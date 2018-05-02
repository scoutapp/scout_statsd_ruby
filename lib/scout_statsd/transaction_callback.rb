module ScoutStatsd
  class TransactionCallback
    def call(payload)
      @payload = payload
      StatsD.measure("#{ScoutStatsd.prefix}#{payload.transaction_type_slug}.duration_ms", payload.duration_ms)

      if payload.queue_time_ms
        StatsD.gauge("#{ScoutStatsd.prefix}#{payload.transaction_type_slug}.queue_time_ms", payload.queue_time_ms)
      end

      if payload.error?
        StatsD.increment("#{ScoutStatsd.prefix}#{payload.transaction_type_slug}.error_count")
      end
    end
  end
end
