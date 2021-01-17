@@ General commands to help players self-administer and fix their own issues.

@@ =============================================================================
@@ +selfboot
@@ =============================================================================

&c.+selfboot [v(d.bc)]=$+selfboot:@assert gt(words(ports(%#)), 1)={ @trigger me/tr.error=%#, You don't have any frozen connections to boot.; }; @dolist rest(ports(%#))=@boot/port ##; @trigger me/tr.success=%#, You booted your frozen connections.;

@@ =============================================================================
@@ @gender, an alias for @sex
@@ =============================================================================

&c.@gender [v(d.bc)]=$@gender *:@force %#=@sex me=%0;

@@ =============================================================================
@@ +block, a simple page-locker
@@ =============================================================================

&tr.lock-setup [v(d.bc)]=@lock/page %0=page-lock/1; &page-lock %0=cor\(isstaff(\%#), member\(v\(whitelisted-PCs\), \%#\), not\(cor\(t\(v\(block-all\)\), member\(v\(blocked-PCs\), \%#\)\)\)\);

&tr.lock-clear [v(d.bc)]=@unlock/page %0; &page-lock %0=;

&cmd-+block_name [v(d.bc)]=$+block *:@assert t(setr(P, switch(%0, all, all, pmatch(%0))))={ @pemit %#=alert(Error) Could not find a player named '%0'.; }; @break isstaff(%qP)={ @pemit %#=alert(Error) [moniker(%qP)] is staff and can't be blocked.; }; @trigger me/tr.+block=%#, %qP, default(%0/reject, Sorry%, [moniker(%#)] is not accepting pages.);

&tr.+block [v(d.bc)]=@trigger me/tr.lock-setup=%0; &block-all %0=[strmatch(%1, all)]; @trigger me/tr.add-blocked-person=%0, %1; @pemit %0=alert(Page locker) You have blocked page messages from [switch(%1, all, everyone, moniker(%1))]. Blocked people who try to page you will see: %R%R%2%R%RTo change that message, type '@reject me=<message>'. To turn paging back on, +unblock [switch(%1, all, all, moniker(%1))].;

&tr.add-blocked-person [v(d.bc)]=@break strmatch(%1, all); &blocked-PCs %0=setunion(xget(%0, blocked-PCs), u(fn.get-alts, %1)); &blocks %0=setunion(xget(%0, blocks), %1);

&cmd-+unblock [v(d.bc)]=$+unblock *:@assert t(setr(P, switch(%0, all, all, pmatch(%0))))={ @pemit %#=alert(Error) Could not find a player named '%0'.; }; @assert switch(%qP, all, xget(%#, block-all), member(xget(%#, blocked-PCs), %qP))={ @pemit %#=alert(Page Locker) You aren't currently blocking [switch(%qP, all, pages from everyone, moniker(%qP))].; }; @trigger me/tr.+unblock=%#, %qP;

&tr.+unblock [v(d.bc)]=@trigger me/tr.lock-setup=%0; &block-all %0=[switch(%1, all, 0, xget(%0, block-all))]; @trigger me/tr.unblock-person=%0, %1; @pemit %0=alert(Page locker) You have unblocked pages from [switch(%1, all, everyone, moniker(%1))].; @assert cor(t(xget(%0, block-all)), t(xget(%0, blocked-PCs)))={ @trigger me/tr.lock-clear=%0; };

&tr.unblock-person [v(d.bc)]=@break strmatch(%1, all); &blocked-PCs %0=setdiff(xget(%0, blocked-PCs), u(fn.get-alts, %1)); &blocks %0=setdiff(xget(%0, blocks), %1);

&cmd-+block/clear [v(d.bc)]=$+block/clear:@assert or(t(xget(%#, blocked-PCs)), t(setr(B, xget(%#, blocks))), t(setr(A, xget(%#, block-all))))={ @pemit %#=alert(Page locker) You currently aren't blocking anyone.; }; @wipe %#/blocked-PCs; @wipe %#/block-all; @wipe %#/blocks; @pemit %#=alert(Page locker) You have [switch(t(%qB)%qA, 10, unblocked [itemize(iter(%qB, moniker(itext(0)),, |), |)], 01, re-enabled pages for everyone, 11, unblocked [itemize(iter(%qB, moniker(itext(0)),, |), |)]%, and re-enabled pages for everyone, cleared your block list)].

&cmd-+block/who [v(d.bc)]=$+block/who:@trigger me/tr.+block/who=%#;

&cmd-+block [v(d.bc)]=$+block:@trigger me/tr.+block/who=%#;

&cmd-+block/list [v(d.bc)]=$+block/list:@trigger me/tr.+block/who=%#;

&cmd-+whitelist [v(d.bc)]=$+whitelist:@trigger me/tr.+block/who=%#;

&cmd-+blocks [v(d.bc)]=$+blocks:@trigger me/tr.+block/who=%#;

&tr.+block/who [v(d.bc)]=@assert or(t(xget(%0, blocked-PCs)), t(setr(B, xget(%0, blocks))), t(setr(A, xget(%0, block-all))), t(setr(W, xget(%0, whitelisted-PCs))))={ @pemit %0=alert(Page locker) You currently aren't blocking or whitelisting anyone.; }; @pemit %0=alert(Page locker) You are currently blocking pages from [switch(t(%qB)%qA, 10, itemize(iter(%qB, moniker(itext(0)),, |), |), 01, everyone, 11, everyone%, as well as [itemize(iter(%qB, moniker(itext(0)),, |), |)] specifically, no one)]. [if(t(%qW), You have whitelisted the following people: [itemize(iter(%qW, moniker(itext(0)),, |), |)])]

&cmd-+whitelist_name [v(d.bc)]=$+whitelist *:@assert t(setr(P, pmatch(%0)))={ @pemit %#=alert(Error) Could not find a player named '%0'.; }; @break isstaff(%qP)={ @pemit %#=alert(Error) [moniker(%qP)] is staff and doesn't need to be whitelisted.; }; @trigger me/tr.+whitelist=%#, %qP;

&tr.+whitelist [v(d.bc)]=@trigger me/tr.lock-setup=%0; &whitelisted-PCs %0=setunion(xget(%0, whitelisted-PCs), %1); @pemit %0=alert(Page locker) You have whitelisted [moniker(%1)]. They will be able to page you even when you have blocked pages from everyone. To remove them, +blacklist [moniker(%1)].;

&cmd-+blacklist [v(d.bc)]=$+blacklist *:@break strmatch(%0, all)={ @trigger me/tr.+whitelist/clear=%#; }; @assert t(setr(P, pmatch(%0)))={ @pemit %#=alert(Error) Could not find a player named '%0'.; }; @assert member(xget(%#, whitelisted-PCs), %qP)={ @pemit %#=alert(Page Locker) [moniker(%qP)] is not currently whitelisted, so cannot be blacklisted. Did you mean +block?; }; @trigger me/tr.+blacklist=%#, %qP;

&tr.+blacklist [v(d.bc)]=@trigger me/tr.lock-setup=%0; &whitelisted-PCs %0=setdiff(xget(%0, whitelisted-PCs), %1); @pemit %0=alert(Page locker) You have removed [moniker(%1)] from your whitelist. They will no longer be able to page you when you have blocked pages from everyone.;

&cmd-+whitelist/clear [v(d.bc)]=$+whitelist/clear:@trigger me/tr.+whitelist/clear=%#;

&tr.+whitelist/clear [v(d.bc)]=@assert t(setr(W, xget(%0, whitelisted-PCs)))={ @pemit %0=alert(Page locker) You currently aren't whitelisting anyone.; }; @wipe %0/whitelisted-PCs; @pemit %0=alert(Page locker) You have cleared your whitelist, which contained [itemize(iter(%qW, moniker(itext(0)),, |), |)]. They will no longer be able to page you when you have blocked pages from everyone.

@@ =============================================================================
@@ +name <name> - allow players to administer names
@@ =============================================================================

