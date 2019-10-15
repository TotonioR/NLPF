package Jobeet::Controller::Dashboard;
use Mojo::Base 'Mojolicious::Controller';

# This action will render a template
sub overview {
  my $self = shift;
  return $self->reply->not_found unless $self->session('user');
  # Render template "example/welcome.html.ep" with message
  my $status = $self->session('user');
  $self->render(msg => 'Dashboard', status => $status);
}

1;
