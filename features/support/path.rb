module NavigationHelper

  def path_to(page_name)
    case page_name
      when 'the programs page' then programs_path
      else
        raise ArgumentError, 'Cannot find path mapping for page called #{page_name.inspect}'
    end
  end

end

World(NavigationHelper)
