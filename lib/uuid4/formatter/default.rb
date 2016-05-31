class UUID4
  module Formatter
    class Default
      REGEXP = /^[\da-f]{8}-[\da-f]{4}-[1-5][\da-f]{3}-[89ab][\da-f]{3}-[\da-f]{12}$/i
      FORMAT = '%08x-%04x-%04x-%04x-%012x'.freeze

      def encode(uuid)
        FORMAT % uuid.components
      end

      def decode(value)
        if value.respond_to?(:to_str) && (value = value.to_str) =~ REGEXP
          value.tr('-', '').hex
        end
      end
    end
  end
end
