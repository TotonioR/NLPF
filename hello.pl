use Mojolicious::Lite;

get '/' => {text => 'I love NLPF!'};

app->start;
