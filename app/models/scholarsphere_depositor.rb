class ScholarsphereDepositor

  def self.save(submission, files)
    if submission.nil? || files.nil? || files.empty?
      raise ArgumentError, "files can't be empty"
    end 
    files.each do |f| 
      if self.uploaded_file? f
        true 
      else
        raise ArgumentError, "argument is not an uploaded file"
      end 
    end 
  end 

  private

  def self.uploaded_file?(f)
    ( f.instance_of? Rack::Test::UploadedFile ) || ( f.instance_of? ActionDispatch::Http::UploadedFile )
  end 

end
