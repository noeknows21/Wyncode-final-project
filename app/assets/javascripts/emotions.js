$(function () {
  
  var smileString = $('#smile_array').val();
  var smileNumberArray = smileString.split(' ').map(Number);
  var frownString = $('#frown_array').val();
  var frownNumberArray = frownString.split(' ').map(Number);
  
    $('#container').highcharts({
        title: {
            text: 'Customer Emotions During Video Chat',
            x: -20 //center
        },
        subtitle: {
           
            x: -20
        },
        xAxis: {
        title: {
        	text: 'Seconds Elapsed'
        },
        
            categories: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
        },
        yAxis: {
            title: {
                text: 'Emotion Intensity'
            },
            plotLines: [{
                value: 0,
                width: 1,
                color: '#808080'
            }]
        },
        tooltip: {
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle',
            borderWidth: 0
        },
        series: [{
            name: 'Positive',
            data: smileNumberArray
        }, {
            name: 'Negative',
            data: frownNumberArray
        }]
    });
});