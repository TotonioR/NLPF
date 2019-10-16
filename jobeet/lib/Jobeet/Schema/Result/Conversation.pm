package Jobeet::Schema::Result::Conversation;
use base qw/DBIx::Class::Core/;

# Associated table in database
__PACKAGE__->table('conversation');

# Column definition
__PACKAGE__->add_columns(

     id => {
         data_type => 'integer',
         is_auto_increment => 1,
     },

     user_id1 => {
         data_type => 'integer',
         is_foreign_key => 1,
     },

     user_id2 => {
         data_type => 'integer',
         is_foreign_key => 1,
     },
     
     user_name1 => {
         data_type => 'text',
     },

     user_name2 => {
         data_type => 'text',
     }
 );

 # Tell DBIC that 'id' is the primary key
 __PACKAGE__->set_primary_key('id');
  __PACKAGE__->belongs_to(
            user => 'Jobeet::Schema::Result::User',
            'user_id1');
 __PACKAGE__->belongs_to(
            user => 'Jobeet::Schema::Result::User',
            'user_id2');
 __PACKAGE__->has_many(
     messages => 'Jobeet::Schema::Result::Message',
     'conv_id'
 );
1;