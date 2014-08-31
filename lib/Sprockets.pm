module Sprockets;
my @extensions = <js html css txt
	png gif jpg jpeg
	otf ttf>;

our sub split-name-and-extension($filename) is export {
	my Str $type;
	my @parts = do for $filename.split('.') {
		# todo : uncomment that when rakudo fixes the regression
		#LAST { $type = $_ }
		#last if $_ eq any(@extensions);
		if $_ eq any(@extensions) {
			$type = $_;
			last;
		}

		$_
	}
	fail "Missing file extension for $filename" unless $type;

	(@parts.join('.'), $type)
}
