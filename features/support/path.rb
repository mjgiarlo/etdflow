module NavigationHelper

  def path_to(page_name)
    case page_name
      when 'the admin programs page' then admin_programs_path
      when 'the new admin program page' then new_admin_program_path
      when 'the admin degrees page' then admin_degrees_path
      when 'the new admin degree page' then new_admin_degree_path
      when 'the admin authors page' then admin_authors_path
      else
        raise ArgumentError, 'Cannot find path mapping for page called #{page_name.inspect}'
    end
  end

end

World(NavigationHelper)
