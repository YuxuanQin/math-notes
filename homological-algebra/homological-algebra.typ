////////////////////////////////////////////////////////////////////
///////////////////////////  Settings  ////////////////////////////
////////////////////////////////////////////////////////////////////
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge  // Commutative diagram

#import "@preview/theorion:0.4.1": *  // Theorem environment
 #import cosmos.fancy: *
//#import cosmos.rainbow: *
// #import cosmos.clouds: *
#show: show-theorion

#show link: set text(fill: red)

// Fonts
#set text(font: (
  (name: "libertinus serif"),
  "Noto Serif CJK SC"
))


// 引用
#set quote(block: true)

#show quote: block.with(  // code block
  fill: luma(220),  // background color
  inset: 9pt
)  // distance between text and the edge

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
#let hd   = $bullet.op$
#let tor  = $"Tor"$
#let dr   = $"dR"$

#let zhu(body) = {
  set text(fill: gray)
  body
}

////////////////////////////////////////////////////////////////////
////////////////////////////  Title  ///////////////////////////////
////////////////////////////////////////////////////////////////////
// Title
#align(center, text(17pt)[
  Notes on Homological Algebra
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

Ref. #link("https://www.seas.upenn.edu/~jean/sheaves-cohomology.pdf")[Prof. Jean Gallier's book].

= Notations
We agree these conventions if not stated otherwise.
/ $cala$: an abelian category;


= Derived functors
== Projective / Injective objects
We love these objects because the induced hom functors and tensor functors are exact. So it is nice when applying those induced functors to exact sequence.

But not all objects are projective or injective, so people are interested how far is an ordinary object from "good" objects (like projectives), and this is why we investigate resolutions.

#quote(attribution: [#link("https://ncatlab.org/nlab/show/resolution")[_Resolution_] (nLab)])[
  A common cause for need of resolutions occurs when in a category of nice objects certain universal constructions – such as quotients or intersections – fail to exist. Homotopical resolution may allow to embed the nice objects in categories of systems of nice objects (such as simplicial objects or chain complexes) inside which homotopical resolutions may be found (such as simplicial resolutions or homological resolutions, respectively).
  
  For example the quotient of a scheme or a smooth manifold by the action of an algebraic group or Lie group may fail to be a scheme or smooth manifold again, respectively, but the corresponding action groupoid (orbifold) serves as a resolution of the quotient in a suitable homotopical category of simplicial objects in schemes/manifolds (presenting the “quotient stack”, see at higher geometry for more).
]

== Projective / Injective resolutions
#definition(title: [Injective resolution])[
  Let $A in cala$, an injective resolution of $A$ is an exact sequence
  #align(center, diagram({
  	node((-2, 0), [$0$])
  	node((-1, 0), [$A$])
  	node((0, 0), [$I^0$])
  	node((1, 0), [$I^1$])
  	node((2, 0), [$I^2$])
  	node((3, 0), [$dots.h.c$])
  	edge((-1, 0), (0, 0), "->")
  	edge((0, 0), (1, 0), "->")
  	edge((1, 0), (2, 0), "->")
  	edge((2, 0), (3, 0), "->")
  	edge((-2, 0), (-1, 0), "->")
  }))
  where $I^k$ is injective for all $k >= 0$.

  We also denote this exact sequence by
  // https://q.uiver.app/#r=typst&q=WzAsMyxbMCwwLCIwIl0sWzEsMCwiQSJdLFsyLDAsImJvbGQoSSleQSJdLFsxLDJdLFswLDFdXQ==
#align(center, diagram({
	node((-2, 0), [$0$])
	node((-1, 0), [$A$])
	node((0, 0), [$bold(I)^A$.])
	edge((-1, 0), (0, 0), "->")
	edge((-2, 0), (-1, 0), "->")
}))
]

The definition of a projective resolution is similar.

