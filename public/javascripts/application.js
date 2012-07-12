// // Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// Função para exibir datas nas configurações

	$(function() {
        $.datetimepicker.setDefaults($.datepicker.regional['pt-BR']);
        $.datepicker.setDefaults($.datepicker.regional['pt-BR']);
	});


	$(function() {
		$( ".tabs" ).tabs();
	});
jQuery(document).ready(function( $ ){
// Button
    $( ".button").button();
// Curso a distancia
    $('select#titulo_professor_titulo_id').change(function(){
      if ($(this).val() == 7){
        $("#tipo_titulo").show();
        
      }
      else {
        $("#tipo_titulo").hide();
      }
    });
});