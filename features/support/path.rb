module NavigationHelper

  def path_to(page_name)
    case page_name
      when 'the programs page' then programs_path
      when 'the new program page' then new_program_path
      when 'the degrees page' then degrees_path
      when 'the new degree page' then new_degree_path
      when 'the authors page' then authors_path
      else
        raise ArgumentError, 'Cannot find path mapping for page called #{page_name.inspect}'
    end
  end

end

World(NavigationHelper)
