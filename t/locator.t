use lib './t/';
use Test;
use Lib::TestHelper;

my $locator = get-locator;
sub file-path($path, $ext) {
	$locator.find-file($path, $ext).realpath.subst('\\', '/', :g);
}

plan 4;

is file-path('a', 'js'), 't/data/themes/default/javascripts/a.js', "Can find a file in a 'shallow' structure";
is file-path('file.min', 'js'), 't/data/themes/_shared/javascripts/file.min.js', "Can find a file with dots in its name";
is file-path('multi', 'js'), 't/data/lib/javascripts/multi.js.extensions', "Can find a file with multiple extensions in its name";
is file-path('i', 'png'), 't/data/themes/_shared/images/i.png', "Finds the correct prefix";


