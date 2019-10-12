package Jobeet::Controller::Profilrecruteur;
use Mojo::Base 'Mojolicious::Controller';

# This action will render a template
sub consultprofil {

    my ($self, $id) = @_;
    my $users = $self->db->resultset('User')->search({ email => 'lejossecdonel@gmail.com'});
    $self->render(users => $users);
}
    1;