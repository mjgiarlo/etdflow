require 'component/component_spec_helper'

describe Program do

  let(:program) { Program.new }

  specify { expect(subject).to have_db_column :name }
  specify { expect(subject).to have_db_column :is_active }

  specify { expect(subject).to validate_presence_of :name }

  specify { expect(subject).to validate_uniqueness_of :name }

  specify { expect(subject).to have_many :submissions }

  describe '#active_status' do
    context 'When is_active is false' do
      before { program.is_active = false }
      it 'returns No' do
        expect(program.active_status).to eq('No')
      end
    end
    context 'When is_active is true' do
      before { program.is_active = true }
      it 'returns Yes' do
        expect(program.active_status).to eq('Yes')
      end
    end
    context 'When is_active is nil' do
      before { program.is_active = nil }
      it 'returns No' do
        expect(program.active_status).to eq('No')
      end
    end
  end

  describe '#set_is_active_to_true' do
    it "Sets activation status to true for new instances" do
      expect(program.is_active).to be_true
    end
  end
end
