/*
Note: When done installing this, @restart the game or the functions won't work.

I'm adding SGP functions as I run across the need for them. So far I have:

	isstaff() - allow access if someone is a staffer (now takes into account non-bitted staffers)

	secs2hrs() - functionality updated to return durations in years, months, weeks, days, hours, minutes, and seconds, but only the first two intervals.

Anything else, I haven't come across a need for outside of the SGP Globals themselves.

Some additional functions that are my own work:

	interval() - return a duration between two timestamps in seconds

	title() - a properly cased title which honors the case given by the sentence author: title(a book about the iPad by the BBC) will produce "A Book About the iPad by the BBC". (Note, this is different functionality from the titlestr() function of Thenomain's GMCCG - that was designed to turn all-caps words like "COOKING" into title-cased "Cooking". This would keep the original word's case.)


Layout functions:

	header() and wheader()
	divider(), subheader(), and wdivider()
	footer() and wfooter()
	formattext() - wrap the text up with your default margins and borders
	formatcolumns() - fit tabular data into your default margins and borders

These are the old functions formattext and formatcolumns replace. They're not 1:1 replacements, so they are included below but are commented out:

	boxtext() - wrap a bit of text up with margins, optionally tabulated
	fitcolumns() - fit as many columns on the screen as possible
	getlongest() - get the longest item in a list (used for determining width, no longer needs to be its own function)

Commands from SGP I will be duplicating:
	motd
	ooc and '
	+ooc/+ic
	+staff and +staff/all, +staff/add and +staff/remove
	+view
	+glance
	+duty
	+dark
	+join <name> and +rjoin or +return or something cuz I always forgot that command
	+summon <name> and +rsummon or +return <name>

Stuff I will not be duplicating at this time:
	places - this would be its own thing if I created it
	+beginner - I have never seen a beginner make proper use of this.
	+info - this is going to be game-specific.
	+selfboot  - @selfboot exists.
	+knock and +shout
	+uptime
	+warn
	+bg

*/

@create Basic Data <BD>=10
@set BD=SAFE
@force me=&d.bd me=[num(BD)]

@create Basic Functions <BF>=10
@set BF=SAFE INHERIT
@parent BF=BD
@force me=&d.bf me=[num(BF)]
@force me=&vd [v(d.bf)]=[v(d.bd)]

@create Basic Commands <BC>=10
@set BC=SAFE INHERIT
@parent BC=BF
@force me=&d.bc me=[num(BC)]

@tel [v(d.bd)]=[v(d.bf)]
@tel [v(d.bf)]=[v(d.bc)]

@@ Here are where the settings go. Change this if you want!

@@ Append DBRefs here, or just add them when you set up the commands with +staff/add.
&d.staff_list [v(d.bd)]=

@@ Default alert message
&d.default-alert [v(d.bd)]=GAME

@@ Effect controls the color of the header, footer, and divider functions.
@@ -
@@ Available effects are:
@@   none - no colors
@@   alt - as in alternating - colors go A > B > C > A > B > C...
@@   altrev - as in alternating reverse - colors go A > B > C > B > A
@@   random - colors vary randomly, chosen from your list
@@   fade - colors go on the left and right of all functions.
@@ -
&d.effect [v(d.bd)]=fade

@@ These are the colors. Players won't see them unless they are set ANSI and
@@ COLOR256. You can set that up in your netmux.conf config with:
@@ -
@@   player_flags ansi color256 ascii keepalive
@@ -
@@ That means every player will be created with those flags already set.
@@ Remember that players can change these flags at any time if they want!
@@ Also, setting the flags doesn't magically make the player's client able to
@@ view colors or parse ascii characters. If they can they'll see it; if not,
@@ it won't change a thing.
@@ -
&d.colors [v(d.bd)]=x<#FF0000> x<#AA0055> x<#5500AA> x<#0000FF>

@@ What color is your text? 99% of people should just go with white for
@@ readability.
&d.text-color [v(d.bd)]=xw

