require 'component/component_spec_helper'

shared_examples_for "a format review class" do
  let(:format_review) { described_class.new }

  describe '#save' do
    let(:method) { format_review.method(:save) }
    it "exists" do
      expect(method).not_to be_nil
    end
    it "requires one argument" do
      expect(method.parameters).to eq [ [:req, :files] ]
    end
    context "when argument is blank" do
      it "raises an error" do
        expect { format_review.save }.to raise_error(ArgumentError)
      end
    end
    context "when argument is not an array of uploaded files" do
      it "raises an error" do
        expect { format_review.save ['1', '2'] }.to raise_error(ArgumentError)
      end
    end
  end

end
