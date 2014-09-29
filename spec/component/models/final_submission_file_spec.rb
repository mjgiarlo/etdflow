require 'component/component_spec_helper'

describe FinalSubmissionFile do

  specify { expect(subject).to have_db_column :submission_id }
  specify { expect(subject).to have_db_column :asset }
  specify { expect(subject).to have_db_column :created_at }
  specify { expect(subject).to have_db_column :updated_at }
  specify { expect(subject).to have_db_column :content_type }

  specify { expect(subject).to validate_presence_of :asset }
  specify { expect(subject).to validate_presence_of :submission_id }

  specify { expect(subject).to belong_to :submission }

  describe '#asset' do
    context "after a file has been saved" do
      let(:file1) { create :final_submission_file, :pdf }
      let(:file2) { create :final_submission_file, :docx }

      describe '#read' do
        it "provides an open IO stream to the file contents" do
          expect(file1.asset.read).to_not be_blank
          expect(file2.asset.read).to_not be_blank
        end
      end

      describe '#content_type' do
        it "returns the content type for the file" do
          expect(file1.asset.content_type).to eq "application/pdf"
          expect(file2.asset.content_type).to eq "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
        end
      end

    end
  end

end
