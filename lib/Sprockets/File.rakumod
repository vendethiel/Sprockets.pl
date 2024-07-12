unit class Sprockets::File;
use Sprockets::Filter;
use Sprockets::DependencyWalker;

has $.locator; # locator used to find this file (used for context)
has Str $.realpath; # file's realpath
has Str $.relative-filename;
has Str $.ext;
has @.filters; # filters to apply
has @.deps;

has Str $!content; # lazy field (@see Str)

method Str {
  return $!content with $!content;
  my $file-content = self!fetch-content;
  (my $full-content, @!deps) = include-dependencies($file-content, $.ext, $.locator, self.relative-directory);
  $!content = apply-filters(@.filters, $full-content);
}

method relative-directory {
  my $dirname = $.relative-filename.IO.dirname;
  return $dirname eq "." ?? "" !! "$dirname/"
}

method !fetch-content {
  slurp $.realpath;
}
