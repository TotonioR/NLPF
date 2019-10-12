package Jobeet::Controller::Dashboard;
use Mojo::Base 'Mojolicious::Controller';

# This action will render a template
sub overview {
  my $self = shift;
  return $self->reply->not_found unless $self->session('user');
  # Render template "example/welcome.html.ep" with message
  $self->render(msg => 'Dashboard');
}

1;