@@ Now on to the structure of your header/footer/divider!
@@ -
@@ Effect:
@@ .o.oO( GAME )Oo.o. Alert message
@@ .o.oO( test )Oo...........................................................o.
@@ . text goes here and there is surely going to be a lot of text whee txting .
@@ .o..............................oO( test )Oo..............................o.
@@ . text goes here and there is surely going to be a lot of text whee txting .
@@ .o...........................................................oO( test )Oo.o.
@@ -
&d.text-left [v(d.bd)]=.o
&d.text-right [v(d.bd)]=o.
&d.text-repeat [v(d.bd)]=.
&d.title-left [v(d.bd)]=.oO(
&d.title-right [v(d.bd)]=)Oo.
&d.body-left [v(d.bd)]=.
&d.body-right [v(d.bd)]=.

@@ Effect:
@@ /=/ GAME /=/ Alert message
@@  /=/ test /=================================================================/
@@  / text goes here and there is surely going to be a lot of text whee txting /
@@  /=================================/ test /=================================/
@@  / text goes here and there is surely going to be a lot of text whee txting /
@@  /=================================================================/ test /=/
@@ -
&d.text-left [v(d.bd)]=/
&d.text-right [v(d.bd)]=/
&d.text-repeat [v(d.bd)]==
&d.title-left [v(d.bd)]==/
&d.title-right [v(d.bd)]=/=
&d.body-left [v(d.bd)]=/
&d.body-right [v(d.bd)]=/

@@ You can produce more complex results by using more characters for the repeat
@@ section, but they will be cut off after a certain point. Notice how the
@@ Footer below has a character missing from its cut-off side. If you or your
@@ players are perfectionists, stay away from the multiple-character repeats.
@@ -
@@ Effect:
@@ .o.oO( GAME )Oo.o. Alert message
@@  .o.oO( test )Oo..oOo..oOo..oOo..oOo..oOo..oOo..oOo..oOo..oOo..oOo..oOo..oOo.
@@  . text goes here and there is surely going to be a lot of text whee txting .
@@  .o.oOo..oOo..oOo..oOo..oOo..oOo..oO( test )Oo..oOo..oOo..oOo..oOo..oOo..oOo.
@@  . text goes here and there is surely going to be a lot of text whee txting .
@@  .o.oOo..oOo..oOo..oOo..oOo..oOo..oOo..oOo..oOo..oOo..oOo..oO.oO( test )Oo.o.
@@ -
&d.text-left [v(d.bd)]=.o
&d.text-right [v(d.bd)]=o.
&d.text-repeat [v(d.bd)]=.oOo.
&d.title-left [v(d.bd)]=.oO(
&d.title-right [v(d.bd)]=)Oo.
&d.body-left [v(d.bd)]=.
&d.body-right [v(d.bd)]=.

@@ Finally, our default, chosen because it shows off the colors well.
@@ -
@@ Effect:
@@ .~{ GAME }~. Alert message
@@  .~{ test }~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~.
@@  . text goes here and there is surely going to be a lot of text whee txting .
@@  .~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~{ test }~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~.
@@  . text goes here and there is surely going to be a lot of text whee txting .
@@  .~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~{ test }~.
@@ -
&d.text-left [v(d.bd)]=.
&d.text-right [v(d.bd)]=.
&d.text-repeat [v(d.bd)]=~
&d.title-left [v(d.bd)]=~{
&d.title-right [v(d.bd)]=}~
&d.body-left [v(d.bd)]=.
&d.body-right [v(d.bd)]=.

@@ Other sample header ideas:
@@ ^V^V^V^V^V^V^V^V^V^V^V^V^V^V^V^V^V^V^V^V^V^V^V^V^V^V^V^V^V^V^V^V^V^V^V^V^V^V^
@@ < text goes here and there is surely going to be a lot of text whee texting >
@@ <--------------------------------------------------------------------------->
@@ < text goes here and there is surely going to be a lot of text whee texting >
@@ .o.o.o.o.o.o.o.o.o.o.o.o.o.o.o.o.o.o.o.o.o.o.o.o.o.o.o.o.o.o.o.o.o.o.o.o.o.o.
@@ ( text goes here and there is surely going to be a lot of text whee texting )
@@ <+><+><+><+><+><+><+><+><+><+><+><+><+><+><+><+><+><+><+><+><+><+><+><+><+<+>
@@ + text goes here and there is surely going to be a lot of text whee texting +
@@ <+>-+-<+>-+-<+>-+-<+>-+-<+>-+-<+>-+-<+>-+-<+>-+-<+>-+-<+>-+-<+>-+-<+>-+-<-<+>
@@ + text goes here and there is surely going to be a lot of text whee texting +
@@ .:.:.:.:.:.:.:.:.:.:.:.:.:.:.:.:.:.:.:.:.:.:.:.:.:.:.:.:.:.:.:.:.:.:.:.:.:.:.
@@ . text goes here and there is surely going to be a lot of text whee texting .


