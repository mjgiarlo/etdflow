require 'component/component_spec_helper'

# Include shared examples
require 'component/models/format_review_interface_spec'

# So we can use fixture_file_upload
include ActionDispatch::TestProcess

describe GenuineFormatReview do
  let(:format_review) { GenuineFormatReview.new }

  it_behaves_like "a format review class"

  let(:file1) { fixture_file_upload( fixture('format_review_file_01.pdf'), 'application/pdf' ) }
  let(:file2) { fixture_file_upload( fixture('format_review_file_02.pdf'), 'application/pdf' ) }
  let(:files) { [file1, file2] }

  describe "saving format review files" do
    describe "#save" do
      it "accepts an array of uploaded files" do
        format_review.save(files)
      end 
    end 
  end 

end
