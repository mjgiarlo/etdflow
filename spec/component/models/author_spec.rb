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

  specify { expect(subject).to ensure_inclusion_of(:state).in_array(Author::USSTATES) }

  describe 'Email format validation:' do
    it 'accepts properly formatted email_addresses' do
      expect( FactoryGirl.build(:author, alternate_email_address: 'xyz-123@yahoo.com') ).to be_valid
    end
    it 'does not accept improperly formatted email_addresses' do
      expect( FactoryGirl.build(:author, alternate_email_address: 'xyz-123 .com') ).to_not be_valid
    end
  end

end
