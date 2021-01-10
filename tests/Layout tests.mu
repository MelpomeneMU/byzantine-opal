@@ =============================================================================
@@ TEST SETUP
@@ =============================================================================

&lipsum1 me=Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus tincidunt justo id accumsan luctus. Praesent et consectetur sem, porttitor scelerisque magna. Aenean in eros feugiat, ultrices felis maximus, condimentum est. Nunc nisi nunc, vestibulum a justo eget, iaculis bibendum nibh. Nulla sit amet metus ut nisi congue ultricies. Donec ac dui nec orci vehicula commodo. Aliquam in volutpat odio, vel tempus ante. Aenean et quam facilisis, hendrerit enim id, elementum ipsum.

&lipsum2 me=Phasellus Venenatis Tempor Diam Vitae Turpis Laoreet Eu Fusce Tristique A Elit Hendrerit Volutpat Phasellus Tristique Elit Dignissim Hendrerit Aliquam Magna Enim Sodales Leo Eu Condimentum Turpis Tortor Quis Arcu Praesent Id Consectetur Ligula Quis Pulvinar Ligula Ut Lobortis Nisi Nisi Vel Egestas Dolor Euismod A Vestibulum Luctus Risus Tellus Et Feugiat Turpis Vehicula Ac Nunc Accumsan

&c.+test me=$+test:@pemit %#=strcat(alert() Testing the following configuration:, %r%tEffect:, %b, xget(v(d.bd), d.effect), %r%tColors:, %b, xget(v(d.bd), d.colors), %r%tText color:, %b, xget(v(d.bd), d.text-color), %r%tText left%, repeat%, and right:, %b, xget(v(d.bd), d.text-left), %b, xget(v(d.bd), d.text-repeat), %b, xget(v(d.bd), d.text-right), %r%tTitle left and right:, %b, xget(v(d.bd), d.title-left), %b, xget(v(d.bd), d.title-right), %r%tBody left and right:, %b, xget(v(d.bd), d.body-left), %b, xget(v(d.bd), d.body-right), %r%r, header(iter(lnum(rand(1, 6)), pickrand(v(lipsum2)))), %r, formattext(v(lipsum1), 1, %#), %r, divider(iter(lnum(rand(0, 6)), pickrand(v(lipsum2)))), %r, formatcolumns(v(lipsum2)), %r, divider(iter(lnum(rand(0, 6)), pickrand(v(lipsum2)))), %r, formattable(v(lipsum2), 7, 1), %r, footer(iter(lnum(rand(0, 6)), pickrand(v(lipsum2)))))

@@ =============================================================================
@@ TEST
@@ =============================================================================

&d.text-color [v(d.bd)]=xw

&d.colors [v(d.bd)]=x<#FF0000> x<#AA0055> x<#5500AA> x<#0000FF>

&d.effect [v(d.bd)]=altrev

&d.text-left [v(d.bd)]=.o
&d.text-right [v(d.bd)]=o.
&d.text-repeat [v(d.bd)]=.
&d.title-left [v(d.bd)]=.oO(
&d.title-right [v(d.bd)]=)Oo.
&d.body-left [v(d.bd)]=.
&d.body-right [v(d.bd)]=.

+test

@@ =============================================================================
@@ TEST
@@ =============================================================================

&d.effect [v(d.bd)]=fade

&d.text-left [v(d.bd)]=/
&d.text-right [v(d.bd)]=/
&d.text-repeat [v(d.bd)]==
&d.title-left [v(d.bd)]==/
&d.title-right [v(d.bd)]=/=
&d.body-left [v(d.bd)]=.
&d.body-right [v(d.bd)]=.

+test

@@ =============================================================================
@@ TEST
@@ =============================================================================

&d.effect [v(d.bd)]=alt

&d.text-left [v(d.bd)]=.o
&d.text-right [v(d.bd)]=o.
&d.text-repeat [v(d.bd)]=.oOo.
&d.title-left [v(d.bd)]=.oO(
&d.title-right [v(d.bd)]=)Oo.
&d.body-left [v(d.bd)]=.
&d.body-right [v(d.bd)]=.

+test

@@ =============================================================================
@@ TEST
@@ =============================================================================

&d.effect [v(d.bd)]=random

&d.text-left [v(d.bd)]=.
&d.text-right [v(d.bd)]=.
&d.text-repeat [v(d.bd)]=~
&d.title-left [v(d.bd)]=~{
&d.title-right [v(d.bd)]=}~
&d.body-left [v(d.bd)]=.
&d.body-right [v(d.bd)]=.

+test

@@ =============================================================================
@@ TEST
@@ =============================================================================

&d.body-left [v(d.bd)]=| o |
&d.body-right [v(d.bd)]=| o |
+test

@@ =============================================================================
@@ RESET EVERYTHING BACK TO DEFAULT
@@ =============================================================================

&d.colors [v(d.bd)]=x<#FF0000> x<#AA0055> x<#5500AA> x<#0000FF>

&d.text-color [v(d.bd)]=xw

&d.effect [v(d.bd)]=fade

&d.text-left [v(d.bd)]=.
&d.text-right [v(d.bd)]=.
&d.text-repeat [v(d.bd)]=~
&d.title-left [v(d.bd)]=~{
&d.title-right [v(d.bd)]=}~
&d.body-left [v(d.bd)]=.
&d.body-right [v(d.bd)]=.

