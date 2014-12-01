require 'component/component_spec_helper'
require 'support/ldap_lookup'

describe LdapLookup do

  describe "#LDAP query and map results" do

    context "it should find the author's LDAP entry and initialize author record" do
      let(:author) { create_author_from_ldap }

        it "should return first name" do
          author.first_name.should eql('Joni')
        end
        it "should return last name" do
          author.last_name.should eql('Barnoff')
        end
        it "should return address_1" do
          author.address_1.should eql('003 E Paterno Library')
        end
        it "should return city" do
          author.city.should eql('University Park')
        end
        it "should return state" do
          author.state.should eql('Pennsylvania')
        end
        it "should return zip code" do
          author.zip.should eql('16802')
        end
        it "should return full name" do
          author.full_name.should eql('Joni Lee Barnoff')
        end
        it "should return phone number" do
          author.phone_number.should eql('814-865-4845')
        end
      end

    context "it should return a list of individuals' last name and email address from the LDAP directory" do
      let(:ldap_info) { create_committee_lookup_list }


      it "should return a list of 3 items" do
        ldap_info.mapped_attributes.count().should == 3
      end

      it "should contain individuals full names" do
        ldap_info.mapped_attributes[0][:name].should == 'Joni Lee Barnoff'
        ldap_info.mapped_attributes[2][:name].should == 'Richard M Barnoff'
      end

      it "should contain individuals email addresses" do
        ldap_info.mapped_attributes[0][:email].should == 'jxb13@psu.edu'
        ldap_info.mapped_attributes[1][:email].should == 'meb133@psu.edu'
      end
    end
  end

  describe '#Query LDAP' do


    context "it should return one record from LDAP when given an Access ID that exists in the Penn State Directory" do


      ldap_info = LdapLookup.new(uid: 'jxb13')
      before(:each) do
        LdapLookup.any_instance.stub(:get_ldap_entry).and_return(mock_ldap_list)
      end

      it "should return the LDAP record" do
        ldap_info.ldap_record = ldap_info.get_ldap_entry
        ldap_info.ldap_record.should_not be_nil
        print ldap_info.ldap_record
      end
    end

    context "should return one or more records from LDAP when given a last name that exists in the Penn State Directory" do
      ldap_info = LdapLookup.new(uid: 'barnoff')
      before(:each) do
        LdapLookup.any_instance.stub(:get_ldap_list).and_return(mock_ldap_list)
      end

      it "should return one or more records from LDAP" do
        ldap_info.ldap_record = ldap_info.get_ldap_list
        ldap_info.ldap_record.count().should >= 1
        print ldap_info.ldap_record.inspect
      end
    end

    context "An invalid access id or last name is entered" do
      let(:ldap_info) {LdapLookup.new(uid: '#&&$abc') }

      it "should not be valid" do
        ldap_info.valid?.should_not be_true
      end

      it "should return an error message" do
        ldap_info.valid?
        ldap_info.errors.any?.should be_true
      end

      it "should return an empty ldap_record" do
        ldap_info.ldap_record.should be_nil
      end
    end

  end
end