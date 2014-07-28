class FormatReview
  include ActiveModel::Model

  attr_reader :submission

  def initialize(submission=nil)
    @submission = submission
  end

end
