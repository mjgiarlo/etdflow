require 'component/component_spec_helper'

# Include shared examples
require 'component/models/depositor_interface_spec'

# So we can use fixture_file_upload
include ActionDispatch::TestProcess

describe GenuineDepositor do

  let(:file1) { fixture_file_upload( fixture('format_review_file_01.pdf'), 'application/pdf' ) }
  let(:file2) { fixture_file_upload( fixture('format_review_file_02.pdf'), 'application/pdf' ) }
  let(:files) { [file1, file2] }

  let!(:submission) { create :submission }

  it_behaves_like "a depositor class"

  describe "saving files" do
    describe ".save" do
      it "accepts an array of uploaded files" do
        GenuineDepositor.save(submission, files)
      end 
    end 
  end 

end
