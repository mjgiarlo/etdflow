require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"

# require "rails/test_unit/railtie"


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Etdflow
  class Application < Rails::Application

    # Precompile additional assets.
    # application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
    config.assets.precompile += %w( author.css admin.css base.js author.js admin.js )

    config.autoload_paths += [
      Rails.root.join('app/presenters'),
      Rails.root.join('app/datastreams'),
    ]
    config.autoload_paths += Dir["#{config.root}/lib/**/*"]

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.hosts_vhosts_map = {
        'etda1qa' => 'https://etda-qa.dlt.psu.edu/',
        'etda2qa' => 'https://etda-qa.dlt.psu.edu/',
        'etda1stage' => 'https://etda-staging.dlt.psu.edu/',
        'etda2stage' => 'https://etda-staging.dlt.psu.edu/',
        'etda1prod' => 'https://etda.dlt.psu.edu/',
        'etda2prod' => 'https://etda.dlt.psu.edu/'
    }

    # Partner name
    config.partner_name = "Graduate School"

    # Partner website
    config.partner_url = "http://www.gradschool.psu.edu/index.cfm/current-students/etd/"

    # Partner description
    config.partner_description = "The primary purpose of a thesis or dissertation is to train the student in the process of scholarly research and writing under the direction of members of the Graduate Faculty. After the student has graduated and the work is published, it serves as a contribution to human knowledge, is useful to other scholars and perhaps even to a more general audience. Electronic thesis and dissertations (eTDs) expand the creative possibilities open to students and empower students to convey a richer message by permitting video, sound, and color images to be integrated into their work. Submitting and archiving eTDs helps students to understand electronic publishing issues and provides greater acess to students' research. Through the Web, people from any place on the globe can link directly to eTD collections at Penn State and other universities."

    # Slug (this is used to generate the dev url, production url, and the path name
    config.slug  = "etd"

    # Partner email address
    config.partner_email_address = "gradthesis@psu.edu"

    # Should the paper form display the "Display your alternate email address on your eTD document summary page?" question?
    config.display_is_alternate_email_public_question = true

    # Supply the types of degrees available within your institution:
    config.degree_types = [
                            {
                              singular: "Dissertation",
                              plural:   "Dissertations"
                            },
                            {
                              singular: "Master Thesis",
                              plural:   "Master Theses"
                            }
                          ].freeze

    # Supply the structure of the committee
    config.committee_advisor_role = "Advisor"
    config.committee_other_required_roles = [
                                             "Committee Chair",
                                             "Committee Member",
                                             "Special Member"
                                            ].freeze



  end
end
