require 'component/presenters/component_presenters_spec_helper'

describe Admin::SubmissionsDashboardView do

  let(:view) { Admin::SubmissionsDashboardView.new(degree_type) }
  let(:degree_type) { Degree.default_degree_type }

  describe '#title' do
    it 'returns the title of the page' do
      expect(view.title).to eq Degree.default_degree_type.titleize
    end
  end

  describe '#filters' do
    context 'when no submissions exist for each filter' do
      it "returns a set of placeholders according to submission status" do
        expect(view.filters).to eq [
            "<div class='panel panel-default no-submissions'><div class='panel-heading'><h3 class='panel-title'>Format Review is Incomplete <span class='badge pull-right'>0</span></h3></div><div class='panel-body'>Submissions whose format review has not yet been submitted or are currently rejected.</div></a>",
            "<div class='panel panel-default no-submissions'><div class='panel-heading'><h3 class='panel-title'>Format Review is Submitted <span class='badge pull-right'>0</span></h3></div><div class='panel-body'>Submissions whose format review is currently waiting to be approved or rejected.</div></a>"
        ]
      end
    end
    context 'when submissions exist for each filter' do
      before do
        create :submission, :collecting_program_information
        create :submission, :collecting_committee
        create :submission, :collecting_format_review_files
        create :submission, :waiting_for_format_review_response
      end
      it "returns a set of links according to submission status" do
        expect(view.filters).to eq [
            "<a href='#{admin_submissions_format_review_incomplete_path(degree_type)}' class='panel panel-default filter'><div class='panel-heading'><h3 class='panel-title'>Format Review is Incomplete <span class='badge pull-right'>3</span></h3></div><div class='panel-body'>Submissions whose format review has not yet been submitted or are currently rejected.</div></a>",
            "<a href='#{admin_submissions_format_review_submitted_path(degree_type)}' class='panel panel-default filter'><div class='panel-heading'><h3 class='panel-title'>Format Review is Submitted <span class='badge pull-right'>1</span></h3></div><div class='panel-body'>Submissions whose format review is currently waiting to be approved or rejected.</div></a>"
        ]
      end
    end
  end
end
