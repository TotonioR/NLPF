package JobTrailer::Controller::Login;
use Mojo::Base 'Mojolicious::Controller';


# Mocked function to check the correctness
# of a username/password combination.
sub user_exists {
  my ($username, $password) = @_;

  return ($username eq 'foo@bar.fr' && $password eq 'bar');
}


# Called upon form submit
sub on_user_login {
  my $self = shift;

  # Grab the request parameters
  my $username = $self->param('username');
  my $password = $self->param('password');
  print($username);
  if (user_exists($username, $password)) {

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

1;