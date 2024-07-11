# frozen_string_literal: true

require 'base62-rb'

class UUID4
  module Formatter
    class Base62
      REGEXP = /\A[0-9A-Za-z]{14,22}\z/.freeze

      def encode(uuid)
        ::Base62.encode(uuid.to_i)
      end

      def decode(value)
        return unless value.respond_to?(:to_str) && (value = value.to_str) =~ REGEXP
        return unless ::UUID4.valid_int?(int = ::Base62.decode(value))

        int
      end
    end
  end
end
