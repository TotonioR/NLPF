package Jobeet::Controller::Announce;
use Mojo::Base 'Mojolicious::Controller';

sub create {
	my $self = shift;
	my $title = $self->param('title');
	my $description = $self->param('description');
	my $study = $self->param('study');
	my $tags = $self->param('tag');
	#creating new Announce with form params
	my $announce = $self->db->resultset('Announce')->create({
			title => $title,
			description => $description,
	});

	my @tmp = split(/[,]/, $tags);
	foreach my $i (@tmp)
	{
		my $tag = $self->db->resultset('TagAnnounce')->create({
			name => $i,
			announce_id => $announce->id,
		 });
	}

	$self->flash(post_saved => 1);
	$self->redirect_to('announce');
}

sub list {
	my $self = shift;

	# return login form if user is not already logged
	return $self->redirect_to('login_form') unless $self->session('user');
	
	#checking which profile is concerned
	my $id = $self->session('user');
    my $user = $self->db->resultset('User')->search({id => $id})->first;
 	my $profile = $self->db->resultset('ProfileCandidat')->search({user_id => $id})->first;
	my $is_candidat = defined $profile;
	my $announces = $self->db->resultset('Announce')->search({});
	my $user_tags = $self->db->resultset('Tag')->search({user_id => $id});
	$self->render(announces => $announces, status => $id, is_candidat => $is_candidat, tags => $self->db->resultset('TagAnnounce'), user_tags => $user_tags);
}

1;