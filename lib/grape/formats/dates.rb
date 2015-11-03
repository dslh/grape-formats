require 'date'
require_relative 'build'

module Grape
  module Formats
    # This module provides a set of ready-made +Virtus::Attribute+
    # constants, suitable for use as the +type+ option for
    # {Grape::Dsl::Parameters#requires} and {Grape::Dsl::Parameters#optional}.
    # These definitions will coerce input strings to the standard
    # ruby +Date+ type using the standard parsing methods defined
    # on that class.
    #
    # This module is not required by default.
    module Dates
      # Parses dates using +Date.httpdate+
      HttpDate = Formats.build(::Date, ::Date.method(:httpdate))

      # Parses dates using +Date.iso8601+
      Iso8601 = Formats.build(::Date, ::Date.method(:iso8601))

      # Parses dates using +Date.jisx0301+
      Jisx0301 = Formats.build(::Date, ::Date.method(:jisx0301))

      # Parses dates using +Date.jd+
      JulianDay = Formats.build(::Date, lambda do |val|
        unless val =~ /^\d*$/
          fail Grape::Exceptions::Validations, 'julian date must be an integer'
        end

        ::Date.jd val.to_i
      end)

      # Parses dates using +Date.rfc2822+
      Rfc2822 = Formats.build(::Date, ::Date.method(:rfc2822))

      # Parses dates using +Date.rfc3339+
      Rfc3339 = Formats.build(::Date, ::Date.method(:rfc3339))

      # Parses dates using +Date.rfc822+
      Rfc822 = Formats.build(::Date, ::Date.method(:rfc822))

      # Parses dates using +Date.xmlschema+
      XmlSchema = Formats.build(::Date, ::Date.method(:xmlschema))
    end
  end
end