== Cohomology
For an additive exact functor $F: cal(C) -> cal(D)$ between abelian categories and $E$ an exact sequence in $cal(C)$, the cohomology of $F(E)$ is trivial since $F$ preserves exact sequence.

But if $F$ is not exact, $F(E)$ is only a complex and the cohomology is not trivial in general. So in this point of view the cohomology groups $H^n (F(E))$ contain some information of exactness of $F$.

So we are interested in cohomology.

== Comparison lemma
Morphisms between objects induce morphisms between injective resolutions.

#lemma(title: [Comparison lemma])[
  Let $g: A -> B$ be a morphism in $cala$, and $0 -> A -> bold(I)^A$ and $0 -> B -> bold(J)^B$ be injective resolutions.

  Then we claim $g$ induces a morphisms between resolutions:
  #align(center, diagram({
  	node((-2, 0), [$0$])
  	node((-1, 0), [$A$])
  	node((0, 0), [$I^0$])
  	node((1, 0), [$I^1$])
  	node((2, 0), [$I^2$])
  	node((3, 0), [$dots.c$])
  	node((-2, 1), [$0$])
  	node((-1, 1), [$B$])
  	node((0, 1), [$J^0$])
  	node((1, 1), [$J^1$])
  	node((2, 1), [$J^2$])
  	node((3, 1), [$dots.c$])
  	edge((-1, 0), (0, 0), "->")
  	edge((-2, 0), (-1, 0), "->")
  	edge((0, 0), (1, 0), "->")
  	edge((1, 0), (2, 0), "->")
  	edge((2, 0), (3, 0), "->")
  	edge((-2, 1), (-1, 1), "->")
  	edge((-1, 1), (0, 1), "->")
  	edge((0, 1), (1, 1), "->")
  	edge((1, 1), (2, 1), "->")
  	edge((2, 1), (3, 1), "->")
  	edge((-2, 0), (-2, 1), "=")
  	edge((-1, 0), (-1, 1), [$g$], label-side: left, "->")
  	edge((0, 0), (0, 1), [$g^0$], label-side: left, "-->")
  	edge((1, 0), (1, 1), [$g^1$], label-side: left, "-->")
  	edge((2, 0), (2, 1), [$g^2$], label-side: left, "-->")
  }))

  And any two lifts of $g$ are chain homotopic.
]

This lemma shows the uniqueness of injective resolution.
#theorem(title: [Injective resolution is unique])[
  Let $0 -> A -> bold(I)^A$ and $0 -> A -> bold(J)^A$ be two injective resolutions of $A in cala$, then they are homotopic.
]
#proof[
  By the previous lemma, $id_A: A -> A$ induces two resolution morphisms: $g_(I J): bold(I)^A -> bold(J)^A$ and $g_(J I): bold(J)^A -> bold(I)^A$.

  Now $g_(I J) compose g_(J I): bold(J)^A -> bold(J)^A$ is a lift of $id_A$, and $id_J: bold(J)^A -> bold(J)^A$ is also a lift of $id_A$, so by the previous lemma, $g_(I J) compose g_(J I)$ is chain homotopic to $id_J$.

  By the same argument $g_(J I) compose g_(I J) hp id_I$. We are done.
]

There are totally similar results for projective resolutions.

== Right dereived functor
With the preparation in the previous section, we can now define the right dereived functors.

#definition(title: [Right dereived functor])[
  Let $F: cal(C) -> cal(D)$ be an additive functor between abelian categories and $cal(C)$ admits enough injectives, then its $n$-th right dereived functor $R^n F: cal(C) -> cal(D)$ is defined as
  $ C |-> H^n (F bold(I)^C)\ (g: C_1 -> C_2) |-> F((g^i)_(i >= 0)) $
  where $bold(I)^C$ is one of the injective resolutions of $C$, and $(g^i)_(i >= 0)$ is the induced map between injective resolutions.
]
#remark[
  For any two injective resolutions $bold(I)^C$ and $bold(J)^C$, the previous theorem ensures they are homotopic and thus their cohomology groups are isomorphic.

  For $g: C_1 -> C_2$ a morphism in $cal(C)$, the previous lemma also ensures different lifts of $g$ are chain homotopic so the induced maps between cohomology groups are the same.

  These two observations ensures that $R^n F$ is well-defined for all $n >= 0$.
]

