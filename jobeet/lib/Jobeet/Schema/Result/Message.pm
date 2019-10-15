package Jobeet::Schema::Result::Message;
use base qw/DBIx::Class::Core/;

# Associated table in database
__PACKAGE__->table('message');

# Column definition
__PACKAGE__->add_columns(

     id => {
         data_type => 'integer',
         is_auto_increment => 1,
     },

    message => {
        data_type => 'text',
    },

    date => {
        data_type => 'datetime',
        set_on_create => 1
    },

    user_id => {
         data_type => 'integer',
         is_foreign_key => 1,
     },

     conv_id => {
         data_type => 'integer',
         is_foreign_key => 1,
     }
 );

 # Tell DBIC that 'id' is the primary key
 __PACKAGE__->set_primary_key('id');
  __PACKAGE__->belongs_to(
            user => 'Jobeet::Schema::Result::User',
            'user_id');
 __PACKAGE__->belongs_to(
            user => 'Jobeet::Schema::Result::Conversation',
            'conv_id');

1;