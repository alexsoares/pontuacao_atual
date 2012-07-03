// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// Função para exibir datas nas configurações

	$(function() {
        $.datetimepicker.setDefaults($.datepicker.regional['pt-BR']);
        $.datepicker.setDefaults($.datepicker.regional['pt-BR']);
	});


	$(function() {
		$( ".tabs" ).tabs();
	});

// Button
	$(function() {
		$( "input:submit,input, a, button", ".button").button();		
	});