== Injective objects are acyclic
#theorem(title: [Injective objects are acyclic])[
  For $I in cala$ injective and $F: cala -> cal(B)$ additive, we have
  $ R^n F(I) = 0 $
  for all $n >= 1$.

  And $R^0 F(I) iso F(I)$.
]

== We love left-exact functors
#theorem(title: [$F$ left-exact $==> R^0 F iso F$])[
  As the title shows.
]

== $(R^n F)_(n >= 0)$ is a $delta$-functor
#theorem(title: [$(R^n F)_(n >= 0)$ is a $delta$-functor])[
  This means for any exact sequence
  $ 0 -> A' -> A -> A'' -> 0, $
  there exists a bunch of morphisms $(delta_n)_(n >= 0)$ resulting a long exact sequence
  #align(center, diagram({
  	node((-2, 0), [$0$])
  	node((-1, 0), [$R^0 F (A')$])
  	node((0, 0), [$R^0 F (A)$])
  	node((1, 0), [$R^0 F (A'')$])
  	node((0, 1), [$R^1 F (A)$])
  	node((1, 1), [$R^1 F (A'')$])
  	node((-1, 2), [$R^2 F (A)$])
  	node((0, 2), [$R^2 F (A)$])
  	node((1, 2), [$R^1 F (A'')$])
  	node((-1, 1), [$R^1 F (A')$])
  	node((-1, 3), [$dots.c$])
  	edge((-2, 0), (-1, 0), "->")
  	edge((-1, 0), (0, 0), "->")
  	edge((0, 0), (1, 0), "->")
  	edge((0, 1), (1, 1), "->")
  	edge((-1, 2), (0, 2), "->")
  	edge((0, 2), (1, 2), "->")
  	edge((1, 1), (-1, 2), [$delta_1$], label-side: center, "->")
  	edge((-1, 1), (0, 1), "->")
  	edge((1, 0), (-1, 1), [$delta_0$], label-side: center, "->")
  	edge((1, 2), (-1, 3), [$delta_2$], label-side: center, "->")
  }))
]
#remark[
  Note $R^0 F X iso F X$.
]

== $F$-acyclic objects
Sometimes it is difficult to compute the cohomology groups of an injective resolution, but fortunately people have found another kind of objects may help us.

#definition(title: [$F$-acyclic objects])[
  Let $F: cala -> cal(B)$ be an additive functor, an object $A in cala$ is called $F$-acyclic if
  $ R^n F (A) = 0 $
  for all $n >= 1$.
]
#remark[
  + Injective objects are $F$-acyclic for all functors $F: cala -> cal(B)$;
  + We only require the $R^n F A$ to be trivial when $n >= 1$, because $R^0 F A iso A$ is determined.
]

This is the most important result of $F$-acyclic objects:
#theorem(title: [Compute $R^n F$ by $F$-acyclic resolutions])[
  
]

== Kunneth formula
Kunneth theorem gives a exact sequence with which we can compute $H^n (A^hd times.o B^hd)$ or the corresponding homology version.

An application:
  $ H_p (T^n) = ZZ^mat(n; p), $
  where $T^n := (S^1)^n$ is the $n$-tori.

== Sheaf Cohomology
=== Why you want flabby resolution
#theorem(title: "All injective sheaves are flabby")[
  All injective sheaves are flabby.
]
#proof[
  Let $I in sh_cala (X)$ be an injective sheaf, then consider its canonical flabby embedding
  $ I arrow.hook "Gode"(I), $
  since $I$ is injective, we immediately obtain a retraction of this embedding and thus $I$ is a direct summand of $"Gode"(I)$.

  It is "well-known" that every summand of a flabby sheaf is also flabby #zhu[See [Jean, Prop. 13.6]]. We are done.
]

