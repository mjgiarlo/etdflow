require 'component/component_spec_helper'

describe Author do

  specify { expect(subject).to have_db_column :access_id }
  specify { expect(subject).to have_db_column :first_name }
  specify { expect(subject).to have_db_column :last_name }
  specify { expect(subject).to have_db_column :middle_name }
  specify { expect(subject).to have_db_column :alternate_email_address }
  specify { expect(subject).to have_db_column :psu_email_address }
  specify { expect(subject).to have_db_column :phone_number }
  specify { expect(subject).to have_db_column :address_1 }
  specify { expect(subject).to have_db_column :address_2 }
  specify { expect(subject).to have_db_column :city }
  specify { expect(subject).to have_db_column :state }
  specify { expect(subject).to have_db_column :zip }
  specify { expect(subject).to have_db_column :is_alternate_email_public }

  specify { expect(subject).to validate_presence_of :access_id }
  specify { expect(subject).to validate_presence_of :first_name }
  specify { expect(subject).to validate_presence_of :last_name }
  specify { expect(subject).to validate_presence_of :middle_name }
  specify { expect(subject).to validate_presence_of :alternate_email_address }
  specify { expect(subject).to validate_presence_of :psu_email_address }
  specify { expect(subject).to validate_presence_of :phone_number }
  specify { expect(subject).to validate_presence_of :address_1 }
  specify { expect(subject).to validate_presence_of :city }
  specify { expect(subject).to validate_presence_of :state }
  specify { expect(subject).to validate_presence_of :zip }

  specify { expect(subject).to have_many :submissions }

  specify { expect(subject).to ensure_inclusion_of(:state).in_array(Author::USSTATES) }

    it 'only accepts correctly formatted email_addresses' do
      expect( FactoryGirl.build(:author, alternate_email_address: 'xyz-123@yahoo.com') ).to be_valid
      expect( FactoryGirl.build(:author, alternate_email_address: 'xyz-123 .com') ).to_not be_valid
    end

    it 'only accepts correctly formatted phone numbers' do
      expect( FactoryGirl.build(:author, phone_number: '123-456-7890') ).to be_valid
      expect( FactoryGirl.build(:author, phone_number: '(123) 456-7890') ).to be_valid
      expect( FactoryGirl.build(:author, phone_number: '1234567890') ).to be_valid
      expect( FactoryGirl.build(:author, phone_number: '123-xyz-7890') ).to_not be_valid
      expect( FactoryGirl.build(:author, phone_number: '1234-567890') ).to_not be_valid
      expect( FactoryGirl.build(:author, phone_number: '123456789') ).to_not be_valid
      expect( FactoryGirl.build(:author, phone_number: '12345678901') ).to_not be_valid
    end

    it 'only accepts correctly formatted zip codes' do
      expect( FactoryGirl.build(:author, zip: '07843') ).to be_valid
      expect( FactoryGirl.build(:author, zip: '07843-1234') ).to be_valid
      expect( FactoryGirl.build(:author, zip: '078431-1234') ).to_not be_valid
      expect( FactoryGirl.build(:author, zip: '07843-12345') ).to_not be_valid
      expect( FactoryGirl.build(:author, zip: 'AB843-1234') ).to_not be_valid
    end

    describe '#full_name' do
      it "returns the author's first middle and last names" do
        author = create :author, first_name: 'Joe',
                                middle_name: 'Quincy',
                                last_name: 'Example'
        expect(author.full_name).to eq 'Joe Quincy Example'
      end
    end

end
