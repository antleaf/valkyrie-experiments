#!/usr/local/env ruby
# frozen_string_literal: true

require './configure'
require './model'
require 'rails'

def without_shrine
  metadata_adapter = Valkyrie::MetadataAdapter.find(:memory)
  storage_adapter = Valkyrie::StorageAdapter.find(:disk)

  file_name = "the-hills.jpg"
  file_id = "#{STORAGE_FOLDER}/#{file_name}"

  image_resource = ImageFileResource.new(
    title: 'The Hills',
    file_identifiers: [file_id]
  )

  upload = ActionDispatch::Http::UploadedFile.new tempfile: File.new("#{LOCAL_DATA_FOR_UPLOADS_FOLDER}/#{file_name}"), filename: file_name, type: 'image/jpeg'
  file = storage_adapter.upload(file: upload, resource: image_resource, original_filename: file_name)
  image_resource = metadata_adapter.persister.save(resource: image_resource)

  ir = metadata_adapter.query_service.find_by(id: image_resource.id)
  puts "Retrieved Image Resource Metadata = #{ir.inspect}"

  file = storage_adapter.find_by(id: "disk://#{ir.file_identifiers.first}")
  puts file.inspect
end

def with_shrine
  metadata_adapter = Valkyrie::MetadataAdapter.find(:memory)
  storage_adapter = Valkyrie::StorageAdapter.find(:shrine_disk)
  puts storage_adapter.inspect


  file_name = "the-hills.jpg"
  file_id = "#{STORAGE_FOLDER}/#{file_name}"

  image_resource = ImageFileResource.new(
    title: 'The Hills',
    file_identifiers: [file_id]
  )
  upload = ActionDispatch::Http::UploadedFile.new tempfile: File.new("#{LOCAL_DATA_FOR_UPLOADS_FOLDER}/#{file_name}"), filename: file_name, type: 'image/jpeg'
  file = storage_adapter.upload(file: upload, original_filename: file_name, resource: image_resource )

  # upload = ActionDispatch::Http::UploadedFile.new tempfile: File.new("#{LOCAL_DATA_FOR_UPLOADS_FOLDER}/#{file_name}"), filename: file_name, type: 'image/jpeg'
  # file = storage_adapter.upload(file: upload, resource: image_resource, original_filename: file_name)
  # image_resource = metadata_adapter.persister.save(resource: image_resource)
  #
  # ir = metadata_adapter.query_service.find_by(id: image_resource.id)
  # puts "Retrieved Image Resource Metadata = #{ir.inspect}"
  #
  # file = storage_adapter.find_by(id: "disk://#{ir.file_identifiers.first}")
  # puts file.inspect
end


# without_shrine
with_shrine