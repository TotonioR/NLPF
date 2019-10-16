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
     }
 );

 # Tell DBIC that 'id' is the primary key
 __PACKAGE__->set_primary_key('id');
 __PACKAGE__->has_many(
     tags => 'Jobeet::Schema::Result::Tag',
     'user_id'
 );

 __PACKAGE__->has_many(
     conv => 'Jobeet::Schema::Result::Conversation',
     'user_id1'
 );

 __PACKAGE__->has_many(
     conv => 'Jobeet::Schema::Result::Conversation',
     'user_id2'
 );

 __PACKAGE__->might_have(
     profile => 'Jobeet::Schema::Result::ProfileRecruteur',
     'user_id'
 );

  __PACKAGE__->might_have(
     profile => 'Jobeet::Schema::Result::ProfileCandidat',
     'user_id'
 );
1;