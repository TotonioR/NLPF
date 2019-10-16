package Jobeet::Controller::Editprofil;
use Mojo::Base 'Mojolicious::Controller';

sub editprofil {
	my $self = shift;
	my $id = $self->session('user');
	my $user = $self->db->resultset('User')->search({id => $id})->first;
	my $profile = $self->db->resultset('ProfileRecruteur')->search({user_id => $id})->first;
	if (defined $profile) {
		return $self->render(user => $user, profile => $profile, type => "Recruteur", status => $id);
	}
	$profile = $self->db->resultset('ProfileCandidat')->search({user_id => $id})->first;
	$self->render(user => $user, profile => $profile, type => "Candidat", status => $id);
}

sub modifyprofil {
	my $self = shift;
	my $id = $self->session('user');
	my $username = $self->param('username');
	my $password = $self->param('password');
	my $nom = $self->param('nom');
	my $prenom = $self->param('prenom');
	my $mobile = $self->param('mobile');
	my $user = $self->db->resultset('User')->update(
		{
			email => $username,
			password  => $password,
		},
		{ id => $id }
	);
	$user = $self->db->resultset('User')->search({id => $id})->first;
	if ($user->recruteur eq 0) {
		my $study = $self->param('study');
		my $description = $self->param('description');
		my $tags = $self->param('tag');
		my $profile = $self->db->resultset('ProfileCandidat')->update({
			nom         => $nom,
			prenom      => $prenom,
			mobile      => $mobile,
			study       => $study,
			description => $description },
			{ user_id => $user->id
		});
		$self->render(type => "Candidat");
	}
	else
	{
		my $company = $self->param('company');
		my $profile = $self->db->resultset('ProfileRecruteur')->update({
			nom         => $nom,
			prenom      => $prenom,
			mobile      => $mobile,
			company		=> $company },
			{ user_id => $user->id
			});
		$self->render(type => "Recruteur");
	}$self->redirect_to('profil');


}
1;