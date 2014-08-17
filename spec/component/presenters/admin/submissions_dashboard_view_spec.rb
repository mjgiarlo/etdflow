require 'component/component_spec_helper'

describe Admin::SubmissionsDashboardView do

  let(:view) { Admin::SubmissionsDashboardView.new(degree_type) }
  let(:degree_type) { Degree.default_degree_type }

  describe '#title' do
    it 'returns the title of the page' do
      expect(view.title).to eq Degree.default_degree_type.titleize
    end
  end

  describe '#filters' do
    before do
      2.times { create :submission, status: 'collecting committee' }
    end
    it "returns a set of links according to submission status" do
      expect(view.filters).to eq ["<a href='something'> Format Review is Incomplete <span>2</span></a>"]
    end 
  end

end
