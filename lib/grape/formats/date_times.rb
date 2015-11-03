require 'time'
require_relative 'build'

module Grape
  module Formats
    # This module provides a set of ready-made +Virtus::Attribute+
    # constants, suitable for use as the +type+ option for
    # {Grape::Dsl::Parameters#requires} and {Grape::Dsl::Parameters#optional}.
    # These definitions will coerce input strings to the standard
    # ruby +DateTime+ type using the standard parsing methods defined
    # on that class.
    #
    # This module is not required by default.
    module DateTimes
      # Parses timestamps using +DateTime.httpdate+
      HttpDate = Formats.build(::DateTime, ::DateTime.method(:httpdate))

      # Parses timestamps using +DateTime.iso8601+
      Iso8601 = Formats.build(::DateTime, ::DateTime.method(:iso8601))

      # Parses timestamps using +DateTime.jisx0301+
      Jisx0301 = Formats.build(::DateTime, ::DateTime.method(:jisx0301))

      # Parses julian dates using +DateTime.jd+.
      # Time of day is not supported.
      JulianDay = Formats.build(::DateTime, lambda do |val|
        unless val =~ /^\d*$/
          fail Grape::Exceptions::Validations, 'julian date must be an integer'
        end

        ::DateTime.jd val.to_i
      end)

      # Parses timestamps using +DateTime.rfc2822+
      Rfc2822 = Formats.build(::DateTime, ::DateTime.method(:rfc2822))

      # Parses timestamps using +DateTime.rfc3339+
      Rfc3339 = Formats.build(::DateTime, ::DateTime.method(:rfc3339))

      # Parses timestamps using +DateTime.rfc822+
      Rfc822 = Formats.build(::DateTime, ::DateTime.method(:rfc822))

      # Parses timestamps using +DateTime.xmlschema+
      XmlSchema = Formats.build(::DateTime, ::DateTime.method(:xmlschema))
    end
  end
end
