////////////////////////////////////////////////////////////////////
///////////////////////////  Settings  ////////////////////////////
////////////////////////////////////////////////////////////////////
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge  // Commutative diagram

#import "@preview/theorion:0.4.1": *  // Theorem environment
// #import cosmos.fancy: *
#import cosmos.rainbow: *
// #import cosmos.clouds: *
#show: show-theorion

#show link: set text(fill: red)

// Fonts
#set text(font: (
  (name: "libertinus serif"),
  "Noto Serif CJK SC"
))

// Paragraph indent
#set par(first-line-indent: 1em)

// Enable justification
#set par(justify: true)

// Set numbering
#set heading(numbering: "1.")

// Self Defined Symbols
#let iso = symbol("≅")
#let hp = symbol("≃")
#let mset = $bold("Set")$
#let sset = $bold("sSet")$
#let mgrp = $bold("Grp")$
#let mtop = $bold("Top")$
#let sh   = $bold("Sh")$
#let psh  = $bold("PSh")$
#let simp = $"Simp"$
#let sing = $"Sing"$
#let inj  = $arrow.hook.r$
#let ch   = $"Ch"$
#let exp  = $"exp"$
#let calo = $cal(O)$
#let ord  = $"ord"$
#let ab   = $bold("Ab")$
#let cala = $cal(A)$

#let zhu(body) = {
  set text(fill: gray)
  body
}

////////////////////////////////////////////////////////////////////
////////////////////////////  Title  ///////////////////////////////
////////////////////////////////////////////////////////////////////
// Title
#align(center, text(17pt)[
  Notes on Riemann Surface
])

// Author and date
#grid(
  columns: (1fr),
  align(center)[
Author: 秦宇轩 (QIN Yuxuan) \
Last compiled at #datetime.today().display() \
  ],
)


#show "TODO": text(red)[*TODO*]


///////////////////////////////////////////////////////////////////
////////////////////////  Table of Contents  //////////////////////
///////////////////////////////////////////////////////////////////
#outline()
#line(length: 100%)

Ref. #link("https://www.mathi.uni-heidelberg.de/~freitag/skripten/riemfl.pdf")[Prof. Dr. Freitag's Notes].

= Chapter III: Sheaves
To implement a homology theory for sheaves, one must first consider the concept of "exactness", and everything is just fine for presheaves, but what if we take a closer look at sheaves?

Suppose we have a sequence of sheaves and maps between them:
#align(center, diagram({
   node((-2, 0), [$0$])
   node((-1, 0), [$F$])
   node((0, 0), [$G$])
   node((1, 0), [$H$])
   node((2, 0), [$0,$])
   edge((-2, 0), (-1, 0), "->")
   edge((-1, 0), (0, 0), [$alpha$], label-side: left, "->")
   edge((0, 0), (1, 0), [$beta$], label-side: left, "->")
   edge((1, 0), (2, 0), "->")
}))

one may want to define the exactness of this sequence by checking if $ker beta = im alpha$, which works just perfect well in the case of presheaves, but *the image of a map between sheaves need not to be a sheaf again*!

#important-box[/ Non-example: Consider the map in $sh(CC)$:
  $ exp: calo -> calo^* $
  where $calo$ is the well-known ($ZZ$-module valued, under addition) sheaf of holomophic functions on $CC$ and $calo^*$ is the multiplicative version, i.e. the ($ZZ$-module valued, under multiplication) sheaf of holomophic functions *without zeros* on $CC$.

  Denote the "image" of $exp$ as $K := im exp$, where $K U := {exp f: f "is holomophic on" U}$, we claim that it is not a sheaf.

  _proof by contradiction_. If $K$ is a sheaf, then consider these two open sets which cover $CC^*$:

    $ H_1 := {z: - pi /2 <= "arg" z <= pi}, H_2 := {z: pi / 2 <= "arg" z <= 2 pi}. $

    Now let $f_1 = id in K(H_1)$ and $f_2 = id in K(H_2)$, we note $f_1 |_(H_12) = f_2 |_(H_12) = id$ so by the definition of a sheaf there must exist a $f = id in K(H_1 union H_2) = K(CC^*)$, but this means there is a holomorphic logarithm on $CC^*$ which is impossible!]

