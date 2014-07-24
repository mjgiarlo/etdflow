class MockFormatReview
  include ActiveModel::Model

  @@saved_files = []

  def self.saved_files
    @@saved_files
  end

  def save(files)
    files.each do |f|
      @@saved_files << f.original_filename
    end
  end

end
