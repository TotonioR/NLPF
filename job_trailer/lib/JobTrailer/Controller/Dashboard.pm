package JobTrailer::Controller::Dashboard;
use Mojo::Base 'Mojolicious::Controller';

# This action will render a template
sub overview {
  my $self = shift;

  # Render template "example/welcome.html.ep" with message
  $self->render(msg => 'Dashboard');
}

1;
