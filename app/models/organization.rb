class Organization
  include Mongoid::Document
  include Mongoid::Tree
  include Mongoid::Timestamps

  has_many  :organs

  field     :name, localize: true

  def tree_hash
    serializable_hash.merge(children: children.map(&:serializable_hash))
  end

end
