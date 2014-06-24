class Paper
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :author_id

  def persisted?
    false
  end

  def self.ask_to_display_email?
    Etdflow::Application.config.display_is_alternate_email_public_question
  end

end