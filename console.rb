#!/usr/local/env ruby
# frozen_string_literal: true

require './configure'
require './model'

source_file_path = "#{LOCAL_DATA_FOR_UPLOADS_FOLDER}/the-hills.jpg"
file_name = 'the-hills.jpg'
file_id = 'file_id'
metadata_adapter = Valkyrie::MetadataAdapter.find(:memory)
image_resource = metadata_adapter.persister.save(resource: ImageFileResource.new(title: 'The Hills', file_identifiers: [file_id]))

def upload_file_to_disk_using_valkyrie_only(source, resource, original_file_name)
  storage_adapter = Valkyrie::StorageAdapter.find(:disk)
  storage_adapter.upload(file: File.new(source), resource: resource, original_filename: original_file_name)
end

def upload_file_to_disk_using_shrine_only(source, resource)
  storage_adapter = Shrine.storages[:file]
  storage_adapter.upload(File.new(source), resource.id.to_s)
end

def upload_file_to_disk_using_valkyrie_shrine(source, resource, original_file_name)
  storage_adapter = Valkyrie::StorageAdapter.find(:shrine_disk)
  storage_adapter.upload(file: File.new(source), resource: resource, original_filename: original_file_name)
end

def upload_file_to_s3_using_shrine_only(source, resource)
  storage_adapter = Shrine.storages[:s3]
  storage_adapter.upload(File.new(source), resource.id.to_s)
end

def upload_file_to_s3_using_valkyrie_shrine(source, resource, original_file_name)
  storage_adapter = Valkyrie::StorageAdapter.find(:shrine_s3)
  storage_adapter.upload(file: File.new(source), resource: resource, original_filename: original_file_name)
end

# upload_file_to_disk_using_valkyrie_only(source_file_path, image_resource, file_name)
# upload_file_to_disk_using_shrine_only(source_file_path, image_resource)
# upload_file_to_disk_using_valkyrie_shrine(source_file_path, image_resource, file_name)
# upload_file_to_s3_using_shrine_only(source_file_path, image_resource)
upload_file_to_s3_using_valkyrie_shrine(source_file_path, image_resource, file_name)

