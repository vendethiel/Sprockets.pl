class Sprockets::Pipeline;
use Sprockets::Locator;

# Locator itself
has %.paths;
has @.filters;

has Locator $!locator;

submethod BUILD(|) {
	callsame;

	$!locator = Locator.new(:%.paths);
}
