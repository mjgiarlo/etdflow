class FormatReviewFileUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  version :thumbnail do
    process :resize_to_fill => [120, 120]
  end 

  storage :file
  add_config :base_dir
  self.base_dir = Rails.root.join('public/uploads')

  def store_dir
    base_dir.join(identity_subdir)
  end 

  def cache_dir
    base_dir.join('cache', identity_subdir)
  end 

  def asset_hash
    "%02d" % ((model.id || 0) % 100)
  end 

  def identity_subdir
    Pathname.new('.').join(
      model.class.to_s.underscore.pluralize, 
      asset_hash,
      model.id.to_s
    )   
  end 
end
