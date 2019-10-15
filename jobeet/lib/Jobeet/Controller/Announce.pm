package Jobeet::Controller::Announce;
use Mojo::Base 'Mojolicious::Controller';

sub user_exists {
	my ($self, $id) = @_;
	my $user = $self->db->resultset('User')->search({ id => $id })->first;
	return $user;
}

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
	my $announces = $self->db->resultset('Announce')->search({});
	$self->render(announces => $announces, status => $status);
}

1;