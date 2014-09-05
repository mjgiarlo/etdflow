require 'component/presenters/component_presenters_spec_helper'

describe SubmissionsIndexView do

  let(:existing_author) { create :author }
  let(:view_for_existing_author) { SubmissionsIndexView.new existing_author }
  let(:new_author) { Author.new }
  let(:view_for_new_author) { SubmissionsIndexView.new new_author }

  describe '#new_author?' do
    it 'returns true for a remote user that is not in our database' do
      expect(view_for_new_author.new_author?).to be_true
    end
    it 'returns false for a remote user that is in our database' do
      expect(view_for_existing_author.new_author?).to be_false
    end
  end

  describe '#partial_name' do
    context 'When the remote user is not in our database' do
      it 'returns confirm_contact_information_instructions' do
        expect(view_for_new_author.partial_name).to eq 'confirm_contact_information_instructions'
      end 
    end
    context 'When the remote user exists in our database' do
      context 'and has submissions' do
        before do
          create :submission, author: existing_author
        end
        it "returns the author's submissions" do
          expect(view_for_existing_author.partial_name).to eq 'submissions'
        end
      end
      context 'and does not have any submissions' do
        it 'returns an empty index' do
          expect(view_for_existing_author.partial_name).to eq 'no_submissions'
        end
      end
    end
  end

  describe '#author_has_submissions?' do
    context 'When an existing author has submissions' do
      before do
        create :submission, author: existing_author
      end
      it 'returns true' do
        expect(view_for_existing_author.author_has_submissions?).to be_true
      end
    end
    context 'When an existing author does not have any submissions' do
      it 'returns false' do
        expect(view_for_existing_author.author_has_submissions?).to be_false
      end
    end
  end

end
