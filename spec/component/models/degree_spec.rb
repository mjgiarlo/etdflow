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

  specify { expect(subject).to ensure_inclusion_of(:degree_type).in_array Degree.degree_types }

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

  describe '.degree_types_json' do
    it 'returns a set of key-value pairs that represent each configured degree type' do
      Degree.degree_types_json.each_with_index do |type, i|
          expect(type["singular"]).to eq Etdflow::Application.config.degree_types[i][:singular]
          expect(type["plural"]).to eq Etdflow::Application.config.degree_types[i][:plural]
          expect(type["parameter"]).to eq Etdflow::Application.config.degree_types[i][:plural].parameterize.underscore
      end
    end
  end

  describe '.default_degree_type' do
    it 'returns the parameter of the first configured degree type' do
      expect(Degree.default_degree_type).to eq Etdflow::Application.config.degree_types[0][:plural].parameterize.underscore
    end
  end
end
