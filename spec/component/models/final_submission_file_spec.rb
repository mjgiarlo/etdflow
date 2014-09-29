require 'component/component_spec_helper'

describe FinalSubmissionFile do

  specify { expect(subject).to have_db_column :submission_id }
  specify { expect(subject).to have_db_column :filename }
  specify { expect(subject).to have_db_column :created_at }
  specify { expect(subject).to have_db_column :updated_at }
  specify { expect(subject).to have_db_column :content_type }

  specify { expect(subject).to validate_presence_of :filename }
  specify { expect(subject).to validate_presence_of :submission_id }

  specify { expect(subject).to belong_to :submission }

  describe '#filename' do
    context "after a file has been saved" do
      before do
        # attach pdf
      end

      describe '#read' do
        it "provides an open IO stream to the file contents" do
          expect(file.filename.read).to_not be_blank
        end
      end

      describe '#content_type' do
        it "returns the content type for the file" do
          expect(file.filename.content_type).to eq "application/pdf"
        end
      end

    end
  end

end
