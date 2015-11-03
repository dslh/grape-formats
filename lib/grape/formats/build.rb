require 'virtus'
require 'grape/validations/types/custom_type_coercer'

module Grape
  # Scaffolding for building types.
  module Formats
    # Common function for building 'types' that consist of an
    # underlying primitive type and an arbitrary coercion method
    # used to convert strings to that type.
    #
    # Makes use of the +CustomTypeCoercer+ class in the base Grape gem.
    #
    # @param type [Class] the type to which parameter values will be coerced
    # @param method [Proc] type coercion method.
    #   Should accept a single +String+ parameter and return an object of
    #   type +type+.
    # @return [Virtus::Attribute] an object that may be passed as the +type+
    #   option for any Grape endpoint parameter declared with +requires+ or
    #   +optional+.
    def self.build(type, method)
      Grape::Validations::Types::CustomTypeCoercer.build(type, method)
    end
  end
end
