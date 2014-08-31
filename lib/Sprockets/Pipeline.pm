class Sprockets::Pipeline;

use Sprockets::Locator;

has %.paths;
has @.filters;

has Locator $!locator;

submethod BUILD(|) {
	callsame;

	$!locator = Locator.new(:%.paths);
}