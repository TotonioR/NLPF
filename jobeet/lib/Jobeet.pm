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
  $r->get('/login')->name('login_form')->to(template => 'login/login_form', error => 0);
  $r->post('/login')->name('do_login')->to('Login#on_user_login');
  $r->get('/inscription_recruteur')->name('inscription_recruteur')->to(template => 'login/inscription_recruteur_form');
  $r->post('/inscription_recruteur')->name('do_inscription_recruteur')->to('Login#create_recruteur');
  $r->get('/inscription')->name('inscription')->to(template => 'login/inscription_form');
  $r->post('/inscription')->name('do_inscription')->to('Login#create');
  
  #Announce
  $r->get('/announce')->to('announce#list');
  $r->post('/announce_add')->to('announce#create');
  $r->post('/link_announce')->to('announce#submit');
  #Profil
  $r->get('/profil')->name('profil')->to('Profil#profil');
  #Edit profil
  $r->get('/editprofil')->name('editprofil')->to('Editprofil#editprofil');
  $r->post('/editprofil')->name('editprofil')->to('Editprofil#modifyprofil');
 
  #Messagerie
  $r->get('/messagerie/<conv_id:num>')->name('conversation')->to('Messagerie#conversation');
  $r->get('/messagerie')->name('messagerie')->to('Messagerie#list');
  $r->post('/messagerie_create')->to('Messagerie#create');
  $r->post('/messagerie/<conv_id:num>/send')->name('conversation')->to('Messagerie#send_message');
  my $auth = $r->under('/')->to('Login#is_logged_in');
  $auth->get('/overview')->to('dashboard#overview');
  $r->get('/logout')->to('Login#logout');
}

1;
