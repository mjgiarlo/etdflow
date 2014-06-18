#= require dataTables.js

setup_datatables = () ->

  $('.datatable').dataTable(
    'processing': true
    'pageLength': 25
  )

$(document).on('page:load ready', setup_datatables)