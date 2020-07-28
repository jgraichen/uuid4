# CHANGELOG

All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/) and [Keep a Changelog](http://keepachangelog.com/).


## Unreleased
---

### New

### Changes

### Fixes

### Breaks


## 1.3.4 - (2020-07-28)
---

### Fixes
* Consider newlines when checking base62 format (#5)


## 1.3.3

* Fix error message on type errors (#4)

## 1.3.2

* Fix issue when parsing UUIDs (5e47b00)

## 1.3.1

* Fix incompatibility with Rubies <2.2 introduced in #1

## 1.3.0

* Add `UUID#hash` and `UUID#eql?` for using UUIDs e.g. as hash keys
* Add `UUID.try_convert` returning a UUID or `nil`
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