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

plan 2;

is $locator.find-file('a', 'js'), 't/data/themes/default/javascripts/a.js', "Can find a file in a 'shallow' structure";
is $locator.find-file('i', 'png'), 't/data/themes/_shared/images/i.png', "Finds the correct prefix";