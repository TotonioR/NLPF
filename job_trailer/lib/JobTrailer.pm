package JobTrailer;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  # Load configuration from hash returned by config file
  my $config = $self->plugin('Config');
  
  # Configure the application
  $self->secrets($config->{secrets});
  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('Jobtrailer#welcome');
  $r->get('/login')->name('login_form')->to(template => 'login/login_form');
  $r->post('/login')->name('do_login')->to('Login#on_user_login');
  my $auth = $r->under('/dashboard')->to('Login#is_logged_in');
  $auth->get('/overview')->name('overview')->to('dashboard#overview');
  
  $r->route('/logout')->name('do_logout')->to(cb => sub {
     my $self = shift;

     # Expire the session (deleted upon next request)
     $self->session(expires => 1);

     # Go back to home
     $self->redirect_to('/');
 });
}

1;