So we can not ccompare the kernel and the image, but need to compare the kernel with *the sheafification of image*#footnote[Contrary to the pathological behaviour of the image, the kernel is always a sheaf.]!

#definition(title: "Exactness of sheaves")[
A sequence of sheaves 
#align(center, diagram({
   node((-2, 0), [$0$])
   node((-1, 0), [$F$])
   node((0, 0), [$G$])
   node((1, 0), [$H$])
   node((2, 0), [$0,$])
   edge((-2, 0), (-1, 0), "->")
   edge((-1, 0), (0, 0), [$alpha$], label-side: left, "->")
   edge((0, 0), (1, 0), [$beta$], label-side: left, "->")
   edge((1, 0), (2, 0), "->")
}))
is exact iff $sh(im alpha) = ker beta$.
]

Surjectivity can be verified at the stalk level:
#theorem[
  A morphism of sheaves $ϕ : F → G$ is surjective if and only if the stalk map $ϕ_p : F_p → G_p$ is surjective for every $p$.
]

This can be proved by the following lemma:
#lemma[
  Let $G$ be a sheaf, and $F, H$ be two subsheaves of $G$, then
  $ F = H <==> F_x = H_x, forall x. $
]
#proof[
  See [Jean, Proposition 10.17].
]

== The canonical flabby resolution

=== Godement resolution
Given a presheaf $F in psh(X)$, we can construct a associated sheaf $"Gode"(F) in sh(X)$ for free:
  $ "Gode"(F)(U) := product_(x in U) F_x, $
where $U subset X$ is open.

This new sheaf is called the *Godement sheaf* of $F$ with a obvious natural#footnote[Yes, $"Gode"$ is a functor.] injection $F inj "Gode"(F)$, and it admits some good properties, such as being flabby, which, as we will see later, indicates the cohomology is trivial.

Mathematicians like iterating, so what about $"Gode"("Gode"(F))$? The answer is we obtain nothing new: this sheaf is just $"Gode"(F)$, since the germ at $"Gode"(F)_x$, the germ at $x$, is just $F_x$.

So you *can not* get a naive resolution like
#align(center, diagram({
	node((-2, 0), [$F$])
	node((-1, 0), [$"Gode"(F)$])
	node((0, 0), [$"Gode"("Gode"(F))$])
	node((1, 0), [$"Gode"("Gode"("Gode"(F)))$])
	node((2, 0), [$...$])
	edge((-2, 0), (-1, 0), "->")
	edge((-1, 0), (0, 0), "->")
	edge((0, 0), (1, 0), "->")
	edge((1, 0), (2, 0), "->")
}))

But as noted before, $F$ is a sub(pre)sheaf of $"Gode"(F)$ and thus peple plays with the quotient sheaf#footnote[There are at least two definitions of "quotient sheaf", one is given by the sheafification of the co-kernel (as defined in Jean), and the another is given by the sheafification of the image (as defined in Freitag).] $"Gode"(F)\/F$.

And now we can iterate:
$ F^((0)) := "Gode"(F),\ F^((n + 1)) := "Gode"(F^((n))\/F^((n - 1))). $

These sheaves give the exact sequence:
#align(center, diagram({
	node((-2, 0), [$F$])
	node((-1, 0), [$F^((0))$])
	node((0, 0), [$F^((1))$])
	node((1, 0), [$F^((2))$])
	node((2, 0), [$...$])
	node((-3, 0), [$0$])
	edge((-2, 0), (-1, 0), "->")
	edge((-1, 0), (0, 0), "->")
	edge((0, 0), (1, 0), "->")
	edge((1, 0), (2, 0), "->")
	edge((-3, 0), (-2, 0), "->")
}))
which is called *the Godement resolution* or the *canonical flabby resolution* (note that every $F^((i))$ is flabby).

=== Sheaf cohomology
Thanks to the composition-preserving property of functors, we can apply the global section functor $Gamma: sh(X) -> ab, F |-> Gamma F := F(X)$ to the Godement resolution, and obtain a *cochain complex*:
#align(center, diagram({
	node((-2, 0), [$Gamma F$])
	node((-1, 0), [$Gamma F^((0))$])
	node((0, 0), [$Gamma F^((1))$])
	node((1, 0), [$Gamma F^((2))$])
	node((2, 0), [$...$])
	node((-3, 0), [$0$])
	edge((-2, 0), (-1, 0), "->")
	edge((-1, 0), (0, 0), "->")
	edge((0, 0), (1, 0), "->")
	edge((1, 0), (2, 0), "->")
	edge((-3, 0), (-2, 0), "->")
}))

