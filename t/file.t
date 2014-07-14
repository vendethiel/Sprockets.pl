use lib './t';
use Test;
use Lib::TestHelper; 

my $locator = get-locator;
plan 1;

is ~$locator.find-file('a', 'js'), q:to/JS/.trim, 'Gets the correct content';
	console.log('hey !');
	JS
