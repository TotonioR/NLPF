package Jobeet::Controller::Login;
use Mojo::Base 'Mojolicious::Controller';


# Mocked function to check the correctness
# of a username/password combination.
sub user_exists {
  my ($self, $email, $password) = @_;
  my $user = $self->db->resultset('User')->search({ email => $email })->first;
  return defined $user;
}


# Called upon form submit
sub on_user_login {
  my $self = shift;

  # Grab the request parameters
  my $username = $self->param('username');
  my $password = $self->param('password');
  if (my $user = $self->user_exists($username, $password)) {
        $self->session(logged_in => 1);
        $self->session(username => $username);
        $self->redirect_to('overview');
    } else {
        $self->render(text => 'Wrong username/password', status => 403);
    }
}

sub is_logged_in {
    my $self = shift;
    return 1 if $self->session('logged_in');
    $self->render(
        inline => "<h2>Forbidden</h2><p>You're not logged in. <a href=\"#\" Go to login page.=\"login_form\"></a></p>",
        status => 403
    );
}

sub create {
	my $self = shift;
	my $username = $self->param('username');
	my $password = $self->param('password');
	if (my $user = $self->user_exists($username, $password)) {
		$self->render(text => 'User already exists', status => 403);
	} else {
			$self->db->resultset('User')->create({
				email => $username,
				password => $password,
				recruteur => 0,
			});
			$self->flash(post_saved => 1);
			$self->redirect_to('login_form');
	}
}

sub create_recruteur {
	my $self = shift;
	my $username = $self->param('username');
	my $password = $self->param('password');
	if (my $user = $self->user_exists($username, $password)) {
		$self->render(text => 'User already exists', status => 403);
	} else {
        $self->db->resultset('User')->create({
			email => $username,
			password => $password,
			recruteur => 1,
		});
		$self->flash(post_saved => 1);
		$self->redirect_to('login_form');
	}
}

1;