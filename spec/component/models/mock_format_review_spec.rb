require 'component/component_spec_helper'
require 'support/mock_format_review'

# Include shared examples
require 'component/models/format_review_interface_spec'

# So we can use fixture_file_upload
include ActionDispatch::TestProcess

describe MockFormatReview do
  let(:format_review) { MockFormatReview.new }

  it_behaves_like "a format review class"

  let(:file1) { fixture_file_upload( fixture('format_review_file_01.pdf'), 'application/pdf' ) }
  let(:file2) { fixture_file_upload( fixture('format_review_file_02.pdf'), 'application/pdf' ) }
  let(:files) { [file1, file2] }

  describe "saving format review files" do
    describe '#save' do
      it "accepts an array of uploaded files" do
        format_review.save(files)
      end
    end

    describe '.saved_files' do
      context "when no files have been saved" do
        it "returns an empty array" do
          expect(MockFormatReview.saved_files).to be_empty
        end
      end
      context "when a couple of files have been saved" do
        before do
          format_review.save(files)
        end
        it "returns an array of the file names" do
          expect(MockFormatReview.saved_files).to eq [file1.original_filename, file2.original_filename]
        end
      end
    end
  end

end
