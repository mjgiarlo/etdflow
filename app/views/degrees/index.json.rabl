object false

node(:data) do
  table = @degrees.map do |degree|
    row = [
        "<a href=#{edit_degree_path(degree)}>#{degree.name}</a>",
        degree.description,
        degree.degree_type,
        degree.active_status
    ]
  end
end