This cochain complex consists of abelian groups so we can play with its cohomology groups. And this is (one of) the definition of sheaf cohomology:
  $ H^n (X, F) := (ker (Gamma F^((n)) -> Gamma F^((n + 1))))/(im (Gamma F^((n - 1)) -> Gamma F^((n)))). $

Note that $H^0(X, F) = Gamma F = F X$.

=== Exactness of sheaves induces exactness of Godementons
Yes, for simplicity I call $F^((n))$ _Godementons_...

#theorem(title: "Exactness of sheaves induces exactness of Godementons")[
  If $F -> G -> H$ is an exact sequence of sheaves, then the induced sequence is also exact for all $n$:
    $ F^((n)) -> G^((n)) -> H^((n)). $
]
#proof[
  
]

=== Some homological results
#theorem(title: [Flabbiness implies exactness of $Gamma$])[
  Given an exact sequence of sheaves $0 -> F -> G -> H -> 0$, if $F$ is flabby, then the following sequence is also exact:
  $ 0 -> Gamma F -> Gamma G -> Gamma H -> 0. $
]<flabby-short-exact>
#proof[
  Zorn's Lemma...!

  My thoughts: We may use the theorem that a sequence of sheaves is exact iff it is exact for for any stalks.
]

#theorem(title: "Flabbiness can breed!")[
  Given an exact sequence of sheaves $0 -> F -> G -> H -> 0$, if both $F$ and $G$ are flabby, then $H$ is also flabby.
]
#proof[
  Given an open $V$, we need to prove the restriction $Gamma H -> H V$ is surjective.

  By restricting to $V$, we obtain a new exact sequence:
  $ 0 -> F|_V -> G|_V -> H|_V -> 0 $
  and both $F|_V$ and $G|_V$ are still flabby.

  Apply the former theorem to this new exact sequence we obtain a diagram:
#align(center, diagram({
	node((-2, 0), [$Gamma F$])
	node((-1, 0), [$Gamma G$])
	node((0, 0), [$Gamma H$])
	node((1, 0), [$0"   (Exact)"$])
	node((-3, 0), [$0$])
	node((2, 0))
	node((-3, 1), [$0$])
	node((-2, 1), [$F V$])
	node((-1, 1), [$G V$])
	node((0, 1), [$H V$])
	node((1, 1), [$0"  (Exact)"$])
	edge((-2, 0), (-1, 0), "hook->")
	edge((-1, 0), (0, 0), "->>")
	edge((0, 0), (1, 0), "->")
	edge((-3, 0), (-2, 0), "->")
	edge((-3, 1), (-2, 1), "->")
	edge((-2, 1), (-1, 1), "hook->")
	edge((-1, 1), (0, 1), "->>")
	edge((0, 1), (1, 1), "->")
	edge((-3, 0), (-3, 1), "->")
	edge((-2, 0), (-2, 1), [$"res"$], label-side: right, "->>")
	edge((-1, 0), (-1, 1), [$"res"$], label-side: right, "->>")
	edge((0, 0), (0, 1), [$"res"$], label-side: right, "-->")
}))
where all squares commutes.

Now it's clear $Gamma H -> H V$ is surjective.
]

In @flabby-short-exact we see flabbiness give trivial short exact sequence of global sections, and we will see this result is also true for long exact sequences of global sections, by means of splitting long exact sequences.
#lemma(title: "Splicing short exact sequence")[
  Let $0 -> A -> B -> C -> 0$ and $0 -> C -> D -> E -> 0$ be two exact sequence, then we can splicing them and obtain a longer one:
