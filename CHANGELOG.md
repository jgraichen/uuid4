# Changelog

## Next

* Add `UUID#hash` and `UUID#eql?` for using UUIDs e.g. as hash keys
* Add `UUID.try_convert` returning a UUID or `nil`.
* Add `UUID.valid?` to validate objects as UUIDs (#1)

## 1.2.1

* Improve `#as_json` compatibility by swallowing arbitrary arguments passed by encoders.

## 1.2.0

* Add JSON encoding support for ActiveSupport

## 1.1.1

* Fix support for numerical small UUIDs

## 1.1.0

* Export `Kernel#UUID`.

## 1.0.0

* Initial release.
