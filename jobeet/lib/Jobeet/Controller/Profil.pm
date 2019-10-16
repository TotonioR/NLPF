package Jobeet::Controller::Profil;
use Mojo::Base 'Mojolicious::Controller';

# This action will render a template
sub profil {
    my $self = shift;
    return $self->reply->not_found unless $self->session('user');
    my $id = $self->session('user');
    my $user = $self->db->resultset('User')->search({id => $id})->first;
    my $profile = $self->db->resultset('ProfileRecruteur')->search({user_id => $id})->first;
    if (defined $profile) {
        return $self->render(user => $user, profile => $profile, type => "Recruteur", status => $id);
    }
    my $tags = $self->db->resultset('Tag')->search({user_id => $id});
    $profile = $self->db->resultset('ProfileCandidat')->search({user_id => $id})->first;
    $self->render(user => $user, profile => $profile, type => "Candidat", status => $id, tag => $tags);
}

1;