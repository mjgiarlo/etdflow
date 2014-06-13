# This allows the footer to stick to the bottom of viewport
# if the page content is shorter then the viewport

#= require breakpoints.js

setup_layout = () ->

  # Set breakpoints for responsive function calls
  $window = $(window)
  $window.setBreakpoints
    distinct: true,
    breakpoints: [ 768, 992, 1200 ]

  body_container = $('#body-container')
  header_row = body_container.find('#header-row')
  footer_row = body_container.find('#footer-row')
  content_row = body_container.find('#content-row')
  header = header_row.find('header')
  footer = footer_row.find('.nav')

  set_header_and_footer_spacing = () ->
    header_height = header.outerHeight(true)
    footer_height = footer.outerHeight(true)
    footer_padding = 20
    bottom_height = footer_height + footer_padding

    content_row.css(
      'padding-top': header_height
      'padding-bottom': bottom_height
    )
    header_row.css('margin-bottom', -header_height)
    footer_row.css('margin-top', -footer_height)

  $window.bind('enterBreakpoint768 exitBreakpoint768', set_header_and_footer_spacing)
  set_header_and_footer_spacing()

$(document).on('page:load ready', setup_layout)

