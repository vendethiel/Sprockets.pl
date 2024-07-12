use lib './t', './lib';
use Test;
use lib::testhelper;

my $locator = get-locator;
plan 3;

is ~$locator.find-file('a', 'js'), q:to/JS/.trim, 'Gets the correct content, and make sure an included file remembers where it is';
	console.log('hey !');
  foo;
  // Main component
  class Component {};
  relative;
  parent;
  JS

is ~$locator.find-file('multi', 'js'), q:to/JS/.trim, 'Parses filters';
  perl();
  JS

is ~$locator.find-file('components/main', 'js'), q:to/JS/.trim, 'Path component stays even when it was part of the included name';
  // Main component
  class Component {};
  relative;
  parent;
  JS
