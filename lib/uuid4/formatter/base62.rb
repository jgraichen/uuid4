require 'base62-rb'

class UUID4
  module Formatter
    class Base62
      REGEXP = /^[0-9A-Za-z]{14,22}$/

      def encode(uuid)
        ::Base62.encode(uuid.to_i)
      end

      def decode(value)
        if value.respond_to?(:to_str) && (value = value.to_str) =~ REGEXP
          if ::UUID4.valid_int?(int = ::Base62.decode(value))
            int
          end
        end
      end
    end
  end
end
