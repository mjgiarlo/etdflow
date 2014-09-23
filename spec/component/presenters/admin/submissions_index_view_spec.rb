require 'component/presenters/component_presenters_spec_helper'

describe Admin::SubmissionsIndexView do

  let(:view) { Admin::SubmissionsIndexView.new(degree_type, scope) }
  let(:degree_type) { Degree.default_degree_type }

  describe '#title' do
    context "when scope is format review is incomplete" do
      let(:scope) { 'format_review_incomplete' }
      it "returns 'Format Review is Incomplete'" do
        expect(view.title).to eq 'Format Review is Incomplete'
      end
    end
    context "when scope is format review is submitted" do
      let(:scope) { 'format_review_submitted' }
      it "returns 'Format Review is Submitted'" do
        expect(view.title).to eq 'Format Review is Submitted'
      end
    end
    context "when scope is final submission is incomplete" do
      let(:scope) { 'final_submission_incomplete' }
      it "returns 'Final Submission is Incomplete'" do
        expect(view.title).to eq 'Final Submission is Incomplete'
      end
    end
    context "when scope is final submission is submitted" do
      let(:scope) { 'final_submission_submitted' }
      it "returns 'Final Submission is Submitted'" do
        expect(view.title).to eq 'Final Submission is Submitted'
      end
    end
    context "when scope is final submission is approved" do
      let(:scope) { 'final_submission_approved' }
      it "returns 'Final Submission is Approved'" do
        expect(view.title).to eq 'Final Submission is Approved'
      end
    end
    context "when scope is released for publication" do
      let(:scope) { 'released_for_publication' }
      it "returns 'Released eTDs'" do
        expect(view.title).to eq 'Released eTDs'
      end
    end
  end

  describe '#id' do
    context "when scope is format review is incomplete" do
      let(:scope) { 'format_review_incomplete' }
      it "returns 'incomplete-format-review-submissions-index'" do
        expect(view.id).to eq 'incomplete-format-review-submissions-index'
      end
    end
    context "when scope is format review is submitted" do
      let(:scope) { 'format_review_submitted' }
      it "returns 'submitted-format-review-submissions-index'" do
        expect(view.id).to eq 'submitted-format-review-submissions-index'
      end
    end
    context "when scope is final submission is incomplete" do
      let(:scope) { 'final_submission_incomplete' }
      it "returns 'incomplete-final-submission-submissions-index'" do
        expect(view.id).to eq 'incomplete-final-submission-submissions-index'
      end
    end
    context "when scope is final submission is submitted" do
      let(:scope) { 'final_submission_submitted' }
      it "returns 'submitted-final-submission-submissions-index'" do
        expect(view.id).to eq 'submitted-final-submission-submissions-index'
      end
    end
    context "when scope is final submission is approved" do
      let(:scope) { 'final_submission_approved' }
      it "returns 'approved-final-submission-submissions-index'" do
        expect(view.id).to eq 'approved-final-submission-submissions-index'
      end
    end
    context "when scope is released for publication" do
      let(:scope) { 'released_for_publication' }
      it "returns 'released-for-publication-submissions-index'" do
        expect(view.id).to eq 'released-for-publication-submissions-index'
      end
    end
  end

  describe '#render_release_for_publication_button?' do
    context "when scope is format review is incomplete" do
      let(:scope) { 'format_review_incomplete' }
      it "returns false" do
        expect(view.render_release_for_publication_button?).to be_false
      end
    end
    context "when scope is format review is submitted" do
      let(:scope) { 'format_review_submitted' }
      it "returns false" do
        expect(view.render_release_for_publication_button?).to be_false
      end
    end
    context "when scope is final submission is incomplete" do
      let(:scope) { 'final_submission_incomplete' }
      it "returns false" do
        expect(view.render_release_for_publication_button?).to be_false
      end
    end
    context "when scope is final submission is submitted" do
      let(:scope) { 'final_submission_submitted' }
      it "returns false" do
        expect(view.render_release_for_publication_button?).to be_false
      end
    end
    context "when scope is final submission is approved" do
      let(:scope) { 'final_submission_approved' }
      it "returns true" do
        expect(view.render_release_for_publication_button?).to be_true
      end
    end
    context "when scope is released for publication" do
      let(:scope) { 'released_for_publication' }
      it "returns false" do
        expect(view.render_release_for_publication_button?).to be_false
      end
    end
  end
end