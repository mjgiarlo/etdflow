require 'etd'

class ScholarsphereDepositor
  attr_reader :submission

  def initialize(submission)
    @submission = submission
  end

  def deposit!
    paper = Paper.new
    paper.descMetadata.title << @submission.title
    paper.descMetadata.creator << "#{@submission.author_first_name + @submission.author_last_name}"
    paper.descMetadata.semester << @submission.semester
    paper.descMetadata.year << @submission.year
    paper.descMetadata.program << @submission.program_name
    paper.descMetadata.degree << @submission.degree_name
    paper.descMetadata.abstract << @submission.abstract
    @submission.keywords.split(',').map(&:strip).each do |keyword|
      paper.descMetadata.keyword << keyword
    end
    @submission.final_submission_files.each do |file|
      # paper.add_file_datastream(File.open(file.filename_url), mimeType: file.content_type)
    end
    paper.save
    @submission.update_attribute :fedora_id, paper.id
  end

end
