require 'component/component_spec_helper'

describe SubmissionsIndexView do

  describe '#new_author?' do
    it 'returns true for a remote user that is not in our database' do
      author = Author.new
      view = SubmissionsIndexView.new author
      expect(view.new_author?).to be_true
    end
    it 'returns false for a remote user that is in our database' do
      author = create :author
      view = SubmissionsIndexView.new author
      expect(view.new_author?).to be_false
    end
  end

  describe '#partial_name' do
    context 'When the remote user is not in our database' do
      let(:author) { Author.new }
      it 'returns confirm_contact_information_instructions' do
        view = SubmissionsIndexView.new author
        expect(view.partial_name).to eq 'confirm_contact_information_instructions'
      end 
    end
    context 'When the remote user exists in our database' do
      let(:author) { create :author }
      it "returns the author's submissions" do
        view = SubmissionsIndexView.new author
        expect(view.partial_name).to eq 'submissions'
      end 
    end
  end

end
