class Sprockets::Pipeline;

use Sprockets::Locator;

has @.paths;
has @.filters;
has String $.prefix;

has Locator $!locator;

submethod BUILD(|) {
	callsame;

	$!locator = Locator.new(self, @.paths, $.prefix);
}