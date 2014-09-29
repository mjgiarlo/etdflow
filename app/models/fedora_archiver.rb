require 'etd'

class FedoraArchiver
  attr_reader :submission

  def initialize(submission)
    @submission = submission
  end

  def create!
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
    paper.save
    @submission.final_submission_files.each do |file|
      generic_file = Worthwhile::GenericFile.new
      generic_file.add_file_datastream(file.filename.read, mimeType: file.filename.content_type)
      paper.generic_files << generic_file
    end
    @submission.update_attribute :fedora_id, paper.id
  end

end
