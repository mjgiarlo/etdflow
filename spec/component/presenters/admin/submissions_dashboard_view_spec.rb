require 'component/component_spec_helper'

describe Admin::SubmissionsDashboardView do

  let(:view) { Admin::SubmissionsDashboardView.new(degree_type) }
  let(:degree_type) { 'dissertations' }

  describe '#title' do
    it 'returns the title of the page' do
      expect(view.title).to eq 'Dissertations'
    end
  end

end