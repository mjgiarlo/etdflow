require 'component/component_spec_helper'

describe Degree do

  let(:degree) { Degree.new }

  specify { expect(subject).to have_db_column :name }
  specify { expect(subject).to have_db_column :description }
  specify { expect(subject).to have_db_column :degree_type }
  specify { expect(subject).to have_db_column :is_active }
  specify { expect(subject).to have_db_column :created_at }
  specify { expect(subject).to have_db_column :updated_at }

  specify { expect(subject).to validate_presence_of :name }
  specify { expect(subject).to validate_presence_of :description }
  specify { expect(subject).to validate_presence_of :degree_type }

  specify { expect(subject).to ensure_inclusion_of(:degree_type).in_array(Etdflow::Application.config.degree_types) }

  specify { expect(subject).to validate_uniqueness_of :name }

  specify { expect(subject).to have_many :submissions }

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

  describe '#set_is_active_to_true' do
    it "Sets activation status to true for new instances" do
      expect(degree.is_active).to be_true
    end
  end
end
