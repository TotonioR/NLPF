package Jobeet::Schema::Result::Tag;
use base qw/DBIx::Class::Core/;

# Associated table in database
__PACKAGE__->table('tag');

# Column definition
__PACKAGE__->add_columns(

     id => {
         data_type => 'integer',
         is_auto_increment => 1,
     },

     name => {
         data_type => 'text',
     },
 );

 # Tell DBIC that 'id' is the primary key
 __PACKAGE__->set_primary_key('id');

1;