require 'component/component_spec_helper'

class MockSubmissionFile
  def id
    123 
  end 
  def filename
    'format_review_file.pdf'
  end 
end

describe SubmissionFileUploader do
  subject(:uploader) { SubmissionFileUploader.new }
  let(:mock_submission_file) { MockSubmissionFile.new }

  before do
    uploader.stub(model: mock_submission_file, mounted_as: 'filename' )
  end 

  it "stores files in the file system" do
    SubmissionFileUploader.storage.should == CarrierWave::Storage::File
  end 

  it 'stores files in the public/uploads directory' do
    uploader.store_dir.to_s.should =~ %r{/public/uploads}
  end 

  it 'caches files in the public/uploads directory' do
    uploader.cache_dir.to_s.should =~ %r{/public/uploads}
  end 

  it 'stores files in an identifying subdirectory' do
    uploader.store_dir.to_s.should =~ %r{/mock_submission_files/23/123$}
  end 

  it 'caches files in an identifying subdirectory' do
    uploader.cache_dir.to_s.should =~ %r{/cache/mock_submission_files/23/123$}
  end 

  context 'when the model id is nil' do
    before { mock_submission_file.stub(id: nil) }
    its(:asset_hash) { should == '00' }
  end 
  context 'when the model id is 1' do
    before { mock_submission_file.stub(id: 1) }
    its(:asset_hash) { should == '01' }
  end

  context 'when the model id is 12' do
    before { mock_submission_file.stub(id: 12) }
    its(:asset_hash) { should == '12' }
  end

  context 'when the model id is 123' do
    before { mock_submission_file.stub(id: 123) }
    its(:asset_hash) { should == '23' }
  end
end
