# frozen_string_literal: true

class UUID4
  module Formatter
    class Compact
      REGEXP = /^[\da-f]{12}[1-8][\da-f]{3}[89ab][\da-f]{15}$/i.freeze
      FORMAT = '%032x'

      def encode(uuid)
        FORMAT % uuid.to_int
      end

      def decode(value)
        return unless value.respond_to?(:to_str) && (value = value.to_str) =~ REGEXP

        value.hex
      end
    end
  end
end
