class Organization
  include Mongoid::Document
  include Mongoid::Tree
  include Mongoid::Timestamps

  has_many  :organs

  # root organizations must have unique key, because it is used for routing
  validates_each :key do |record, attr, value|
    record.errors.add(attr, record.errors.generate_message(attr, :blank, name: record.name)) if value.blank? && record.parent.nil?
  end

  field     :name, localize: true
  field     :key, type: String

  def tree_hash
    serializable_hash.merge(children: children.map(&:serializable_hash))
  end

end
