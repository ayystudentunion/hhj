module Ext
  module Mongoid
    module AutoFormatLocalizedAttributes
      def write_attribute(attr, value)
        if value.is_a?(Hash) && fields[attr].localized?
          send("#{attr}_translations=".to_sym, value.reject { |_key, value| value.blank? })
        else
          super(attr, value)
        end
      end
    end
  end
end
