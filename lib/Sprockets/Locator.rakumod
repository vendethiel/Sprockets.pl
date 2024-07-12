use Sprockets;
use Sprockets::File;
unit class Sprockets::Locator;
has %.paths;

subset FileType of Str where 'img' | 'font' | 'js' | 'css';

method find-file($name, $ext) {
	my sub rm-trail($str) {
		$str.subst(/\/$/, '');
	}

	my sub go(IO::Path $dir, Int $prefix-len) {
		return unless $dir.d;
		for $dir.dir {
			if .IO.d {
				return $_ with go(.IO, $prefix-len);
			} else {
				my $relative-filename = .Str.substr($prefix-len);
				my ($f, $fext, $filters) = split-filename($relative-filename);
				return Sprockets::File.new(
					:realpath(~$_),
					:ext($fext),
					:$relative-filename,
					:filters(@$filters),
					:locator(self)
				) if $f eq $name and $fext eq $ext;
			}
		}
		return;
	}

	for %.paths.kv -> $, $ (:@directories, :%prefixes) {
		my $prefix = do with %prefixes{get-type-for-ext($ext)} -> $p { "/$p" } else { "" };
		for @directories {
			my $dir = "$(.&rm-trail)$(rm-trail $prefix)/";
			return $_ with go($dir.IO, $dir.chars)
		}
	}
}

sub get-type-for-ext(Str $ext --> FileType) {
	given $ext {
		return 'img' when 'png' | 'gif' | 'jpg' | 'jpeg';

		return 'font' when 'otf' | 'ttf';
	}
	return $ext;
}
