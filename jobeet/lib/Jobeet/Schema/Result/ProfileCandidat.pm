package Jobeet::Schema::Result::ProfileCandidat;
use base qw/DBIx::Class::Core/;

# Associated table in database
__PACKAGE__->table('profilecandidat');

# Column definition
__PACKAGE__->add_columns(

     id => {
         data_type => 'integer',
         is_auto_increment => 1,
     },

     nom => {
         data_type => 'text',
     },

     prenom => {
         data_type => 'text',
     },

     mobile => {
         data_type => 'text',
     },

     study => {
         data_type => 'text'
     },

     description => {
         data_type => 'text'
     },

     user_id => {
         data_type => 'integer',
         is_foreign_key => 1,
     }
 );

 # Tell DBIC that 'id' is the primary key
 __PACKAGE__->set_primary_key('id');
 __PACKAGE__->belongs_to(
            user => 'Jobeet::Schema::Result::User',
            'user_id');

1;