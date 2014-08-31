class Sprockets::Pipeline;
use Sprockets::Locator;

# Filters part...
# To be moved out, I guess
# I still need to decide if I want this to be per-Pipeline,
# but there doesn't seem to be a reason to
our %filters =
  'coffee' => sub { !!! },
  'pl' => &EVAL, # more like EVIL amirite
  ;

our apply-filters(@filters, $content) {
  $content;
}

# Locator itself
has %.paths;
has @.filters;

has Locator $!locator;

submethod BUILD(|) {
	callsame;

	$!locator = Locator.new(:%.paths);
}
