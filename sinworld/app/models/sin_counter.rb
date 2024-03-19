class SinCounter < RecordBase
  HASH_KEY = "SinCounter#Sin"
  field :record_count, :number

  def self.count
    SinCounter.find(HASH_KEY, raise_error: false, consistent_read: true)&.record_count || 0
  end
end

