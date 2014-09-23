setup_edit_submission_form = () ->

  form = $('.admin-edit-submission')

  return unless form.length

  program_information = form.find('#program-information')
  committee = form.find('#committee')
  format_review_files = form.find('#format-review-files')
  final_submission_files = form.find('#final-submission-information')
  edit_links = $('.form-edit-link.toggle-link')

  toggle_edit_link = (link) ->
    link.toggleClass('ready-to-lock')
    if link.hasClass('ready-to-lock')
      link.find('.verb').text('Lock')
    else
      link.find('.verb').text('Edit')

  edit_links.on( 'click', (event) ->
    event.preventDefault()
    link = $(this)
    section = link.closest('.form-section-body')
    toggle_editability(section)
    toggle_edit_link(link)
  )

  toggle_editability = (section) ->
    section.toggleClass('read-only')

    inputs = section.find('.can-toggle-editability')
    selects = section.find('.can-toggle-selectability')
    links = section.find('.can-toggle-clickability')

    inputs.each ->
      input = $(this)
      if input.prop('readonly')
        input.prop('readonly', false)
      else
        input.prop('readonly', true)

    selects.each ->
      select = $(this)
      non_selected_options = select.find('option:not(:selected)')
      if non_selected_options.prop('disabled')
        select.removeClass('disabled')
        non_selected_options.prop('disabled', false)
      else
        select.addClass('disabled')
        non_selected_options.prop('disabled', true)

    links.each ->
      link = $(this)
      if link.hasClass('disabled')
        link.removeClass('disabled')
        link.off('click', false)
      else
        link.addClass('disabled')
        link.on('click', false)

  if form.hasClass('waiting-for-final-submission-response')
    program_information.collapse()
    toggle_editability(program_information)
    committee.collapse()
    toggle_editability(committee)
    format_review_files.collapse()
    toggle_editability(format_review_files)

  if form.hasClass('collecting-program-information') || form.hasClass('collecting-committee') || form.hasClass('collecting-format-review-files')
    toggle_editability(program_information)
    toggle_editability(committee)
    toggle_editability(format_review_files)
    edit_links.off('click').addClass('disabled')
    edit_links.on( 'click', false )

  if form.hasClass('collecting-final-submission-files') || form.hasClass('waiting-for-publication-release') || form.hasClass('released-for-publication')
    toggle_editability(program_information)
    toggle_editability(committee)
    toggle_editability(format_review_files)
    toggle_editability(final_submission_files)
    edit_links.off('click').addClass('disabled')
    edit_links.on( 'click', false )

$(document).on('page:load ready', setup_edit_submission_form)