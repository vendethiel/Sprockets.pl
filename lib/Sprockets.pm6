module Sprockets {
	my @extensions = <js html css txt
		png gif jpg jpeg
		otf ttf>;

	our sub split-name-and-extension($filename) is export {
		my Str $type;
		my @parts = do for $filename.split('.') {
			LAST { $type = $_ }
			last if $_ eq any(@extensions);

			$_
		}
		fail "Missing file extension for $filename" unless $type;

		(@parts.join('.'), $type)
	}
}