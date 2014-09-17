object false

node(:data) do
  table = @submissions.map do |submission|
    row = [
        submission.id,
        "<input type='checkbox' class='row-checkbox' />",
        "<a href='#admin_edit_submission_path(submission)'>#{submission.title}</a>",
        submission.author_last_name,
        submission.author_first_name
    ]
  end
end