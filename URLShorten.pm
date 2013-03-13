package URLShorten;
use lib qw(/home/toshi/perl/lib);
use strict;
use warnings;
use PitInfo;
use LWP::UserAgent;
use HTTP::Request;
use WebService::Bitly;

sub url_shorten {
	my $url = shift;
	my $bitly_pit_config_save_name = shift || 'bit.ly';
	my ($user_name, $user_api_key);
	($user_name, $user_api_key) = PitInfo->pitinfo(
		'default', $bitly_pit_config_save_name,
		 $user_name, $user_api_key 
	);


	my $bitly = WebService::Bitly->new(
		user_name			=> $user_name,
		user_api_key	=> $user_api_key,
	);

	my $res = $bitly->shorten($url);
	my $short_url ='';

	if ($res->is_error) {
		my $tinyurl = "http://tinyurl.com/api-create.php?url=$url";
		my $ua = LWP::UserAgent->new();
		my $req = HTTP::Request->new('GET', $tinyurl);
		my $res_tinyurl = $ua->request($req);
		return $short_url = $res_tinyurl->content;
	}else{
  return $short_url = $res->short_url;
	}
}
1;
