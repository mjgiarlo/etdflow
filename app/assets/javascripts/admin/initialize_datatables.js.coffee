#= require dataTables.js
#= require dataTables.bootstrap.js

setup_datatables = () ->

  $('.datatable').dataTable(
    processing: true
    pageLength: 25
    stateSave: true
    stateDuration: 60 * 60 * 24
  )

$(document).on('page:load ready', setup_datatables)