#align(center, diagram({
	node((-2, 0), [$0$])
	node((-1, 0), [$A$])
	node((0, 0), [$B$])
	node((1, 1), [$C$])
	node((2, 2), [$0$])
	node((0, 2), [$0$])
	node((2, 0), [$D$])
	node((3, 0), [$E$])
	node((4, 0), [$0$])
	edge((-2, 0), (-1, 0), "->")
	edge((-1, 0), (0, 0), "->")
	edge((0, 0), (1, 1), [$g$], label-side: center, "->")
	edge((1, 1), (2, 2), "->")
	edge((0, 2), (1, 1), "->")
	edge((1, 1), (2, 0), [$h$], label-side: center, "->")
	edge((2, 0), (3, 0), "->")
	edge((3, 0), (4, 0), "->")
	edge((0, 0), (2, 0), [$h compose g$], label-side: center, "-->")
}))
]
#proof[
  Trivial.
]


#lemma(title: "Flabbiness implies long exact sequence")[
  Let 
    #align(center, diagram({
    	node((-2, 0), [$0$])
    	node((-1, 0), [$F$])
    	node((0, 0), [$F_0$])
    	node((1, 0), [$F_1$])
    	node((2, 0), [$...$])
    	edge((-2, 0), (-1, 0), "->")
    	edge((-1, 0), (0, 0), "->")
    	edge((0, 0), (1, 0), "->")
    	edge((1, 0), (2, 0), "->")
    }))
  be an exact sequence of flabby sheaves, then $Gamma$ preserves the exactness, i.e. the following sequence is exact:
    #align(center, diagram({
    	node((-2, 0), [$0$])
    	node((-1, 0), [$Gamma F$])
    	node((0, 0), [$Gamma F_0$])
    	node((1, 0), [$Gamma F_1$])
    	node((2, 0), [$...$])
    	edge((-2, 0), (-1, 0), "->")
    	edge((-1, 0), (0, 0), "->")
    	edge((0, 0), (1, 0), "->")
    	edge((1, 0), (2, 0), "->")
    }))
]
#proof[
  From the long sequence we obtain a bunch of short exact sequence like
#align(center, diagram({
	node((-2, 0), [$0$])
	node((-1, 0), [$F$])
	node((0, 0), [$F_0$])
	node((1, 0), [$F_0\/F$])
	node((2, 0), [$0$])
	edge((-2, 0), (-1, 0), "->")
	edge((0, 0), (1, 0), "->")
	edge((1, 0), (2, 0), "->")
	edge((-1, 0), (0, 0), "->")
}))
#align(center, diagram({
	node((-2, 0), [$0$])
	node((-1, 0), [$F_0\/F$])
	node((0, 0), [$F_1$])
	node((1, 0), [$F_1\/F_0$])
	node((2, 0), [$0$])
	edge((-2, 0), (-1, 0), "->")
	edge((0, 0), (1, 0), "->")
	edge((1, 0), (2, 0), "->")
	edge((-1, 0), (0, 0), "->")
}))
  And since in the first exact sequence, both $F$ and $F_0$ are flabby so $F_0\/F$ is also flabby, and we apply this result to the second exact sequence, finally this procedure shows that all $F_(i + 1)\/F_i$ are flabby.
  
  Thanks to @flabby-short-exact, after applying $Gamma$ those sequence are still exact. So by splicing them we obtain the required long exact sequence.
]

#theorem(title: [Flabby sheaves admits trivial cohomology])[
  If $F$ is flabby, then
  $ H^n (X, F) = 0 $
  for all $n > 0$.
]
#proof[
  Apply the above lemma.
]
#warning-box[
  Please note that $H^0 (X, F) = Gamma F$ for all kinds of sheaves $F$, because $F$ itself does not occur in the global sections complex!
]

#definition(title: "Acyclic Sheaf")[
  We call a sheaf *acyclic* if its higher order cohomology is trivial, i.e. 
  $ H^n (X, F) = 0 $
  for all $n > 0$.
]
So flabby sheaves are acyclic.

This theorem shows the reason behind the name of "canonical resolution":

#theorem(title: "Canonical resolution is indeed canonical")[
  Let $0 -> F -> F_0 -> F_1 -> ...$ be a acyclic resolution of sheaf $F$, then there is a natural isomorphism between $H^n (X, F)$ and the $n$-th cohomology of the following complex:
  $ 0 -> Gamma F_0 -> Gamma F_1 -> ... $
]
#proof[
  See Freitag.
]

