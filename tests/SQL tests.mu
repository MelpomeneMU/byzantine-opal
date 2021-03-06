@@ These tests assume a default MediaWiki 1.35 installed with no prefix. Modify to your liking.

th fetch()
th fetch(actor)
th fetch(actor, actor_id actor_name)
th fetch(actor, actor_id actor_name, actor_id=1)
th fetch(,,, %r, @)
th fetch(actor,,, %r, %,%b)
th fetch(actor, actor_id actor_name,, %r, %.%b)
th fetch(actor, actor_id actor_name, actor_id=1, %r, %.%b)
th fetch(actor, actor_id actor_name, actor_name LIKE 'B*')

@@ Have a non-staffer do this - they should get #-1 PERMISSION DENIED. If not, you're missing isstaff().

th fetch()

@@ Should return no rows, only the header row, because of sanitation:

th fetch(actor, actor_id actor_name, actor_name LIKE 'B%')

@@ Should error, can't get two tables:

th fetch(actor archive)

@@ Now to test the randomness function.

th fetch(actor,, rand)
th fetch(actor, actor_id actor_name, rand)

@@ Now command tests.

th From a staffbit try:

+db/hide bot_passwords
+db
+db/hide bot_passwords

th From a player bit try:

+db/hide bot_passwords

th Back to staff-bit:

+db/c user
+db/col user=user_id user_name user_email user_editcount
+db user

@@ Should error:
+db/co user=7 * * 14

@@ Test for bad display settings:
+db/colwidth user=7 * * 14
+db user

+db/col user=
+db user
+db/col user=user_id user_name user_email user_editcount
+db user
+db/colwidth user=7 * * 14
+db user

+db/col
+db/col user_id user_name user_email user_editcount
+db/cw 7 * * 14

+db/hide
+db user
+db/hide user
+db user
+db/show user
+db/show

th Should error, this isn't enabled:
+db/unlock
th These should succeed:
@wait 1=+db/unlock user
@wait 1=+db/lock user
@wait 3=th This should throw a normal error:
@wait 3=+db/lock

th Testing POST():

th sql(CREATE TABLE `lagos`.`demo` ( `id` INT UNSIGNED NOT NULL AUTO_INCREMENT , `dateadded` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP , `test_1` VARCHAR(255) NOT NULL , `test_2` VARCHAR(255) NULL , PRIMARY KEY (`id`)) ENGINE = InnoDB COMMENT = 'Demo only, feel free to delete.';)

th All of these should error:
th post()
th post(demos)
th post(demo, test_1)
th post(demo 1 2, test_2)
th post(demo, test_2, Bob~Sandy)
th post(demo, test_2, Oscar, id=99999)
th post(demo, test_1~test_3, Bob~Bobbitus Maximus, INSERT)

th Be careful with these, they work:

th post(demo, test_1~test_2, Bob~Bobbitus Maximus, INSERT)
+db demo
th post(demo, test_1~test_2, Bob2~Bobbitus Maximus, id=1)
+db demo

th Should fail because test_1 is required to be non-null:
th post(demo, test_2, Bobbitus Maximus, INSERT)
+db demo

th Should succeed because sanitization:
th post(demo, test_1~test_2, sanitize(Bob~Robert'\); DROP TABLE students;--), INSERT)
+db demo

th post(demo, test_1, sanitize(asdf'\); DROP TABLE students;--), id=1)
+db demo


@@ Make sure we have some randomness.

+db/rand user
+db/rand user
+db/rand user
+db/rand user

@@ Time to try SQL injection!

&d.bobby_tables me=Robert'); DROP TABLE students;--

th sanitize(v(d.bobby_tables))

th debug(v(d.sf))

th debug(v(d.sc))

+db/find user/user_name=Robert'); DROP TABLE students;--

@@ Trying paging:

+db page
+db/n
+db/n
+db/n
+db/n
+db/b
+db/b
+db/b


@@ To hide all wiki tables so staff won't have to deal with the spam, use this:

+db/hide actor
+db/hide archive
+db/hide bot_passwords
+db/hide category
+db/hide categorylinks
+db/hide change_tag
+db/hide change_tag_def
+db/hide comment
+db/hide content
+db/hide content_models
+db/hide externallinks
+db/hide filearchive
+db/hide image
+db/hide imagelinks
+db/hide interwiki
+db/hide ip_changes
+db/hide ipblocks
+db/hide ipblocks_restrictions
+db/hide iwlinks
+db/hide job
+db/hide l10n_cache
+db/hide langlinks
+db/hide log_search
+db/hide logging
+db/hide module_deps
+db/hide objectcache
+db/hide oldimage
+db/hide page
+db/hide page_props
+db/hide page_restrictions
+db/hide pagelinks
+db/hide protected_titles
+db/hide querycache
+db/hide querycache_info
+db/hide querycachetwo
+db/hide recentchanges
+db/hide redirect
+db/hide revision
+db/hide revision_actor_temp
+db/hide revision_comment_temp
+db/hide searchindex
+db/hide site_identifiers
+db/hide site_stats
+db/hide sites
+db/hide slot_roles
+db/hide slots
+db/hide templatelinks
+db/hide text
+db/hide updatelog
+db/hide uploadstash
+db/hide user
+db/hide user_former_groups
+db/hide user_groups
+db/hide user_newtalk
+db/hide user_properties
+db/hide watchlist
+db/hide watchlist_expiry
