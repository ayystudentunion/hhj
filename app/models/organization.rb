class Organization
  include Mongoid::Document
  include Mongoid::Tree
  include Mongoid::Timestamps

  has_many  :organs

  # root organizations must have unique key, because it is used for routing
  validates_each :key do |record, attr, value|
    next unless record.parent.nil?

    if value.blank?
      record.errors.add(attr, record.errors.generate_message(attr, :blank, name: record.name))
    else
      where(key: value, :_id.ne => record._id).each do |other|
        record.errors.add(
          attr, record.errors.generate_message(
            attr, :taken, name: record.name, key:value, other: other.name))
      end
    end
  end

  field     :name, localize: true
  field     :key, type: String

  def tree_hash
    serializable_hash.merge(children: children.map(&:serializable_hash))
  end

end