== Sheaves on manifolds
Results in this section are mainly used for manifolds, since all of them are paracompact.

Since we have a structure sheaf $calo_X$ in hand for every manifold $X$ and it is always a sheaf of rings, we only consider $calo_X$-modules in this section.

#theorem(title: [$X$ paracompact $==> Gamma$ preserves surjectivity])[
  Let $X$ be paracompact and $M -> N$ a surjective morphism between $calo_X$-modules, then
  $ Gamma M -> Gamma N $
  is also surjective.
]

This implies $Gamma$ is exact.
#theorem(title: [$Gamma$ is exact for $calo_X$-modules on manifold])[
  For a exact sequence of $calo_X$-modules on a paracompact space $X$
  $ M -> N -> P, $
  $Gamma$ is exact, i.e.
  $ Gamma M -> Gamma N -> Gamma P $
  is also exact.
]
#theorem(title: [$calo_X$-moduels on manifolds are acyclic])[
  For $calo_X$-module $F$ on manifold $X$, the cohomology is trivial:
  $ H^n (X, F) = 0 $
  for all $n > 0$.
]

=== Fine sheaves
Ref. 杜武亮 - #link("https://arxiv.org/abs/2206.07512")[_Introduction to Sheaf Cohomology_]

Fine sheaves are another kind of acyclic sheaves on manifold.

=== $sh_ab (X)$ is just like $ab$
Ref. Jean Gallier - #link("https://www.seas.upenn.edu/~jean/sheaves-cohomology.pdf")[_Sheaf Cohomology_]

#theorem(title: [Baer's embedding theorem])[
  $ab$ admits enough injectives.
]
#proof[
  See [Jean Theorem 11.6].
]

So given a $F in sh_ab (X)$, we can construct a injective sheaf $I$ with stalk-wise with a embedding $iota: F inj I$, also stalk-wise.

We introduce a lemma:
#lemma[
  For an adjoint pair $L tack.l R: cal(C) -> cal(D)$ between abelian categories, if $L$ is exact #zhu[(i.e. preserves limits since as a left adjoint it automatically preserves colimits)], then $R$ preserves injective objects.
]

Now we prove the most fundmental theorem which ensures the existence of sheaf cohomology.

#theorem(title: [$sh_cala (X)$ admits enough injectives if $cala$ is so])[
  For example: the category of $R$-moduels $sh_R (X)$ admits enough injectives.
]
#proof[
  Based on [Jean, Proposition 13.1], see also #link("https://zhuanlan.zhihu.com/p/268175784")[Alkaid - _Homological Algebra and Commutative Algebra_ (知乎)] for more on abstract nonsense.


  Now let $cala$ be an abelian category which admits enough injectives, $x in X$ a point and consider this pair of functors:
  #align(center, diagram({
  	node((-1, 0), [$sh_cal(A) (X)$])
  	node((1, 0), [$cal(A)$])
  	edge((-1, 0), (1, 0), [$"stalk"_x$], label-side: left, label-pos: 0.4, shift: 0.1, "->")
  	edge((1, 0), (-1, 0), [$"sky"_x$], label-side: left, shift: 0.05, "->")
  }))
  where $"stalk"_x: F |-> F_x$ is the usual stalk functor, and $"sky"_x: A |-> underline(A)$ is the skyscraper functor. It is easy to check $"stalk"_x tack.l "sky"_x$.

  Note $"stalk"_x$ is exact, then by the claim $"sky"_x$ preserves injective objects.

  Let $F in sh_cala (X)$ be a sheaf, if $cala$ admits enough injectives, then choose a monic inclusion to an injective object $iota_x: F_x arrow.hook I^x$ for every point $x in X$. Now apply $"sky"_x$ to this inclusion, and the result map $eta_x := "sky"_x (iota_x)$ is also monic because as a right adjoint $"sky"_x$ automatically preserves kernel.

  Define $I in sh_cala (X)$ as $I(U) := product_(x in U) I^x$, this implies $I = product_(x in X) "sky"_x I^x$ and since $"sky"_x$ preserves injective objects $I$ is also an injective object.

  Define $eta: F => I$:
  $ eta_U: F(U) -> I(U) := F(U) arrow.hook product_(x in U) F_x arrow.hook product_(x in U) I^x. $
  Now $eta_x = iota_x$ is monic and $I$ is injective. We are done.
]


