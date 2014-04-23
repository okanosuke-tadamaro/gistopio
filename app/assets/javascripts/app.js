//SET WIDEAREA AND HIDE FORM
wideArea().setOption("defaultColorScheme", "dark");
$('form').hide();

//KEY-BINDINGS FOR FORM
Mousetrap.bind('command+i', function() {
	$('.new_form .widearea-icons a').click();
});
Mousetrap.bind('command+enter', function() {
	$('form.new_form :submit').click();
});