//$(document).ready(function() {
//    $(".calendario").datepicker({
//        dateFormat: 'dd/mm/yy',
//        dayNames: ['Domingo','Segunda','Terça','Quarta','Quinta','Sexta','Sábado','Domingo'],
//        dayNamesMin: ['D','S','T','Q','Q','S','S','D'],
//        dayNamesShort: ['Dom','Seg','Ter','Qua','Qui','Sex','Sáb','Dom'],
//        monthNames: ['Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
//        monthNamesShort: ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'],
//        changeMonth: true,
//        changeYear: true,		
//	yearRange: '1920:2050'
		
//    });
//});

$(document).ready(function() {

//$(document).on('turbolinks:load', function() {

    $(".calendario").datepicker({
        dateFormat: 'dd/mm/yy',
        dayNames: ['Domingo','Segunda','Terça','Quarta','Quinta','Sexta','Sábado','Domingo'],
        dayNamesMin: ['D','S','T','Q','Q','S','S','D'],
        dayNamesShort: ['Dom','Seg','Ter','Qua','Qui','Sex','Sáb','Dom'],
        monthNames: ['Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
        monthNamesShort: ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'],
        changeMonth: true,
        changeYear: true,     
        yearRange: '1920:2050'
        
    });

//});

});