+test

@@ =============================================================================
@@ Test some formatting functions...
@@ =============================================================================

th header(Layout appearance tests)

th formattext(a0123456789 b0123456789 c0123456789)

th divider()

th formattext(a0123456789 b0123456789 c0123456789, 1)

th divider()

th formatcolumns(a0123456789 b0123456789 c0123456789)

th divider()

th formattable(a0123456789 b0123456789 c0123456789 d0123456789 e0123456789 f0123456789 g0123456789, 3, 1)

th divider()

th formatcolumns(a0123456789 b0123456789 c0123456789 d0123456789 e0123456789 f0123456789 g0123456789)

th divider()

th formattable(a0123456789 b0123456789 c0123456789 d0123456789 e0123456789 f0123456789 g0123456789 h0123456789 i0123456789 j0123456789 k0123456789 l0123456789 m0123456789 n0123456789 o0123456789 p0123456789 q0123456789 r0123456789 s0123456789 t0123456789 u0123456789 v0123456789 w0123456789 x0123456789 y0123456789 z0123456789, 2, 1)

th divider()

th formattable(a0123456789 b0123456789 c0123456789 d0123456789 e0123456789 f0123456789 g0123456789 h0123456789 i0123456789 j0123456789 k0123456789 l0123456789 m0123456789 n0123456789 o0123456789 p0123456789 q0123456789 r0123456789 s0123456789 t0123456789 u0123456789 v0123456789 w0123456789 x0123456789 y0123456789 z0123456789, 3, 1)

th divider()

th formattable(a0123456789 b0123456789 c0123456789 d0123456789 e0123456789 f0123456789 g0123456789 h0123456789 i0123456789 j0123456789 k0123456789 l0123456789 m0123456789 n0123456789 o0123456789 p0123456789 q0123456789 r0123456789 s0123456789 t0123456789 u0123456789 v0123456789 w0123456789 x0123456789 y0123456789 z0123456789, 4, 1)

th divider()

th formattable(a0123456789 b0123456789 c0123456789 d0123456789 e0123456789 f0123456789 g0123456789 h0123456789 i0123456789 j0123456789 k0123456789 l0123456789 m0123456789 n0123456789 o0123456789 p0123456789 q0123456789 r0123456789 s0123456789 t0123456789 u0123456789 v0123456789 w0123456789 x0123456789 y0123456789 z0123456789, 5, 1)

th divider()

th formattable(a0123456789 b0123456789 c0123456789 d0123456789 e0123456789 f0123456789 g0123456789 h0123456789 i0123456789 j0123456789 k0123456789 l0123456789 m0123456789 n0123456789 o0123456789 p0123456789 q0123456789 r0123456789 s0123456789 t0123456789 u0123456789 v0123456789 w0123456789 x0123456789 y0123456789 z0123456789, 6, 1)

th divider()

th formattable(a0123456789 b0123456789 c0123456789 d0123456789 e0123456789 f0123456789 g0123456789 h0123456789 i0123456789 j0123456789 k0123456789 l0123456789 m0123456789 n0123456789 o0123456789 p0123456789 q0123456789 r0123456789 s0123456789 t0123456789 u0123456789 v0123456789 w0123456789 x0123456789 y0123456789 z0123456789, 7, 1)

th divider()

th formattable(a0123456789 b0123456789 c0123456789 d0123456789 e0123456789 f0123456789 g0123456789 h0123456789 i0123456789 j0123456789 k0123456789 l0123456789 m0123456789 n0123456789 o0123456789 p0123456789 q0123456789 r0123456789 s0123456789 t0123456789 u0123456789 v0123456789 w0123456789 x0123456789 y0123456789 z0123456789, 8, 1)

th divider()

th formattable(a0123456789 b0123456789 c0123456789 d0123456789 e0123456789 f0123456789 g0123456789 h0123456789 i0123456789 j0123456789 k0123456789 l0123456789 m0123456789 n0123456789 o0123456789 p0123456789 q0123456789 r0123456789 s0123456789 t0123456789 u0123456789 v0123456789 w0123456789 x0123456789 y0123456789 z0123456789, 9, 1)

th divider()

th formattable(a0123456789 b0123456789 c0123456789 d0123456789 e0123456789 f0123456789 g0123456789 h0123456789 i0123456789 j0123456789 k0123456789 l0123456789 m0123456789 n0123456789 o0123456789 p0123456789 q0123456789 r0123456789 s0123456789 t0123456789 u0123456789 v0123456789 w0123456789 x0123456789 y0123456789 z0123456789, 10, 1)

th divider()

th formatcolumns(a0123456789 b0123456789 c0123456789 d0123456789 e0123456789 f0123456789 g0123456789 h0123456789 i0123456789 j0123456789 k0123456789 l0123456789 m0123456789 n0123456789 o0123456789 p0123456789 q0123456789 r0123456789 s0123456789 t0123456789 u0123456789 v0123456789 w0123456789 x0123456789 y0123456789 z0123456789)

th divider()

th formatcolumns(a b c d e f g h i j k l m n o p q r s t u v w x y z)

th divider()

th formatcolumns(a b c d e f g h i j k longword m n o p q r s t u v w x y z)

th divider()

th formatcolumns(a b c d e f g h i j k l m n o p q r s t u v w x y z a b c d e f g h i j k l m n o p q r s t u v w x y z)