$(document).ready(function() {
  chart = new Highcharts.Chart({
    chart: {
      renderTo: 'graph',
      events: {
        load: requestData
      },
      type: 'scatter'
    },
    title: {
      text: 'Issues'
    },
    xAxis: {
      title: { text: 'Creation' }, type: 'datetime'
    },
    yAxis: {
      title: { text: 'Lead time' }, min: 0
    },
    series: [
      {
        name: 'issues',
        data: []
      }
    ]
  });

  function requestData() {
    $.ajax({
      url: '/api/v1/issues',
      success: function (data) {
        parsedData = data.map(function(row) {
          created_at = Date.parse(row.created_at);
          closed_at = Date.parse(row.closed_at);

          differenceInDays = Math.abs(created_at.valueOf() - closed_at.valueOf()) / 1000 / 60 / 60 / 24;

          return [ created_at, differenceInDays ]
        }).reverse();

        chart.series[0].setData(parsedData);
      }
    });
  }
});