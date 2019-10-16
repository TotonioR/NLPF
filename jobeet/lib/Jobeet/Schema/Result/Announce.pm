package Jobeet::Schema::Result::Announce;
use base qw/DBIx::Class::Core/;

# Associated table in database
__PACKAGE__->table('announce');

# Column definition
__PACKAGE__->add_columns(

    id => {
        data_type => 'integer',
        is_auto_increment => 1,
    },

    title => {
        data_type => 'title',
    },

    description => {
        data_type => 'text',
    },
);

 # Tell DBIC that 'id' is the primary key
__PACKAGE__->set_primary_key('id');  

__PACKAGE__->has_many(
     tags => 'Jobeet::Schema::Result::TagAnnounce','announce_id'
 );

1;