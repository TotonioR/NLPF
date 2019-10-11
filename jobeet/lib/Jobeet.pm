package Jobeet;
use Mojolicious::Sessions;
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
  $r->get('/inscription_recruteur')->name('inscription_recruteur')->to(template => 'login/inscription_recruteur_form');
  $r->post('/inscription_recruteur')->name('do_inscription_recruteur')->to('Login#create_recruteur');
  $r->get('/inscription')->name('inscription')->to(template => 'login/inscription_form');
  $r->post('/inscription')->name('do_inscription')->to('Login#create');
  
  #Announce
  $r->get('/announce')->to('announce#list');
  $r->post('/announce_add')->to('announce#create');

  my $auth = $r->under('/')->to('Login#is_logged_in');
  $auth->get('/overview')->to('dashboard#overview');
  $r->get('/logout')->to('Login#logout');
}

1;
