class Sin < RecordBase
  field :description

  validates_presence_of :description
  validates_length_of :description, maximum: 256

  def self.create_with_description( description )
    Dynamoid::TransactionWrite.execute do |txn|
      if txn.create(Sin, description: description)
        txn.upsert SinCounter, id: SinCounter::HASH_KEY do |upsert|
          upsert.add record_count: 1
        end
      else
        # Sin was invalid
      end
    end
  end

  def self.count
    SinCounter.count
  end
end
