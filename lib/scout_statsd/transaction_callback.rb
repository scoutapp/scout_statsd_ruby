module ScoutStatsd
  class TransactionCallback
    def call(payload)
      @payload = payload
      StatsD.measure("#{payload.transaction_type_slug}.duration_ms", payload.duration_ms)

      if payload.queue_time_ms
        StatsD.gauge("#{payload.transaction_type_slug}.queue_time_ms", payload.queue_time_ms)
      end

      if payload.error?
        StatsD.increment("#{payload.transaction_type_slug}.error_count")
      end
    end
  end
end
