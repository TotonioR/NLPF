package Jobeet;
use Mojo::Base 'Mojolicious';
use DBI;
use strict;
use warnings;
use Jobeet::Schema;
# This method will run once at server start
sub startup {

  my $self = shift;

  my $schema = Jobeet::Schema->connect('dbi:SQLite:jobeet.db');
  $schema->deploy();
  $self->helper(db => sub { return $schema; });

  # Load configuration from hash returned by config file
  my $config = $self->plugin('Config');
  # Configure the application
  $self->secrets($config->{secrets});
  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('Jobeet#welcome');
  $r->get('/login')->name('login_form')->to(template => 'login/login_form');
  $r->post('/login')->name('do_login')->to('Login#on_user_login');
  $r->get('/inscription')->name('inscription')->to(template => 'login/inscription_form');
  $r->post('/inscription')->name('do_inscription')->to('Login#create');
  my $auth = $r->under('/dashboard')->to('Login#is_logged_in');
  $auth->get('/overview')->name('overview')->to('dashboard#overview');
  
  #Announce
  $r->get('/announce')->to('announce#list');
  $r->post('/announce_add')->to('announce#create');

  $r->route('/logout')->name('do_logout')->to(cb => sub {
   my $self = shift;

   # Expire the session (deleted upon next request)
   $self->session(expires => 1);

   # Go back to home
   $self->redirect_to('/');
   });
}

1;