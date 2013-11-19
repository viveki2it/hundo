# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# jQuery ->
#  Morris.Line
#    element: 'users_chart'
#    data: $('#users_chart').data('users')
#    xkey: 'purchased_at'
#    ykeys: ['price', 'shipping_price', 'download_price']
#    labels: ['Total Price', 'Shipping Price', 'Download Price']
#    preUnits: '$'

jQuery ->
  Morris.Line
    element: 'users_chart'
    data: $('#users_chart').data('users')
    xkey: 'users_at'
    ykeys: ['total_sells']
    smooth: false
    hideHover: false
    lineColors: ['#ecf0f1']
    labels: ['Total sells']