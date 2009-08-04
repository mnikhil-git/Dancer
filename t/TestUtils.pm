package TestUtils;

use base 'Exporter';
use vars '@EXPORT';
use Test::MockObject;

@EXPORT = ('fake_request', 'http_request');

my $path = undef;
sub path {
	my ($self, $value) = @_;
	return $path if @_ == 1;
	return $path = $value;
}

my $method = 'GET';
sub method {
	my ($self, $value) = @_;
	return $method if @_ == 1;
	return $method = $value;
}

sub fake_request($$) {
	my ($method, $path) = @_;
	my $req = Test::MockObject->new;
	$req->mock('request_method', sub { method(@_) });
	$req->mock('path_info', sub { path(@_) });
	$req->mock('Vars', sub { {} });
	
	$req->request_method($method);
	$req->path_info($path);
	return $req;
}

sub http_request {
    my ($port, $method, $path) = @_;
    my $url = "http://localhost:${port}${path}";
    my $lwp = LWP::UserAgent->new;
    my $req = HTTP::Request->new($method => $url);
    return $lwp->request($req);
}

'TestUtils';
