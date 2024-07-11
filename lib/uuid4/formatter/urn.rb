class UUID4
  module Formatter
    class URN
      REGEXP = /^urn:uuid:[\da-f]{8}-[\da-f]{4}-?[1-8][\da-f]{3}-[89ab][\da-f]{3}-[\da-f]{12}$/i
      FORMAT = 'urn:uuid:%08x-%04x-%04x-%04x-%012x'.freeze

      def encode(uuid)
        FORMAT % uuid.components
      end

      def decode(value)
        if value.respond_to?(:to_str) && (value = value.to_str) =~ REGEXP
          value[9..-1].tr('-', '').hex
        end
      end
    end
  end
end