#remark[
  Actually, every topos admits enough injective #zhu[(the subobject classifier $Omega$ is injective, and so is the power $Omega^X$, see [Mac Lane & Moerdijk, IV.10])], such as $sh_mset (X)$. However, we can not deduce $sh_cala (X)$ admit enough injective from this observation since it is *not* a topos. #text(fill: gray)[($sh_cala (X)$ is an abelian category, but all non-trivial abelian categories are not cartesian-closed and thus it is not a topos.)]
]

= Chapter V: Basic facts about Riemann surface
== $(calo_(X, p), ord_p)$ is a valuation ring
References of this section: #link("https://www.math.ru.nl/~vhoskins/")[Prof. Victoria Hoskins]'s #link("https://www.bilibili.com/video/BV1E24y1T7LH")[Riemann surface course] (start on `1:26:22`)

Given a connected riemann surface $X$ with its function sheaf $calo_X$, then the germ stalk $calo_(X, p)$ at a point $p in X$ is a local ring. With some input from complex analysis we can further claim that it is a ring with discrete valuation:

For $f in calo_X (U)$ and $p in U$, we can define the order of $f$ at $p$ as the order of the local normal form associated with $f$ at $p$. This order function is clearly stable under the equivalence relation which identifies two holomorphic functions around $p$ if thet share the same Tylor expansion in a open set around p, so $ord_p: calo_(X, p) -> NN_oo$ is a well-defined function.

We checked $ord_p$ is indeed a valuation.

== Some examples of Riemann surfaces
=== Complex projective plane $PP^1$
Though we call it "plane", it is actually biholomorphic to the sphere.

To prove it is a _compact_ surface, one consider the canonical projective
$ "pr": CC^2 \\ {0} ->> PP^1, $
and then there is a quick observation
$ "pr"(SS^3) = PP^1, $
where $SS^3 := {(z_1, z_2): |z_1|^2 + |z_2|^2 = 1}$ is the ball.

Since $"pr"$ is continuous and $SS^3$ is compact, $PP^1$ is also compact.

So to prove a surface is compact, we can always try to construct a surjective map from a compact surface to it.

== Map between Riemann surfaces
=== Canonical local form of a holomorphic map
#theorem(title: "Canonical local form of non-constant holomorphic map")[
  Let $f: X -> Y$ be a non-constant holomorphic map between Riemann surfaces.

  Then for any $x in X$, there exist a chart $phi: U -> V$ around $x$ and a chart $psi: W -> Z$ around $f(U)$ with a natural number $k$ such that the induced local function $g$ act on $z in V$ as $g(z) = z^k$.

  // https://q.uiver.app/#r=typst&q=WzAsNCxbMCwwLCJVIl0sWzEsMCwiVyJdLFswLDEsIlYiXSxbMSwxLCJaIl0sWzAsMSwiZiJdLFswLDIsInBoaSIsMCx7Im9mZnNldCI6LTF9XSxbMSwzLCJwc2kiXSxbMiwzLCJnIDo9IHBzaSBjb21wb3NlIGYgY29tcG9zZSBwaGleKC0xKSIsMix7InN0eWxlIjp7ImJvZHkiOnsibmFtZSI6ImRhc2hlZCJ9fX1dLFsyLDAsInBoaV4oLTEpIiwwLHsib2Zmc2V0IjotMX1dXQ==
#align(center, diagram({
	node((-1, 0), [$U$])
	node((0, 0), [$W$])
	node((-1, 1), [$V$])
	node((0, 1), [$Z$])
	edge((-1, 0), (0, 0), [$f$], label-side: left, "->")
	edge((-1, 0), (-1, 1), [$phi$], label-side: left, shift: 0.05, "->")
	edge((0, 0), (0, 1), [$psi$], label-side: left, "->")
	edge((-1, 1), (0, 1), [$g := psi compose f compose phi^(-1)$], label-side: right, "-->")
	edge((-1, 1), (-1, 0), [$phi^(-1)$], label-side: left, shift: 0.05, "->")
}))
]

