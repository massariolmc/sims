$(function() {
    $('#esquadrao').hide();
    $('#pessoa').change(function(){
        if($('#pessoa').val() == '1') {
            $('#esquadrao').show(); 
        } else {
            $('#esquadrao').hide(); 
        } 
    });
});