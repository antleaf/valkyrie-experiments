# frozen_string_literal: true
require 'valkyrie'

# simple resource class with a title and a set of file identifiers
class ImageFileResource < Valkyrie::Resource
  attribute :title, Valkyrie::Types::SingleValuedString
  attribute :file_identifiers, Valkyrie::Types::Set
end

# class MyUploader < Shrine
#   # image attachment logic
# end