module Models
  module Position
    extend ActiveSupport::Concern

    POSITION_VALUES = [:position_member, :position_deputy]

    module ClassMethods
      def position_field_symbol
        @symbol
      end
      def position_field(symbol)
        @symbol = symbol
        validates position_field_symbol, allow_nil: true, inclusion: { in:  POSITION_VALUES }
        field position_field_symbol, type: Symbol
        scope :members, where(position_field_symbol => :position_member)
        scope :deputies, where(position_field_symbol => :position_deputy)
        scope :not_selected, where(selected_as: nil)
        scope :lone_deputies, deputies.where(member_id: nil)
      end
    end

    included do
      belongs_to :member, :class_name => name, :inverse_of => :deputy
      has_one :deputy, :class_name => name, :inverse_of => :member
    end

    def nil_or_find(id)
      id.blank? ? nil : self.class.find(id)
    end

    def update_attributes(attributes = {}, options = {})
      set_position! attributes if attributes.include? self.class.position_field_symbol
      super(attributes.except(self.class.position_field_symbol, :member, :deputy), options)
    end

    def set_position!(params)
      return to_not_selected! if params[self.class.position_field_symbol].blank?
      case params[self.class.position_field_symbol].to_sym
        when :position_member then to_member! params[:deputy]
        when :position_deputy then to_deputy! params[:member]
      end
    end

    protected

    def with_deputy_and_member_relations_cleared(id)
      position = nil_or_find(id)
      unless position.nil?
        position.deputy = nil
        position.member = nil
        position.save!
      end
      position
    end

    def to_member!(deputy_id)
      self[self.class.position_field_symbol] = :position_member
      self.member = nil
      self.deputy = with_deputy_and_member_relations_cleared(deputy_id)
      save!
    end

    def to_deputy!(member_id)
      self[self.class.position_field_symbol] = :position_deputy
      self.deputy = nil
      self.member = with_deputy_and_member_relations_cleared(member_id)
      save!
    end

    def to_not_selected!
      self[self.class.position_field_symbol] = nil
      self.member = nil
      self.deputy = nil
      save!
    end

    def validate_member_and_deputy_positions
      def has_position(relation, allowed_position)
        other = send(relation)
        return if other.nil?
        if other[self.class.position_field_symbol] != allowed_position
          errors.add(
              relation, errors.generate_message(
                relation, self.class.position_field_symbol))
        end
      end
      has_position :deputy, :position_deputy
      has_position :member, :position_member
    end
  end
end
