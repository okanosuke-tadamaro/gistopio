wideArea().setOption("defaultColorScheme", "dark");
$('form').hide();

Mousetrap.bind('command+i', function() {
	$('.widearea-icons a').click();
});