use Sprockets;
unit module DependencyWalker;

my sub relative($filename is copy, $directory is copy) {
    while $filename.starts-with("../") {
        die "Cannot .. out of root" without $directory.rindex("/");
        $filename.=substr(3);
        $directory.=IO.=parent.=Str;
    }
    ($directory eq "." ?? "" !! $directory) ~ $filename
}

my sub include(Str $filename, $ext, $locator, $directory) {
    my $relative = relative($filename, $directory);
    $locator.find-file($relative, $ext)
        orelse die "Cannot include $relative.$ext: file not found"
}

sub include-dependencies(Str $content is copy, $ext, $locator, $directory) is export {
    S:g[^^ '//=' <.ws> require <.ws> (.*?) [\n|$]] = include(~$0, $ext, $locator, $directory) given $content;
}