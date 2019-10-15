package Jobeet::Schema;

# based on the DBIx::Class Schema base class
use base qw/DBIx::Class::Schema/;

__PACKAGE__->load_namespaces();

1;