@@ =============================================================================
@@ Past this point, you shouldn't change anything unless you know what you're doing.
@@ =============================================================================

@@ 31570560 - 365 days we're calling a year
@@ 2592000 - 30 day span we are arbitrarily calling a month
@@ 604800 - week
@@ 86400 - day
@@ 3600 - hour
@@ 60 - minute
&d.durations [v(d.bd)]=31570560 2592000 604800 86400 3600 60

&d.duration-words [v(d.bd)]=y M w d h m

&d.words-to-leave-uncapitalized [v(d.bd)]=a an and as at but by for in it nor of on or the to up von

&d.punctuation [v(d.bd)]=. , ? ! ; : ( ) < > { } * / - + " '

@startup [v(d.bf)]=@trigger me/tr.make-functions;

&tr.make-functions [v(d.bf)]=@dolist lattr(me/f.global.*)=@function rest(rest(##, .), .)=me/##; @dolist lattr(me/f.globalp.*)=@function/preserve rest(rest(##, .), .)=me/##; @dolist lattr(me/f.globalpp.*)=@function/preserve/privilege rest(rest(##, .), .)=me/##;

@@ These functions are rewrites of the SGP Globals.

&f.global.isstaff [v(d.bf)]=or(member(v(d.staff_list), pmatch(%0)), orflags(%0,WZw))

@@ On with the custom stuff below!

&f.get-ansi [v(d.bf)]=extract(%0, if(lte(%1, words(%0)), %1, add(mod(%1, words(%0)), 1)), 1)

@@ All effects take the following parameter:
@@  %0 - text

&effect.none [v(d.bf)]=%0

&effect.alt [v(d.bf)]=strcat(setq(0, v(d.colors)), iter(lnum(strlen(%0)), ansi(ulocal(f.get-ansi, %q0, inum(0)), mid(%0, itext(0), 1)),, @@))

&effect.altrev [v(d.bf)]=strcat(setq(0, v(d.colors)), setq(0, strcat(%q0, %b, revwords(%q0))), iter(lnum(strlen(%0)), ansi(ulocal(f.get-ansi, %q0, inum(0)), mid(%0, itext(0), 1)),, @@))

&effect.random [v(d.bf)]=strcat(setq(0, v(d.colors)), iter(lnum(strlen(%0)), ansi(pickrand(%q0), mid(%0, itext(0), 1)),, @@))

&effect.fade [v(d.bf)]=strcat(setq(0, v(d.colors)), if(gt(strlen(%0), words(%q0)), strcat(iter(lnum(words(%q0)), ansi(ulocal(f.get-ansi, %q0, inum(0)), mid(%0, itext(0), 1)),, @@), ansi(last(%q0), mid(%0, words(%q0), sub(strlen(%0), mul(words(%q0), 2)))), reverse(iter(lnum(words(%q0)), ansi(ulocal(f.get-ansi, %q0, inum(0)), mid(reverse(%0), itext(0), 1)),, @@))), ulocal(effect.alt, %0)))

&f.reverse-fade [v(d.bf)]=strcat(setq(0, revwords(extract(v(d.colors), 1, strlen(%0)))), iter(lnum(strlen(%0)), ansi(ulocal(f.get-ansi, %q0, inum(0)), mid(%0, itext(0), 1)),, @@))

&f.construct-title [v(d.bf)]=if(t(%0), strcat(ulocal(f.apply-effect, v(d.title-left)), %b, ansi(v(d.text-color), %0), %b, if(switch(v(d.effect), fade, 1, altrev, 1, 0), ulocal(f.reverse-fade, v(d.title-right)), ulocal(f.apply-effect, v(d.title-right)))))

@@ %0 - the player to get the width of the screen of
@@ Output: the width of the player's screen, max 200 and min 50.
&f.get-width [v(d.bf)]=max(min(width(if(t(%0), %0, %#)), 200), 50)

@@ %0 - width of the left and right edges
@@ %1 - width of the middle
&f.repeating-divider [v(d.bf)]=strcat(repeat(u(d.fade-edge), %0), repeat(u(d.fade-middle), %1), repeat(u(d.fade-edge), %0))

@@ %0 - %#
@@ %1 - minimum width
@@ Output: a number between 1 and 6 for how many columns can fit on screen.
&f.get-max-columns [v(d.bf)]=strcat(setq(0, sub(ulocal(f.get-width, %0), 2)), setq(1, if(t(%1), %1, 10)), case(1, gt(%q1, ulocal(f.calc-width, %q0, 2)), 1, gt(%q1, ulocal(f.calc-width, %q0, 3)), 2, gt(%q1, ulocal(f.calc-width, %q0, 4)), 3, gt(%q1, ulocal(f.calc-width, %q0, 5)), 4, gt(%q1, ulocal(f.calc-width, %q0, 6)), 5, 6))

@@ A universal var-setter. One of the few u() functions rather than ulocal().
@@ %0 - title text, optional
@@ %1 - player, optional
@@ %q0 - player's screen width
@@ %q1 - title
@@ %q2 - left text
@@ %q3 - right text
@@ %q4 - repeat text
@@ %q5 - remainder text width
&f.get-layout-vars [v(d.bf)]=strcat(setq(0, ulocal(f.get-width, %1)), setq(1, ulocal(f.construct-title, %0)), setq(2, v(d.text-left)), setq(3, v(d.text-right)), setq(4, v(d.text-repeat)), setq(5, sub(%q0, add(strlen(%q1), strlen(%q2), strlen(%q3), 2))))

@@ Pass the layout to the effects machines to produce the appropriate result.
@@ %0 - the header, footer, or divider.
&f.apply-effect [v(d.bf)]=ulocal(effect.[v(d.effect)], %0)

&f.globalpp.header [v(d.bf)]=strcat(u(f.get-layout-vars, %0, %1), %b, ulocal(f.apply-effect, %q2), %q1, ulocal(f.apply-effect, strcat(mid(repeat(%q4, %q5), 0, %q5), %q3)), %b)

&f.globalpp.footer [v(d.bf)]=strcat(u(f.get-layout-vars, %0, %1), %b, ulocal(f.apply-effect, strcat(%q2, mid(repeat(%q4, %q5), 0, %q5))), %q1, ulocal(f.apply-effect, %q3), %b)

&f.globalpp.divider [v(d.bf)]=strcat(u(f.get-layout-vars, %0, %1), setq(6, strcat(%q2, mid(repeat(%q4, %q5), 0, %q5), %q3)), %b, ulocal(f.apply-effect, mid(%q6, 0, div(strlen(%q6), 2))), %q1, ulocal(f.apply-effect, mid(%q6, div(strlen(%q6), 2), 999)), %b)

@@ %0 - text (optional)
&f.globalpp.alert [v(d.bf)]=strcat(ulocal(f.apply-effect, v(d.text-left)), ulocal(f.construct-title, if(t(%0), %0, v(d.default-alert))), ulocal(f.apply-effect, v(d.text-right)))

@@ %0: text to format
@@ %1: player to format for (optional)
@@ Registers:
@@ %q0: player width
@@ %q1: left text
@@ %q2: right text
@@ %q3: remaining width
&f.globalpp.formattext [v(d.bf)]=strcat(setq(0, ulocal(f.get-width, %1)), setq(1, v(d.body-left)), setq(2, v(d.body-right)), setq(3, sub(%q0, add(strlen(%q1), strlen(%q2), 4))), wrap(%0, %q3, l, %b%q1%b, %b%q2))

@@ %0: data to format
@@ %1: delimiter (optional, space is default)
@@ %2: player to format for (optional)
&f.globalpp.formatcolumns [v(d.bf)]=strcat(setq(0, ulocal(f.get-width, %2)), setq(1, v(d.body-left)), setq(2, v(d.body-right)), setq(3, sub(%q0, add(strlen(%q1), strlen(%q2), 4))), wrap(%0, %q3, l, %b%q1%b, %b%q2))

+test

@@ Aliases for the other commands.

&f.globalpp.subheader [v(d.bf)]=divider(%0, %1)

&f.globalpp.wheader [v(d.bf)]=header(%0, %1)

&f.globalpp.wdivider [v(d.bf)]=divider(%0, %1)

&f.globalpp.wfooter [v(d.bf)]=footer(%0, %1)

&f.globalpp.wfooter [v(d.bf)]=footer(%0, %1)


@@ %0 - a list
@@ %1 - delimiter (optional)
@@ Output: the length of the longest item in a list.
@@ &f.globalpp.getlongest [v(d.bf)]=strcat(setq(0, 0), null(iter(%0, if(gt(setr(1, strlen(itext(0))), %q0), setq(0, %q1)), if(t(%1), %1, %b))), %q0)

@@ %0 - list of text
@@ %1 - delimiter (optional)
@@ %2 - user (optional)
@@ %3 - margins (optional, default 1)
@@ Output: the list separated into the number of columns that can fit on the screen, max 6.
@@ &f.globalpp.fitcolumns [v(d.bf)]=strcat(setq(0, if(t(%1), %1, %b)), setq(1, ulocal(f.get-max-columns, %2, getlongest(%0, %q0))), boxtext(case(1, gt(%q1, 1), %0, and(lte(%q1, 1), strmatch(%q0, %b)), %0, edit(%0, %q0, %R)), if(gt(%q1, 1), %q0), if(gt(%q1, 1), %q1), %2, %3))


@@ Function: wrap text for display, optionally columnizing it.
@@ Arguments:
@@  %0 - the text to box
@@  %1 - the delimiter to split it by if a table is desired
@@  %2 - the number of columns to display in a table (default 3)
@@  %3 - the user this is getting shown to (optional)
@@  %4 - the margins (optional, default 1)

@@ &f.globalpp.boxtext [v(d.bf)]=strcat(setq(0, ulocal(f.get-width, if(t(%3), %3, %#))), setq(4, if(t(%4), %4, 1)), setq(1, sub(%q0, mul(%q4, 2))), if(or(t(%1), t(%2)), strcat(setq(2, if(t(%2), %2, 3)), setq(3, sub(%q2, 1)), setq(5, mod(%q1, %q2)), setq(3, add(%q3, %q5)), edit(table(%0, div(sub(%q1, %q3), %q2), %q1, %1), ^, space(%q4), %r, strcat(%r, space(%q4)))), wrap(%0, sub(%q1, if(not(mod(%q1, 2)), 1, 0)), left, space(%q4))))

@@ Output: an entire duration string: 3d 4h 5m 57s
@@ %0 - number of seconds to calculate the duration of
&f.duration-string [v(d.bf)]=strcat(setq(0, %0), setq(1,), null(iter(v(d.durations), if(gt(%0, itext(0)), strcat(setq(1, strcat(%q1, setr(2, div(%q0, itext(0))), extract(v(d.duration-words), inum(0), 1), %b)), setq(0, sub(%q0, mul(itext(0), %q2))))))), %q1, %q0, s)


@@ Output: A duration consisting of the largest 2 items in years, 30-day months, weeks, days, hours, minutes, or seconds, but only gives the largest two values.
@@ %0 - number of seconds.
&f.calculate-duration [v(d.bf)]=if(lte(%0, 0), 0s, extract(ulocal(f.duration-string, %0), 1, 2))

@@ Function: Output a duration in the largest 2 numbers - 2d 3h or 1m 20s.
@@ Arguments:
@@  %0 - Timestamp in seconds.
&f.globalpp.interval [v(d.bf)]=ulocal(f.calculate-duration, sub(secs(), %0))

@@ Function: Output a duration in the largest 2 numbers - 2d 3h or 1m 20s.
@@ Arguments:
@@  %0 - number of seconds
&f.globalpp.secs2hrs [v(d.bf)]=ulocal(f.calculate-duration, %0)

@@ %0 - the word
@@ %1 - the position in the string
@@ Cases:
@@ If the word has had its case modified AT ALL from lower-case, leave it alone.
@@ Otherwise, if it is the first word of the sentence, capitalize it,
@@ Otherwise, if it is a member of the don't-touch group, don't capitalize it.

&f.should-word-be-capitalized [v(d.bf)]=cand(member(lcstr(%0), %0), cor(eq(%1, 1), not(member(v(d.words-to-leave-uncapitalized), ulocal(f.word-without-punctuation, itext(0))))))

&f.word-without-punctuation [v(d.bf)]=strip(%0, v(d.punctuation))

@@ Output: A properly capitalized title-case string
@@ %0 - the string to title-case
&f.globalpp.title [v(d.bf)]=iter(%0, if(ulocal(f.should-word-be-capitalized, itext(0), inum(0)), capstr(itext(0)), itext(0)))




@@ Wrapping up:

@restart
