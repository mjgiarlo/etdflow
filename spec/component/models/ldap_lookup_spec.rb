require 'component/component_spec_helper'

describe LdapLookup do

#  author_attributes = LdapLookup.map_author_attributes(ldap_entry)
#  author = Author.create(author_attributes)
  author = create_author_from_ldap

  it "should map author's entry from LDAP into an author record" do
    author.first_name.should eql('Joni')
    author.last_name.should eql('Barnoff')
    author.address_1.should eql('003 E Paterno Library')
    author.city.should eql('University Park')
    author.state.should eql('Pennsylvania')
    author.zip.should eql('16802')
    author.full_name.should eql('Joni Lee Barnoff')
    author.phone_number.should eql('814-865-4845')
  end
end