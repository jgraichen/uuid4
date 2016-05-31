class UUID4
  module Formatter
    class Compact
      REGEXP = /^[\da-f]{12}[1-5][\da-f]{3}[89ab][\da-f]{15}$/i
      FORMAT = '%032x'.freeze

      def encode(uuid)
        FORMAT % uuid.to_int
      end

      def decode(value)
        if value.respond_to?(:to_str) && (value = value.to_str) =~ REGEXP
          value.hex
        end
      end
    end
  end
end
