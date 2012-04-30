module Models
  module Position
    extend ActiveSupport::Concern

    POSITION_VALUES = [:position_member, :position_deputy]

    included do
      belongs_to :member, :class_name => name, :inverse_of => :deputy
      has_one :deputy, :class_name => name, :inverse_of => :member

      class_eval do
        def self.position_field(symbol)
          validates symbol, allow_nil: true, inclusion: { in:  POSITION_VALUES }
          field symbol, type: Symbol
          scope :current_members, where(symbol => :position_member, current: true)
          scope :current_deputies, where(symbol => :position_deputy, current: true)
        end
      end
    end

    def nil_or_find(id)
      id.blank? ? nil : self.class.find(id)
    end

    def set_position!(params)
      return to_not_selected! if params[:position].nil?
      case params[:position].to_sym
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
      self.selected_as = :position_member
      self.member = nil
      self.deputy = with_deputy_and_member_relations_cleared(deputy_id)
      save!
    end

    def to_deputy!(member_id)
      self.selected_as = :position_deputy
      self.deputy = nil
      self.member = with_deputy_and_member_relations_cleared(member_id)
      save!
    end

    def to_not_selected!
      self.selected_as = nil
      self.member = nil
      self.deputy = nil
      save!
    end

    def validate_member_and_deputy_positions
      def has_value(relation, allowed_position)
        other = send(relation)
        return if other.nil?
        if other.selected_as != allowed_position
          errors.add(
              relation, errors.generate_message(
                relation, :position))
        end
      end
      has_value :deputy, :position_deputy
      has_value :member, :position_member
    end
  end
end
