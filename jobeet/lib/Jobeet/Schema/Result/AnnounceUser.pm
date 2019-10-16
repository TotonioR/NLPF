package Jobeet::Schema::Result::AnnounceUser;
use base qw/DBIx::Class::Core/;

# Associated table in database
__PACKAGE__->table('announceuser');

# Column definition
__PACKAGE__->add_columns(

    id => {
        data_type => 'integer',
        is_auto_increment => 1,
    },

    match => {
        data_type => 'integer',
    },

    user_id => {
        data_type => 'integer'
    },

    announce_id => {
        data_type => 'integer'
    },
);

 # Tell DBIC that 'id' is the primary key
__PACKAGE__->set_primary_key('id');  

1;