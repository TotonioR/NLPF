package Jobeet::Controller::Announce;
use Mojo::Base 'Mojolicious::Controller';

sub create {
	my $self = shift;
	my $title = $self->param('title');
	my $description = $self->param('description');
	
	#creating new Announce with form params
	$self->db->resultset('Announce')->create({
			title => $title,
			description => $description,
	});

	$self->flash(post_saved => 1);
	$self->redirect_to('announce');
}

sub list {
	my $self = shift;
	# return login form if user is not already logged
	return $self->redirect_to('login_form') unless $self->session('user');

	my $status = $self->session('user');
	my $announces = $self->db->resultset('Announce')->search({});
	$self->render(announces => $announces, status => $status);
}

1;