initialize_collapse_links = () ->

  collapsible_content = $('.collapse')

  return unless collapsible_content.length

  collapsible_content.on('show.bs.collapse', ->
    content_id = '#' + $(this).attr('id')
    link = $('span[data-target=' + content_id + ']')
    link.text '[hide]'
  ).on('hide.bs.collapse', ->
    content_id = '#' + $(this).attr('id')
    link = $('span[data-target=' + content_id + ']')
    link.text '[show]'
  )

$(document).on('page:load ready', initialize_collapse_links)