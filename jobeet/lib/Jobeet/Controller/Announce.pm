package Jobeet::Controller::Announce;
use Mojo::Base 'Mojolicious::Controller';

sub list {
	my $self = shift;
	my $announces = $self->db->resultset('Announce');
	$self->render(template => 'announce/list', announces => $announces);
}

sub user_exists {
	my ($self, $id) = @_;
	my $user = $self->db->resultset('User')->search({ id => $id })->first;
	return $user;
}

sub create {
	my $self = shift;
	my $title = $self->param('title');
	my $description = $self->param('description');
	my $id = $self->param('id');
	if (my $user = $self->user_exists($id)) {
		$self->db->resultset('Announce')->create({
			title => $title,
			description => $description,
		});

		$self->flash(post_saved => 1);
		return $self->list;
	} 
}

1;