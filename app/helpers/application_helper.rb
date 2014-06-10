module ApplicationHelper

  # Return the set of css classes that should be associated with this page
  def page_classes
    return '' if controller_name.nil? || action_name.nil?
    classes = []
    classes << controller_name.parameterize
    classes << controller_name.singularize.parameterize
    classes << action_name.parameterize
    classes << "maintain" if %w{ new edit create update }.include?(action_name)
    classes.join(" ")
  end

end
