package Jobeet::Controller::Messagerie;
use Mojo::Base 'Mojolicious::Controller';

# This action will render a template
sub create {
	my $self = shift;
	my $title = $self->param('title');
	my $description = $self->param('description');
	
	$self->db->resultset('Announce')->create({
			title => $title,
			description => $description,
	});

	$self->flash(post_saved => 1);
	$self->redirect_to('announce');
}

sub list {
	my $self = shift;
	my $status = $self->session('user');
	my $conv = $self->db->resultset('Conversation')->search([{user_id1 => $status}, {user_id2 => $status}]);
  my $candidat = $self->db->resultset('ProfileCandidat')->search({}, {columns => [qw/user_id nom prenom/]});
  my $recruteur = $self->db->resultset('ProfileRecruteur')->search({}, {columns => [qw/user_id nom prenom/]});
	$self->render(conv => $conv, status => $status, user1 => $candidat, user2 => $recruteur);
}

1;
