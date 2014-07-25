class MockFormatReview
  include ActiveModel::Model

  attr_reader :submission

  @@saved_files = []

  def self.saved_files
    @@saved_files
  end

  def initialize(submission=nil)
    @submission = submission
  end

  def save(files)
    files.each do |f|
      @@saved_files << f.original_filename
    end
  end

end
