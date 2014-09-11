module NavigationHelper

  def path_to(page_name)
    case page_name
      when 'the admin programs page' then admin_programs_path
      when 'the new admin program page' then new_admin_program_path
      when 'the admin degrees page' then admin_degrees_path
      when 'the new admin degree page' then new_admin_degree_path
      when 'the admin authors page' then admin_authors_path
      when 'the author submissions page' then author_root_path
      when 'the new author page' then new_author_author_path
      when 'the new submission program information page' then new_author_submission_path
      when 'the admin dashboard page' then admin_dashboard_path
      when 'the admin master thesis submissions page' then admin_submissions_dashboard_path('master_theses')
      when 'the admin default type incomplete format review submissions page' then admin_submissions_format_review_incomplete_path(Degree.default_degree_type)
      else
        raise ArgumentError, 'Cannot find path mapping for page called #{page_name.inspect}'
    end
  end

end

World(NavigationHelper)
