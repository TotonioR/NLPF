package Jobeet::Controller::Login;
use Mojo::Base 'Mojolicious::Controller';


# Mocked function to check the correctness
# of a username/password combination.
sub user_exists {
  my ($self, $email) = @_;
  my $user = $self->db->resultset('User')->search({ email => $email })->first;
  return defined $user;
}


# Called upon form submit
sub on_user_login {
  my $self = shift;

  # Grab the request parameters
  my $email = $self->param('username');
  my $password = $self->param('password');
  my $user = $self->db->resultset('User')->search({ email => $email, password => $password })->first;
  return $self->render unless defined $user;
  $self->session(user => $user->id);
  $self->redirect_to('overview');
}

sub is_logged_in {
    my $self = shift;
    return 1 if $self->session('user');
    $self->render(
        inline => "<h2>Forbidden</h2><p>You're not logged in. <a href=\"#\" Go to login page.=\"login_form\"></a></p>",
        status => 403
    );
}

sub create {
	my $self = shift;
	my $username = $self->param('username');
	my $password = $self->param('password');
	my $nom = $self->param('nom');
	my $prenom = $self->param('prenom');
	my $mobile = $self->param('mobile');
	my $study = $self->param('study');
	my $description = $self->param('description');
	my $tags = $self->param('tag');
	if (my $user = $self->user_exists($username)) {
		$self->render(text => 'User already exists', status => 403);
	} else {
			$user = $self->db->resultset('User')->create({
				email => $username,
				password => $password,
				recruteur => 0,
			});
			my $profile = $self->db->resultset('ProfileCandidat')->create({
				nom => $nom,
				prenom => $prenom,
				mobile => $mobile,
				study => $study,
				description => $description,
				user_id => $user->id,
			});
			my @tmp = split(/[,]/, $tags);
			foreach my $i (@tmp)
			{
				my $tag = $self->db->resultset('Tag')->create({
					name => $i,
					user_id => $user->id,
				 });
			}
			$self->redirect_to('login_form');
	}
}

sub create_recruteur {
	my $self = shift;
	my $username = $self->param('username');
	my $password = $self->param('password');
	my $nom = $self->param('nom');
	my $prenom = $self->param('prenom');
	my $mobile = $self->param('mobile');
	if (my $user = $self->user_exists($username, $password)) {
		$self->render(text => 'User already exists', status => 403);
	} else {
        my $user = $self->db->resultset('User')->create({
			email => $username,
			password => $password,
			recruteur => 1,
		});
		my $profile = $self->db->resultset('ProfileRecruteur')->create({
			nom => $nom,
			prenom => $prenom,
			mobile => $mobile,
			company => '',
			user_id => $user->id,
		});
		$self->redirect_to('login_form');
	}
}

sub logout {
     my $self = shift;
     $self->session(expires => 1);
     $self->redirect_to('/');
}

1;