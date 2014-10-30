class Webaccess

  #Build Webaccess login/logout URLs for current environment using hosts_vhosts_map in config/application.rb

  def self.login_url
    "https://webaccess.psu.edu?cosign-#{self.vservice}&#{self.vhost}"
  end

  def self.logout_url
    "https://webaccess.psu.edu/cgi-bin/logout?#{self.vhost}"
  end

  private

  def self.get_vhost_info
    hostname = Socket.gethostname
    vhost=Etdflow::Application.config.hosts_vhosts_map[hostname] || "https://#{hostname}/"
    uri = URI.parse(vhost)
    service = uri.host
    port = uri.port
    service << "-#{port}" unless port == 443
    [service, vhost]
  end

  def self.vhosts(val)
    @vhosts ||= self.get_vhost_info
    @vhosts[val]
  end

  def self.vhost
    self.vhosts(1)
  end

  def self.vservice
    self.vhosts(0)
  end


end