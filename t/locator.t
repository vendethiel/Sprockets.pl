BEGIN { @*INC.push: './lib/' }
use Sprockets::Locator;
use Test;


my $locator = Sprockets::Locator.new(paths => {
	template => {
		directories => <t/data/themes/_shared/ t/data/themes/default/ t/data/lib/>,
		prefixes => {js => 'javascripts', css => 'stylesheets', img => 'images'}
	},
	vendor => {
		directories => ('t/data/vendor/',)
	},
});

sub file-path($path, $ext) {
	$locator.find-file($path, $ext).subst('\\', '/', :g);
}

plan 4;

is file-path('a', 'js'), 't/data/themes/default/javascripts/a.js', "Can find a file in a 'shallow' structure";
is file-path('file.min', 'js'), 't/data/themes/_shared/javascripts/file.min.js', "Can find a file with dots in its name";
is file-path('multi', 'js'), 't/data/lib/javascripts/multi.js.extensions', "Can find a file with multiple extensions in its name";
is file-path('i', 'png'), 't/data/themes/_shared/images/i.png', "Finds the correct prefix";