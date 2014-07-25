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
    if files.nil? || files.empty?
      raise ArgumentError, "files can't be empty"
    end
    files.each do |f|
      if uploaded_file? f
        @@saved_files << f.original_filename
      else
        raise ArgumentError, "argument is not an uploaded file"
      end
    end
  end

  private

  def uploaded_file?(f)
    ( f.instance_of? Rack::Test::UploadedFile ) || ( f.instance_of? ActionDispatch::Http::UploadedFile )
  end

end
