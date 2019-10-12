package Jobeet::Schema::Result::User;
use base qw/DBIx::Class::Core/;

# Associated table in database
__PACKAGE__->table('user');

# Column definition
__PACKAGE__->add_columns(

     id => {
         data_type => 'integer',
         is_auto_increment => 1,
     },

     email => {
         data_type => 'text',
     },

     password => {
         data_type => 'text',
     },
	 
	 recruteur => {
         data_type => 'integer',
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
 );

 # Tell DBIC that 'id' is the primary key
 __PACKAGE__->set_primary_key('id');
 __PACKAGE__->has_many(
     tags => 'Jobeet::Schema::Result::Tag',
     'user_id'
 );

1;