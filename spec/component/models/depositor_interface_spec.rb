require 'component/component_spec_helper'

shared_examples_for "a depositor class" do
  let(:depositor) { described_class }

  describe '.save' do
    let(:method) { depositor.method(:save) }
    it "exists" do
      expect(method).not_to be_nil
    end
    it "requires two arguments" do
      expect(method.parameters).to eq [ [:req, :submission], [:req, :files] ]
    end
    context "when submission is blank" do
      it "raises an error" do
        expect { depositor.save(nil, files) }.to raise_error(ArgumentError)
      end
    end
    context "when files are blank" do
      it "raises an error" do
        expect { depositor.save(submission, nil) }.to raise_error(ArgumentError)
      end
    end
    context "when argument is not an array of uploaded files" do
      it "raises an error" do
        expect { depositor.save(submission, ['1', '2']) }.to raise_error(ArgumentError)
      end
    end
  end

end
