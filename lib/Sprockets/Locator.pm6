class Sprockets::Locator;

my $extensions = <js html css txt
	png gif jpg jpeg
	otf ttf>;

has %.paths;

method find-file($name, $ext) {
	my sub rm-trail($str) {
		$str.subst(/\/$/, '');
	}

	for %.paths.kv -> $, $ (:@directories, :%prefixes) {
		my $prefix = %prefixes{$ext} ?? "/%prefixes{$ext}" !! "";
		for @directories {
			my $dir = "{.&rm-trail}{rm-trail $prefix}/";
			for dir $dir {
				return "$dir$name.$ext" if (~$_).substr($dir.chars) eq "$name.$ext";
			}
		}
	}
}

sub get-type-for-ext($ext) {
	given $ext {
		return 'img' when 'png' | 'gif' | 'jpg' | 'jpeg';

		return 'font' when 'otf' | 'ttf';
	}
}

my sub split-name-and-extension($filename) {
	my Str $type;
	my @parts = do for $filename.split('.') {
		LAST { $type = $_ }
		last if $_ eq any($extensions);

		$_
	}

	(@parts.join('.'), $type)
}