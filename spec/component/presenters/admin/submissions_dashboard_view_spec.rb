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
            {
                id: 'format-review-incomplete',
                title: 'Format Review is Incomplete',
                description: 'Submissions whose format review has not yet been submitted or whose format review is currently rejected.',
                path: nil,
                count: nil
            },
            {
                id: 'format-review-submitted',
                title: 'Format Review is Submitted',
                description: 'Submissions whose format review is currently waiting to be approved or rejected.',
                path: nil,
                count: nil
            },
            {
                id: 'final-submission-incomplete',
                title: 'Final Submission is Incomplete',
                description: 'Submissions whose format review information has been approved, but whose final submission information has not yet been submitted or whose final submission information is currently rejected.',
                path: nil,
                count: nil
            },
            {
                id: 'final-submission-submitted',
                title: 'Final Submission is Submitted',
                description: 'Submissions whose final submission information is currently waiting to be approved or rejected.',
                path: nil,
                count: nil
            },
            {
                id: 'final-submission-approved',
                title: 'Final Submission is Approved',
                description: 'Submissions whose final submission information has been approved and is waiting to be released for publication.',
                path: nil,
                count: nil
            },
            {
                id: 'released-for-publication',
                title: 'Released eTDs',
                description: 'Electronic Theses and Dissertations of all access levels that have been released for publication.',
                path: nil,
                count: nil
            }
        ]
      end
    end
    context 'when submissions exist for each filter' do
      before do
        create :submission, :collecting_program_information
        create :submission, :collecting_committee
        create :submission, :collecting_format_review_files
        create :submission, :waiting_for_format_review_response
        create :submission, :collecting_final_submission_files
        create :submission, :waiting_for_final_submission_response
        create :submission, :waiting_for_publication_release
        create :submission, :released_for_publication
      end
      it "returns a set of links according to submission status" do
        expect(view.filters).to eq [
            {
                id: 'format-review-incomplete',
                title: 'Format Review is Incomplete',
                description: 'Submissions whose format review has not yet been submitted or whose format review is currently rejected.',
                path: admin_submissions_format_review_incomplete_path(degree_type),
                count: '3'
            },
            {
                id: 'format-review-submitted',
                title: 'Format Review is Submitted',
                description: 'Submissions whose format review is currently waiting to be approved or rejected.',
                path: admin_submissions_format_review_submitted_path(degree_type),
                count: '1'
            },
            {
                id: 'final-submission-incomplete',
                title: 'Final Submission is Incomplete',
                description: 'Submissions whose format review information has been approved, but whose final submission information has not yet been submitted or whose final submission information is currently rejected.',
                path: admin_submissions_final_submission_incomplete_path(degree_type),
                count: '1'
            },
            {
                id: 'final-submission-submitted',
                title: 'Final Submission is Submitted',
                description: 'Submissions whose final submission information is currently waiting to be approved or rejected.',
                path: admin_submissions_final_submission_submitted_path(degree_type),
                count: '1'
            },
            {
                id: 'final-submission-approved',
                title: 'Final Submission is Approved',
                description: 'Submissions whose final submission information has been approved and is waiting to be released for publication.',
                path: admin_submissions_final_submission_approved_path(degree_type),
                count: '1'
            },
            {
                id: 'released-for-publication',
                title: 'Released eTDs',
                description: 'Electronic Theses and Dissertations of all access levels that have been released for publication.',
                path: admin_submissions_released_for_publication_path(degree_type),
                count: '1'
            }
        ]
      end
    end
  end
end
