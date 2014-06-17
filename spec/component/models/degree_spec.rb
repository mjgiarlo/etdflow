require 'component/component_spec_helper'

describe Degree do

  let(:degree) { Degree.new }

  specify { expect(subject).to have_db_column :name }
  specify { expect(subject).to have_db_column :description }
  specify { expect(subject).to have_db_column :degree_type }
  specify { expect(subject).to have_db_column :is_active }

  specify { expect(subject).to validate_presence_of :name }
  specify { expect(subject).to validate_presence_of :description }
  specify { expect(subject).to validate_presence_of :degree_type }

  specify { expect(subject).to ensure_inclusion_of(:degree_type).in_array(Degree::DEGREE_TYPES) }

  specify { expect(subject).to validate_uniqueness_of :name }

  describe '#inactive?' do
    context 'When is_active is false' do
      before { degree.is_active = false }
      it 'returns true' do
        expect(degree.inactive?).to be_true
      end
    end
    context 'When is_active is true' do
      before { degree.is_active = true }
      it 'returns false' do
        expect(degree.inactive?).to be_false
      end
    end
    context 'When is_active is nil' do
      before { degree.is_active = nil }
      it 'returns true' do
        expect(degree.inactive?).to be_true
      end
    end
  end

  describe '#active_status' do
    context 'When is_active is false' do
      before { degree.is_active = false }
      it 'returns No' do
        expect(degree.active_status).to eq('No')
      end
    end
    context 'When is_active is true' do
      before { degree.is_active = true }
      it 'returns Yes' do
        expect(degree.active_status).to eq('Yes')
      end
    end
    context 'When is_active is nil' do
      before { degree.is_active = nil }
      it 'returns No' do
        expect(degree.active_status).to eq('No')
      end
    end
  end
end
