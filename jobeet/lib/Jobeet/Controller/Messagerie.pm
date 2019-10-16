package Jobeet::Controller::Messagerie;
use Mojo::Base 'Mojolicious::Controller';

# This action will render a template
sub create {
	my $self = shift;
	my $status = $self->session('user');
	my $name = $self->param('name');
  my @split = split(' ', $name);
  my $profile2 = $self->db->resultset('ProfileCandidat')->search({nom => $split[0], prenom => $split[1]})->first;
  if (!defined $profile2) {
    $profile2 = $self->db->resultset('ProfileRecruteur')->search({nom => $split[0], prenom => $split[1]})->first;
  }
	my $conv = $self->db->resultset('Conversation')->search([{user_id1 => $profile2->user_id, user_id2 => $status}, {user_id2 => $profile2->user_id, user_id1 => $status}]);
  if ($conv->count eq 0){
    my $profile1 = $self->db->resultset('ProfileCandidat')->search({user_id => $status})->first;
    if (!defined $profile1) {
      $profile1 = $self->db->resultset('ProfileRecruteur')->search({user_id => $status})->first;
    }
    $self->db->resultset('Conversation')->create({ user_id1 => $status, user_id2 => $profile2->user_id, user_name1 => $profile1->nom." ".$profile1->prenom, user_name2 => $profile2->nom." ".$profile2->prenom });
  }
	$self->redirect_to('messagerie');
}

sub conversation {
  my $self = shift;
  my $conv_id = $self->param('conv_id');
  my $conv = $self->db->resultset('Conversation')->search({id => $conv_id});
  $self->render(conv => $conv);
}

sub list {
	my $self = shift;
	my $status = $self->session('user');
	my $conv = $self->db->resultset('Conversation')->search([{user_id1 => $status}, {user_id2 => $status}]);
  my $candidat = $self->db->resultset('ProfileCandidat')->search({user_id => {'!=', $status}}, {columns => [qw/user_id nom prenom/]});
  my $recruteur = $self->db->resultset('ProfileRecruteur')->search({user_id => {'!=', $status}}, {columns => [qw/user_id nom prenom/]});
  my $conv1 = $self->db->resultset('Conversation')->search([{user_id1 => $status}, {user_id2 => $status}]);
	$self->render(conv => $conv1, status => $status, user1 => $candidat, user2 => $recruteur);
}

1;
