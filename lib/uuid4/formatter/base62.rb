require 'base62-rb'

class UUID4
  module Formatter
    class Base62
      REGEXP = /^[0-9A-z]{22}$/i

      def encode(uuid)
        ::Base62.encode(uuid.to_i)
      end

      def decode(value)
        if value.respond_to?(:to_str) && (value = value.to_str) =~ REGEXP
          ::Base62.decode(value)
        end
      end
    end
  end
end
