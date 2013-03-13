#!/usr/bin/perl
use warnings;
use strict;
use WWW::Mechanize;
use URI;
use URLShorten;
use feature 'say';
use Web::Scraper;


my $sorce_url = shift @ARGV;
say $sorce_url;

my $mech = new WWW::Mechanize;
$mech->get(URI->new($sorce_url));

my $links = $mech->find_all_links();

my	$scraper = scraper { process '//title', 'title' => 'TEXT';};

my $cnt = 0;
for my $link (@$links) {
	last if $cnt == 10;
	my $url = $link->url;
	my $content = $mech->get(URI->new($url));
	my $res = $scraper->scrape($content, $url);

	my $shorturl= URLShorten::url_shorten($url);
	say "title: $res->{url}";
	say "orginal url = $url";
	say "short   url = $shorturl";
	++$cnt;
}

	


