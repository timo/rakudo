use v6;

use Test;

plan 57;

my %h            = a => 42, b => 666;
my Int %hi       = a => 42, b => 666;
my Int %hia{Any} = a => 42, b => 666;

for $%h, Any, $%hi, Int, $%hia, Int -> \h, \T {
    my $name = h.^name;

    is h.AT-KEY("a"),        42, "$name.AT-KEY";
    is (h.AT-KEY("b") = 65), 65, "$name.AT-KEY =";
    is h.AT-KEY("b"),        65, "$name.AT-KEY (changed)";

    ok h.EXISTS-KEY("a"),  "$name.EXISTS-KEY (existing)";
    ok !h.EXISTS-KEY("c"), "!$name.EXISTS-KEY (non-existing)";

    is h.ASSIGN-KEY("a",33), 33, "$name.ASSIGN-KEY (existing)";
    is h.AT-KEY("a"),        33, "$name.AT-KEY (existing ASSIGN-KEY)";
    is h.ASSIGN-KEY("c",65), 65, "$name.ASSIGN-KEY (non-existing)";
    is h.AT-KEY("c"),        65, "$name.AT-KEY (non-existing ASSIGN-KEY)";

    my $a = 45;
    my $d = 67;
    is h.BIND-KEY("a",$a), 45, "$name.BIND-KEY (existing)";
    is h.AT-KEY("a"),      45, "$name.AT-KEY (existing BIND-KEY)";
    $a = 90;
    is h.AT-KEY("a"),      90, "$name.AT-KEY (changed existing BIND-KEY)";

    is h.BIND-KEY("d",$d), 67, "$name.BIND-KEY (non-existing)";
    is h.AT-KEY("d"),      67, "$name.AT-KEY (non-existing BIND-KEY)";
    $d = 56;
    is h.AT-KEY("d"),      56, "$name.AT-KEY (changed non-existing BIND-KEY)";

    is h.DELETE-KEY("a"),  90, "$name.DELETE-KEY (existing)";
    ok !h.EXISTS-KEY("a"),     "!$name.EXISTS-KEY (existing DELETE-KEY)";
    is h.DELETE-KEY("e"),   T, "$name.DELETE-KEY (non-existing)";
    ok !h.EXISTS-KEY("e"),     "!$name.EXISTS-KEY (non-existing DELETE-KEY)";
}
