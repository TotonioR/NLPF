package Jobeet::Controller::Jobeet;
use Mojo::Base 'Mojolicious::Controller';

# This action will render a template
sub welcome {
  my $self = shift;
  my $status = $self->session('user');
  # Render template "example/welcome.html.ep" with message
  $self->render(msg => 'Bienvenue sur le site de Jobeet', status => $status);
}

1;
