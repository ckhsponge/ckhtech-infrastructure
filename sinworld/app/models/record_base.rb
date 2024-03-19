
class RecordDynamoid
  include Dynamoid::Document

  # create as_json method that can now be overridden
  alias_method :as_json_og, :as_json

  table name: ENV['DYNAMODB_TABLE_NAME'].to_sym, key: :id, capacity_mode: :on_demand

  field :type
end

class RecordBase < RecordDynamoid
  # range :sk, :string

  field :type
  # field :created_at, :datetime # already defined by dynamoid
  # field :updated_at, :datetime # already defined by dynamoid

  # type and created_at are set automatically so this should always be available
  global_secondary_index name: ENV['DYNAMODB_TYPE_INDEX_NAME'], hash_key: :type, range_key: :created_at, projected_attributes: :all

  before_create :create_id

  def create_id
    self.id ||= "#{self.type}##{SecureRandom.uuid}"
  end

  # re-runnable command to create table if it hasn't been created yet
  def self.create_table_if_needed
    RecordBase.create_table(sync: true) # create and wait for completion
  end

end