#corollary(title: "Non-constant holomorphic are open")[
  Let $f: X -> Y$ be a non-constant holomorphic map between Riemann surfaces, then $f$ is open.
]
#proof[
  Being open is a local property and since the canonical local form $g := psi compose f compose phi^(-1)$ of $f$ is always open, we obtain
  $ f = psi^(-1) compose g compose phi $
  is also open.
]

#corollary(title: "Maximum principle")[
    Let $f: X -> Y$ be a non-constant holomorphic map between Riemann surfaces, then $f$ does not admit maximum.
]
#proof[
  Because $f$ is open.
]

#corollary(title: "Identity property")[
  Let $f, g: X -> Y$ be two non-constant holomorphic maps between Riemann surfaces, then if $f$ and $g$ coincide in a set with accumulation point, then $f = g$.
]
#proof[
  Consider the zero set $K$ of $f - g$, then $K$ admits an accumulation point, and then there is a open set $U$ around this accumulation pint where $f - g$ is the constant function $0$ by the identity property of $CC$.

  Now suppose if $f - g$ is non-constant, then by the previous corollaries $(f - g)(U) = {0}$ is open in $CC$, a contradiction!

  So $f - g$ is constant and equals to $0$.
]

#theorem(title: "Holomorphic maps and covering projections")[
  Let $f: X -> Y$ be a non-constant holomorphic map between Riemann surfaces, then it is a covering map, i.e. it is open and discrete.
]
#proof[
  See [Wehler].
]
#remark[
  Here by "covering map" we mean a continuous, open and discrete map.
]

== When map is proper
The main result is, when a map between Riemann surfaces is *proper*, then the cardinalities of different fibers are same, because the map is actually a *unbounded, unbranched covering map* (i.e. the common covering map in algebraic topology) and surfaces are *connected*.

#lemma(title: "Proper unbranched coverings are unbounded")[
  A proper, unbranched covering projection $f: X -> Y$ between locally compact Hausdorff spaces is an unbounded, unbranched covering projection with finite fibres.
]
#proof[
  See [Wehler, Rmk 3.20, Part 4].
]

This result implies the following important observation:

#corollary(title: "Map between compact surfaces are almost topological covering")[

  A holomorphic map between compact Riemann surfaces is a topological covering map outside branched points.

  This is why sometimes people call those maps _branched_ covering maps.
]

#definition(title: "Cardinality of fiber")[
  For a holomorphic map $f: X -> Y$ with finite fibers, we can define the cardinality of fibers $"card" X_y$ as:
  $ "card" X_y := sum_(x in X_y) "multi"(x), $
  where $"multi"(x)$ is the multiplicity of $x$ and is defined from the local normal form.
]

#theorem(title: "Value attainment of proper holomorphic maps")[
  Let $f: X -> Y$ be a *proper* non-constant holomorphic map, then all fibers $X_y$ for $y in Y$ have same cardinality.
]
#proof[
  See [Wehler, Thm 3.22].
]

#corollary(title: "Fundamental theorem of algebra")[
  A complex polynomial $f := a_n x^n + ... + a_1 x + a_0$ with $a_n != 0$ admits $n$ roots on $CC$, counted with multiplicity.
]
#proof[
  View $f$ as a holomorphic function $f(x): PP^1 -> PP^1$, then the cardinality of fiber at $oo$ is
  $ "card" PP^1_oo = n. $
  Since $f$ is proper, by the previous theorem, the cardinality of fiber at $0$ is also $n$, i.e.
  $ "card" {"zeros of" f} = n. $
]
#remark[
  If $X$ and $Y$ are Hausdorff topological spaces and $X$ is *compact*, then every continuous mapping $f: X -> Y$ is automatically proper.

  Note $PP^1$ is compact (it is biholomorphic to the sphere), $f$ is proper.
]


== Analytic continuation
#definition(title: "Analytic continuation")[
  TODO
]
#theorem(title: "Analytic continuation is a path in the etale space")[
  Let $a, b in X$ be two points in a Riemann surface and $f_a in calo_a$ and $f_b in calo_b$ be two germs.

  Then a continuation from $f_a$ to $f_b$ along a path $gamma: [0, 1] -> X$ correspondences to a path $tilde(gamma): [0, 1] -> |calo|$ where $|calo|$ is the induced etale space of the structure sheaf $calo$.
]
