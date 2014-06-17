require 'component/component_spec_helper'

describe Program do

  let(:program) { Program.new }

  specify { expect(subject).to have_db_column :name }
  specify { expect(subject).to have_db_column :is_active }

  specify { expect(subject).to validate_presence_of :name }

  specify { expect(subject).to validate_uniqueness_of :name }

  describe '#inactive?' do
    context 'When is_active is false' do
      before { program.is_active = false }
      it 'returns true' do
        expect(program.inactive?).to be_true
      end
    end
    context 'When is_active is true' do
      before { program.is_active = true }
      it 'returns false' do
        expect(program.inactive?).to be_false
      end
    end
    context 'When is_active is nil' do
      before { program.is_active = nil }
      it 'returns true' do
        expect(program.inactive?).to be_true
      end
    end
  end

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
end
