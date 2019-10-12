package Jobeet::Controller::Profilrecruteur;
use Mojo::Base 'Mojolicious::Controller';

# This action will render a template
sub profil {
    my $self = shift;
    my $email = $self->session('user');
    my $user = $self->db->resultset('User')->search({email => $email})->first;
    $self->render(user => $user);
}

1;