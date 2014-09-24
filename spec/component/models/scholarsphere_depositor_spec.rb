require 'component/component_spec_helper'

describe ScholarsphereDepositor do
  let!(:submission) { create :submission, :waiting_for_publication_release }

  let!(:file1) { FinalSubmissionFile.create!(submission: submission,
                                            filename: File.open( fixture 'final_submission_file_01.pdf' ),
                                            content_type: 'application/pdf') }

  let!(:file2) { FinalSubmissionFile.create!(submission: submission,
                                            filename: File.open( fixture 'final_submission_file_02.docx' ),
                                            content_type: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document') }

  let(:depositor) { ScholarsphereDepositor.new(submission) }

  describe '#deposit!' do
    it "creates a new fedora object" do
      expect{depositor.deposit!}.to change{Paper.count}.by(1)
    end
    it "translates the submission's attributes into the new fedora object's metadata" do
      depositor.deposit!
      paper = Paper.last
      expect(paper.descMetadata.title.first).to eq submission.title
      expect(paper.descMetadata.creator.first).to eq "#{submission.author_first_name + submission.author_last_name}"
      expect(paper.descMetadata.semester.first).to eq submission.semester
      expect(paper.descMetadata.year.first).to eq submission.year
      expect(paper.descMetadata.program.first).to eq submission.program_name
      expect(paper.descMetadata.degree.first).to eq submission.degree_name
      expect(paper.descMetadata.abstract.first).to eq submission.abstract
      expect(paper.descMetadata.keyword).to eq submission.keywords.split(',').map(&:strip)
    end
    it "records the new fedora object's id in the submission" do
      depositor.deposit!
      submission.reload
      paper = Paper.last
      expect(submission.fedora_id).to eq paper.id
    end
    pending "adds a corresponding datastream to the fedora object for each final submission file" do
      depositor.deposit!
      submission.reload
      paper = Paper.find(submission.fedora_id)
      expect(paper.datastreams.keys.count).to eq 2
    end
  end

end
