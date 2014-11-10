require 'component/component_spec_helper'

describe Webaccess do

  let(:vhost_values) {get_vhost_values}
  let (:login_url) {'https://webaccess.psu.edu?cosign-'+vhost_values[0]+"&"+vhost_values[1]}
  let (:logout_url) {'https://webaccess.psu.edu/cgi-bin/logout?'+vhost_values[1]}

  it 'returns the Webaccess login URL for current host and service' do
    webaccess_url = Webaccess.login_url
    expect(webaccess_url).to eq login_url
  end

  it 'returns the Webaccess logout URL for current host' do
    webaccess_url = Webaccess.logout_url
    expect(webaccess_url).to eq logout_url
  end
end