#theorem(title: "Flabby sheaves are acyclic")[
  Flabby sheaves are $Gamma$-acyclic.
]
#proof[
  Flabbiness implies long exact sequence.
]

Note $sh_cala (X)$ is an abelian category with enough injectives, and thus we can do (co)homology as in any other abelian categories.

With these two theorems in hand we can compute the cohomology groups of a sheaf using flabby resolutions instead of coomon injective resolutions.

#theorem(title: "Compute sheaf cohomology using flabby resolution")[
  Let $F in sh_cala (X)$ and $R^i Gamma (F)$ be the right derived functor applying on $F$, then
  $ R^i Gamma (F) iso H^i (X, F) $
  where $H^i (X, F)$ is the cohomology groups of the complex defined by applying $Gamma$ to the canonical flabby resolution of $F$.
]
#proof[
  Because the derived functor $R^i T$ can be computed by $T$-acyclic resolutions, see [Jean, Prop. 11.34].
]

== Universal $partial$-functors
=== Erasable functor
_Ref_. [Tohoku].

When $F$ is erasable, it with its satellite functors form a universal $partial$-functor.

= Sheaf cohomology
== Universal $delta$-functors are useful
Universal $delta$-functors are especially useful because of its uniqueness, which, in this section, will be used to prove the equivalence chain between various cohomology in algebraic topology, i.e. de Rham cohomology $H_dr (X, -)$, singular cohomology $H_"Sing" (X, -)$, Cech cohomology $caron(H)(X, -)$ and sheaf cohomology $H(X, -)$.

The main idea is that, since the sheaf cohomology $(H^i (X, -)): sh_cala (X) -> cala$ is an universal $delta$-functor, if we can prove that, for example, $(caron(H)^i (X, -))$ is also an universal $delta$-functor and $H^0 (X, F) iso caron(H)^0 (X, F)$ for any sheaf $F$, then by the uniqueness we have this remakable result:
  $ H^i (X, -) iso caron(H)^i (X, -). $

The same argument also applies to other cohomology theory.

== Cech cohomology $iso$ sheaf cohomology
By the uniqueness of universal $delta$-functor, it suffices to prove:
  + Cech cohomology $caron(H) := (caron(H)^i (X, -))_(i >= 0): sh_cala (X) -> cala$ is an universal $delta$-functor.
    - $caron(H)$ is a $delta$-functor for *presheaves*;
    - $caron(H)$ is a $delta$-functor for *sheaves*, provided $X$ is paracompact;
    - $caron(H)$ is universal;

  + $caron(H)^0 (X, F) = H^0 (X, F)$ for all sheaves $F$.

The second part is trivial by definition of Cech cohomology. The first part is rather involved.

=== $caron(H)$ is a $delta$-functor for presheaves
For a *presheaf* $F$, let $C^p (cal(U), F)$ be the set of $p$-cochains related to an open cover $cal(U)$ of $X$. Then $C^p (cal(U), -): psh_cala (X) -> cala$.

#proposition(title: [$C^p (cal(U), F)$ is exact for all $p >= 0$])[
]
#proof[
  Unfold the definition of $C^p (cal(U), F)$ and this is trivial because exact sequence is stable under product.
]

Collecting $C^p$ we obtain a long exact sequence. And thus we reach:
#theorem[
  $(caron(H)^p (X, F))_(p >= 0)$ is a $delta$-functor for presheaves.
]
#proof[
  Let $0 -> F' -> F -> F'' -> 0$ be an exact sequence of *presheaves*, then after applying $C^p (cal(U), -)$ we obtain a short exact sequence of *complex*:
  #align(center, diagram({
  	node((-2, 0), [$0$])
  	node((-1, 0), [$C^hd (cal(U), F')$])
  	node((0, 0), [$C^hd (cal(U), F)$])
  	node((1, 0), [$C^hd (cal(U), F'')$])
  	node((2, 0), [$0$])
  	edge((-2, 0), (-1, 0), "->")
  	edge((-1, 0), (0, 0), "->")
  	edge((0, 0), (1, 0), "->")
  	edge((1, 0), (2, 0), "->")
  }))

