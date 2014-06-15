$('.selectpicker').selectpicker()
$('.select2').select2()

$('.vote.inactive').on('click', (e)->
  e.preventDefault()
)

$('.vote-up-btn, .vote-down-btn').on('click', (e)->
  $(this).closest('.vote').addClass('inactive')
)

if $('#chart-canvas').length
  # color: '#FC0'
  # color: '#2AC845'
  $('#chart-canvas').highcharts({
    colors: ['#FC0', '#2AC845'],
    chart: {
      type: 'pie',
      spacingTop: 20,
      marginTop: 20,
      marginBottom: -10
    },
    title: {
      text: '課程評分基準百分比值'
    }
    tooltip: {
      pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
    },
    plotOptions: {
      pie: {
        allowPointSelect: true,
        cursor: 'pointer',
        depth: 35,
        dataLabels: {
          enabled: true,
          format: '{point.name}'
        }
      }
    },
    series: [{
      type: 'pie',
      name: '評分基準比值',
      data: [
        ['報告', 50],
        ['考試', 50]
      ]
    }],
    credits: {
      enabled: false
    }
  })



# The code below here is for demo using, please remove this after function finished.
$('.vote-up-btn, .vote-down-btn').on('click', (e)->
  e.preventDefault()
)