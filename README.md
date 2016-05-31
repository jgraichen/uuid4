# UUID4

[![Build Status](https://travis-ci.org/jgraichen/uuid4.svg?branch=master)](https://travis-ci.org/jgraichen/uuid4)

A UUID support library specialized on v4 UUIDs, parsing and formatting existing UUIDs. It can encode and decode dashed UUIDs, compact UUIDs, large integers, UUID URNs and Base62 coded UUIDs.

## Installation

```ruby
gem 'uuid4'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install uuid4

## Usage

```ruby
uuid = UUID4('d40aa316-6e30-4bae-a673-7b2cf35a8f99')
# => <UUID4:d40aa316-6e30-4bae-a673-7b2cf35a8f99>

uuid.to_s
# => "d40aa316-6e30-4bae-a673-7b2cf35a8f99"

uuid.to_s(format: :compact)
# => "d40aa3166e304baea6737b2cf35a8f99"

uuid.to_s(format: :base62)
# => "6s7exj9M9mGqLs5KhhWWaB"

uuid.to_s(format: :urn)
# => "urn:uuid:d40aa316-6e30-4bae-a673-7b2cf35a8f99"

uuid.to_i
# => 281851565884874220786890141677225938841

uuid == 'd40aa316-6e30-4bae-a673-7b2cf35a8f99'
# => true

'd40aa316-6e30-4bae-a673-7b2cf35a8f99' == uuid
# => true

uuid == "d40aa3166e304baea6737b2cf35a8f99"
# => true

uuid == '6s7exj9M9mGqLs5KhhWWaB'
# => true

uuid == 281851565884874220786890141677225938841
# => true

uuid == 'urn:uuid:d40aa316-6e30-4bae-a673-7b2cf35a8f99'
# => true

uuid == UUID4('d40aa316-6e30-4bae-a673-7b2cf35a8f99')
# => true
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jgraichen/uuid4.


## License

(c) Jan Graichen

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

