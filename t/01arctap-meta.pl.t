use strict;
use warnings;

use Test::More tests => 2;

use Test::Trap qw( trap $trap :flow:stderr(systemsafe):stdout(systemsafe):warn );

trap {
    system("bash", "arc.sh", "t/files/tap-diag1.arc");
};

# TEST
is ($trap->stderr(), qq{# Hi\n# There\n}, "Checking for correct diag");

trap {
    system("bash", "arc.sh", "t/files/tap-test-is1.arc");
};

# TEST
is ($trap->stderr(),
    qq{#   Failed test 'Not good'\n#          got: 5\n#     expected: 6\n},
    "Checking for correct test-is diagnostics"
);

