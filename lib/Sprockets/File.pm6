class Sprockets::File;

has Str $.realpath;
has Str $!content; # lazy field (@see Str)

method Str {
	$!content //= self!fetch-content;
}

method !fetch-content {
	$!content //= slurp $.realpath;
}
