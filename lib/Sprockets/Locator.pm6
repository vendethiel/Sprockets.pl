class Sprockets::Locator;

my @extensions = <js html css txt
	png gif jpg jpeg
	otf ttf>;

has %.paths;

method find-file($name, $ext) {
	my sub rm-trail($str) {
		$str.subst(/\/$/, '');
	}

	for %.paths.kv -> $, $ (:@directories, :%prefixes) {
		my $prefix = (my $p = %prefixes{get-type-for-ext($ext)}) ?? "/$p" !! "";
		for @directories {
			my $dir = "{.&rm-trail}{rm-trail $prefix}/";
			for dir $dir {
				my ($f, $fext) = split-name-and-extension($_.Str.substr($dir.chars));
				say "$f~$fext ~~ $name~$ext";
				return "$dir$name.$ext" if $f eq $name and $fext eq $ext;
			}
		}
	}
}

sub get-type-for-ext($ext) {
	given $ext {
		return 'img' when 'png' | 'gif' | 'jpg' | 'jpeg';

		return 'font' when 'otf' | 'ttf';
	}
	return $ext;
}

our sub split-name-and-extension($filename) {
	my Str $type;
	my @parts = do for $filename.split('.') {
		LAST { $type = $_ }
		last if $_ eq any(@extensions);

		$_
	}
	fail "Missing file extension for $filename" unless $type;

	(@parts.join('.'), $type)
}