Since exact sequence is stable under limit so 
  #align(center, diagram({
  	node((-2, 0), [$0$])
  	node((-1, 0), [$C^hd (X, F')$])
  	node((0, 0), [$C^hd (X, F)$])
  	node((1, 0), [$C^hd (X, F'')$])
  	node((2, 0), [$0$])
  	edge((-2, 0), (-1, 0), "->")
  	edge((-1, 0), (0, 0), "->")
  	edge((0, 0), (1, 0), "->")
  	edge((1, 0), (2, 0), "->")
  }))
is also exact.

By general technique this sequence of complex yields a long exact sequence of Cech cohomology groups.
]

=== $caron(H)$ is a $delta$-functor for sheaves
The main idea is to prove that
  $ caron(H) (X, F) iso caron(H) (X, sh(F)), $
where $sh(F)$ is the sheafification of presheaf $F$. And fortunately this is true when $X$ is paracompact!

For the proof see [Jean, Prop 13.16].

=== $caron(H)$ is universal

To prove $caron(H): sh_cala (X) -> cala$ is an universal $delta$-functor, we first recall the Grothendieck lemma:
#lemma(title: [Erasable $delta$-functors are universal])[
  Let $T = (T^n)_(n >= 0): cal(C) -> cal(D)$ be a $delta$-functor, if every object $A in cal(C)$ there exists a $T$-erasable monic $v: A arrow.hook M_A$, i.e. $T^n (v) = 0$ for all $n >= 1$, then $T$ is universal.
]



#theorem(title: [$caron(H)(cal(U), -)$ is erasable at flabby embeddings])[
  For every space $X$, every open cover $cal(U)$ of $X$, if the sheaf $F$ is flabby then 
  $ caron(H)^i (cal(U), F) = 0, forall i >= 1. $
]
#proof[
  [Jean, Prop 13.12]
]

Since $caron(H)(X, -)$ is the colimit of $caron(H)^i (cal(U), F)$, we have $caron(H) (X, F) = 0$ for flabby $F$.

Note that $caron(H)^0 (X, F) iso F X iso H^0 (X, F)$, so since they are both universal, we obtain the isomorphisms between them.

== Singular cohomology $iso$ sheaf cohomology
In this section we prove another meaningful isomorphism between different cohomology, but using a different method instead of proving $H_"sing"$ is a universal $delta$-functor.

We first observe that $S^p (-, G) in psh_mgrp (X)$ is only a *presheaf*. So in the following we need to consider the sheafification $cal(S)^p (-, G)$ of it.

We will then prove that $(cal(S)^p (-, G))_(p >= 0)$ forms a $Gamma$-acyclic resolution of the constant sheaf $tilde(G)$ under some mild assumptions #zhu[(when $X$ is paracompact, $cal(S)$ is soft and thus acyclic, but it is not flabby)], and thus there is an isomorphism
  $ (ker (cal(S)^p -> cal(S)^(p + 1))) / (im (cal(S)^(p - 1) -> cal(S)^p)) iso H^p (X, tilde(G)). $


And the final step is to prove
  $ H^p_"Sing" (X, G) iso (ker (cal(S)^p -> cal(S)^(p + 1))) / (im (cal(S)^(p - 1) -> cal(S)^p)). $


We prove $cal(S)$ is acyclic by proving it is soft.

== Soft sheaves
A sheaf $F in sh(X)$ is flabby if for every *open* $U$, the restriction map $F X -> F U$ is surjective.

Replace the open set in the definition of flabby sheaves by closed set, we obtain *soft* sheaves.
