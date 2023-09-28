# frozen_string_literal: true

require 'valkyrie'
# require 'shrine'
require 'shrine/storage/s3'
require 'shrine/storage/file_system'
require 'valkyrie/shrine/checksum/base'
require 'valkyrie/shrine/checksum/s3'
require 'valkyrie/shrine/checksum/file_system'
require 'valkyrie/storage/shrine'

STORAGE_FOLDER = "#{__dir__}/storage"
LOCAL_DATA_FOR_UPLOADS_FOLDER = "#{__dir__}/local_data_for_upload"

# simple "in memory" metadata adapter - no metadata is persisted
Valkyrie::MetadataAdapter.register(
  Valkyrie::Persistence::Memory::MetadataAdapter.new,
  :memory
)

s3_client = Aws::S3::Client.new(
  region: 'eu-central-1',
  endpoint: 'https://eu-central-1.linodeobjects.com',
  access_key_id:     ENV.fetch("ANTLEAF_S3_ACCESS_KEY"),
  secret_access_key: ENV.fetch("ANTLEAF_S3_SECRET_KEY"),
  )

s3_options = {
  bucket:            "valkyrie-test", # required
  region:            "eu-central-1", # required
  access_key_id:     ENV.fetch("ANTLEAF_S3_ACCESS_KEY"),
  secret_access_key: ENV.fetch("ANTLEAF_S3_SECRET_KEY"),
}

Shrine.storages = {
  file: Shrine::Storage::FileSystem.new(STORAGE_FOLDER, prefix: "/"),
  s3: Shrine::Storage::S3.new(client: s3_client, **s3_options)
}


Valkyrie::StorageAdapter.register(
  Valkyrie::Storage::Shrine.new(Shrine.storages[:file]), :shrine_disk
)

Valkyrie::StorageAdapter.register(
  Valkyrie::Storage::Shrine.new(Shrine.storages[:s3]), :shrine_s3
)

# simple Valyrie storage adapter - just uses local disk
Valkyrie::StorageAdapter.register(
  Valkyrie::Storage::Disk.new(base_path: STORAGE_FOLDER, file_mover: FileUtils.method(:cp)), :disk
)