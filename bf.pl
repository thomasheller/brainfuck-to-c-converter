#!/usr/bin/perl -w

# Brainfuck to C converter
# 
# Written by Thomas Heller
# - Public Domain -

use strict;

die("usage: $0 <filename>") unless @ARGV == 1;

my $FILE;
open(FILE, $ARGV[0]);

my $result = "int main() {\n  char array[30000];\n  char *ptr = array;\n";
my $depth = 0;

while (!eof(FILE)) {
  my $c = getc(FILE);
  if ($c eq '>') { add('++ptr;'); }
  elsif ($c eq '<') { add('--ptr;'); }
  elsif ($c eq '+') { add('++*ptr;'); }
  elsif ($c eq '-') { add('--*ptr;'); }
  elsif ($c eq '.') { add('putchar(*ptr);'); }
  elsif ($c eq ',') { add('*ptr = getchar();'); }
  elsif ($c eq '[') { add('while (*ptr) {'); $depth++; }
  elsif ($c eq ']') { add('}'); $depth--; }
}

sub add {
  for (0..$depth) { $result .= '  '; }
  $result .= $_[0]."\n";
}

$result .= "}\n";

print $result;
