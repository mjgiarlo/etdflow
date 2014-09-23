object false

node(:data) do
  table = @view.submissions.map do |submission|
    row = [
        submission.id,
        "<input type='checkbox' class='row-checkbox' />",
        submission.admin_index_title,
        submission.author_last_name,
        submission.author_first_name
    ]
  end
end