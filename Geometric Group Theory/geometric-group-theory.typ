////////////////////////////////////////////////////////////////////
///////////////////////////  Settings  ////////////////////////////
////////////////////////////////////////////////////////////////////
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge  // Commutative diagram

#import "@preview/theorion:0.4.0": *  // Theorem environment
// #import cosmos.fancy: *
#import cosmos.rainbow: *
// #import cosmos.clouds: *
#show: show-theorion

#show link: underline

// Fonts
#set text(font: (
  (name: "libertinus serif"),
  "Noto Serif CJK SC"
))

// Paragraph indent
#set par(first-line-indent: 1em)

// Enable justification
#set par(justify: true)


////////////////////////////////////////////////////////////////////
////////////////////////////  Title  ///////////////////////////////
////////////////////////////////////////////////////////////////////
// Title
#align(center, text(17pt)[
  Notes on Geometric Group Theory (and Model Theory)
])

// Author and date
#grid(
  columns: (1fr),
  align(center)[
Author: 秦宇轩 (QIN Yuxuan) \
Last compiled at #datetime.today().display() \
  ],
)


///////////////////////////////////////////////////////////////////
///////////////////////////  Macros  //////////////////////////////
///////////////////////////////////////////////////////////////////
//#show "Grp": $bold(upright(G r p))$
//#show "Set": $bold(upright(S e t))$
//#show "ACF": $bold(upright(A C F))$
//#show "Field": $bold(upright(F i e l d))$
//#show "Ring": $bold(upright(R i n g))$
//#show "End": $bold(upright(E n  d))$
//#show "CAT": $bold(upright(C A T))$
//#show "Mnd": $bold(upright(M n d))$
#show "TODO": text(red)[*TODO*]


///////////////////////////////////////////////////////////////////
////////////////////////  Table of Contents  //////////////////////
///////////////////////////////////////////////////////////////////
#outline()
#line(length: 100%)

This note is taken on the Nankai Logic Summer School 2025: _Gromov's Randomness & Model Theory of Groups_, lectured by Prof. Rizos Sklinos.

I must admit that I almost know nothing about serious geometric group theory and large-scale geometry, and this note should not be used as a study matetial. I just written down things interested me.

These materials may contain typos and errors, use at your own risk.

Reference: #link("https://loeh.app.uni-regensburg.de/ggt_book/ggt_book_draft.pdf")[Prof. Löh's Notes].


= Day 1
+ Dehn _solved_ the word problem for fundamental groups of surfaces.

+ Hyperbolic groups: Those that satisfy Dehn's algorithm and admit a finitely presentation.

+ (*Gromov*) If we pick a finite presented group _at random_, then it is almost hyperbolic.

+ (*Geodesic Path*) For a metric space $(X, d)$, a geodesic path from $x$ to $y$ in $X$ is an isometry map $c: [0, L] -> X$ for some $L >= 0$ such that:
  $ cases(c(0) = x, c(L) = y). $
  In paticular, since $c$ is a isometry, we know that $L = d(x, y)$.
+ (*Geodesic Space*) A metric space $(X, d)$ is called a geodesic space if it satisfies: for all $x, y in X$ there exists a geodesic path connecting $x$ and $y$.

+ $(RR^2, d_E)$ is _uniquely_ geodesic.

+ (*$delta$-slim*) Let $delta >= 0$, a geodesic triangle $[x, y, z]$ is called $delta$-slim if for any $u in [x, y]$, there exists a point $v in [y, z] union [z, x]$ such that $d(u, v) <= delta$.
  - _Remark:_ By "geodesic triangle", we mean a triple $(x, y, z)$ of points in a metric space, with a set of _chosen_ geodesic paths between them.

+ (*$delta$-hyperbolic*) A geodesic metric space is called _$delta$-hyperbolic_ if all geodesic triangles are $delta$-slim.

+ (*Hyperbolic*) A geodesic metric space is _hyperbolic_ if it is $delta$-hyperbolic _for some_ $delta$.

+ (*Real Tree*) A $0$-hyperbolic space is called a _real tree_.

+ (*Tripod*) Given a geodesic triangle $[x, y, z]$, a tripod of it is a real tree with three vertex $u_x, u_y, u_z$:
  #align(center, diagram({
     node((0, 0), [$bullet$])
     node((-1, 1), [$u_y$])
     node((1, 1), [$u_z$])
     node((0, -1), [$u_x$])
     edge((0, 0), (-1, 1), [$b$], label-side: left)
     edge((0, 0), (1, 1), [$c$], label-side: right)
     edge((0, 0), (0, -1), [$a$], label-side: right)
  }))
  such that
  $ cases(
    a + b = d(x, y),
    b + c = d(y, z),
    c + a = d(z, x),
  ) $
  In short: a tripod of a geodesic triangle $[x, y, z]$ is a real tree $(u_x, u_y, u_z)$ isometric to it.

+ (*$delta$-thin*) For a geodesic triangle $Delta := [x, y, z]$ with a tripod isometry $X_Delta: Delta -> T(a, b, c)$, we say $Delta$ is $delta$-thin if for any $p, q in X_Delta^(-1)(t)$ where $t in T(a, b, c)$, we always have $d(p, q) <= delta$.
  - _Remark_: $delta$-thin is proper stronger than $delta$-slim.

+ (*$(delta)$-hyperbolic*) A metric space is $(delta)$-hyperbolic if for any $w, x, y, z in X$ we have:
  $ d(x, y) + d(y, z) <= max{d(x, w) + d(y, z), d(x, z) + d(y, w)} + delta. $
  - _Problem_: Does the class of $(1)$-hyperbolic finite graphs have the _amalgmation property_?
    - _Remark_: A theory admit the amalgmation property if for any extensions $B, C$ of a model $A$, there exists an extension of both $B$ and $C$ such that
    #align(center, diagram({
       node((0, 2), [$A$])
       node((-1, 1), [$B$])
       node((1, 1), [$C$])
       node((0, 0), [$D$])
       edge((0, 2), (-1, 1), "hook'->")
       edge((0, 2), (1, 1), "hook->")
       edge((-1, 1), (0, 0), "hook'->")
       edge((1, 1), (0, 0), "hook->")
    }))
    commutes.
  - _Problem_: What about $(delta)$-hyperbolic finite graphs for general positive real $delta$?

+ (*Quasi-isometry*) Definition of quasi-isometry was given here (but due to my laziness, ommitted).
  - _Remark_: This is indeed an equivalent relation.
  - _Examples_:
    - Any finite diameter space $tilde^"qi" {"point"}$.
    - $(ZZ times ZZ, "taxi metric") tilde^"qi" (RR^2, d_E))$ where $d_E$ is the common Euclid's metric.
    
= Day 2
+ "The" Cayley graph of a finitely generated group is unique (up to quasi-isometry).
  - _Remark:_ For group $G = chevron.l S | R chevron.r$ finitely generated, we can define the length for any element $g in G$ as $|g|_G := min_(g = h) |h|_"Cayley"$.

+ (*Hyperbolic Group*) A group is called hyperbolic if its Cayley graph is hyperbolic as a metric spacce.
  - _Remark:_ This is just one of the many definitions of hyperbolic groups.

+ Some facts:
  - $"Cay"(G, A)$ for $A$ a generating set of $G$, is a proper space with all geodesics.
  - $G$ acts on $"Cay"(G, A)$ by sendind $(r, g)$ to $r dot g$, which is an isometry, i.e. $d(r g, r h) = d(g , h)$.
  - The above action is properly-discontinuous, i.e., for compact $X subset "Cay"(G, A)$, the set ${g: g X inter X != emptyset}$ is finite.
  - The action is co-compact, i.e., $"Cay"(G, A) \/ G$ is compact.
  
+ (*Svarč-Milnar Theorem*) See Loeh's book.

+ For surface with genus $g >= 2$, its fundamental group $pi_1(Sigma_g)$ is hyperbolic, since

  $ pi_1(Sigma_g) arrow.ccw_("nicely") HH^2 ("the hyperbolic plane"). $

  It acts so nicely that the S-M theorem ensures $pi_1(Sigma_g)$ is hyperbolic.

+ Hyperbolicity is stable under finite index.

+ Finite groups and free groups are all hyperbolic.

+ A group $G$ is free $<==>$ It acts freely without inversions on a simplicial tree.
  - ($==>$) If $G$ is free, then (assume $G = bold(F)S$)
    $ G arrow.ccw "Cay"(G, S), $
    where $"Cay"(G, S)$ is a simplicial tree.
  - ($<==$) Use covering space theory. If $G arrow.ccw T$ nicely then we obtain a covering map $p: T -> T slash G$, which is universal, so $pi_1(T slash G) tilde.equiv G$. But $T slash G$ is a graph so $pi_1(T slash G)$ is free.

+ (*Asymptotic cones*) Given a non-principal ultrafilter $cal(U)$ on $NN$, and a metric space $(X, d)$, we can construct another metric space  consists of elements near a given sequence $(e_i)_i$, formally:
  $ "Cone"_cal(U) (X, (e_i)_(i in NN), (s_i)_(i in NN)) $
  is a metric space where:
  - Elements: equivalence class of $(x_i)$ where
    - $(x_i)$ satisfies $lim_cal(U) (d(e_i, x_i))\/s_i$ exists;
    - $(x_i) ~ (y_i)$ iff $lim_cal(U) d(x_i, y_i)\/s_i = 0$;
  - Metric: $d^*((x_i), (y_i)) = lim_cal(U) d(x_i, y_i)\/s_i$.
  _Remark_. So the requirement that its elements are forced to be equivalence class is only needed for the axiom of metric space.
+ Some facts about asymptotic cones: for finitely generated group, all asymptotic cones of $(G, d)$ are geodesic.
+ Gromov used the notion of asymptotic cone to define (or gave an equivalent definition of) hyperbolic groups.
+ (*Area of an element*) For a finite presentation $chevron.l A, R chevron.r$ and $w in chevron.l.double R chevron.r.double subset F A$, define 
  $ "area"(w) := min {M: w = product_(i = 1)^M p_i r_i^(epsilon_i) p_i^(-1)}. $
+ (*Dehn function*) For a specific presentation $P$ of a group $G$, define $delta_P: NN -> NN, delta_P (n) := max {"area"(w): l(w) <= n}$.
+ (*Isopermetric inequality*) For a finitely generated group with a presentation $Gamma$, we have $Gamma$ satisfies a linear isopermetric inequality if $delta_Gamma (n) <= n$.
+ Let $P = chevron.l A | R chevron.r$ be a finitely presentation. Then the word problem is decidable iff $delta_P (n) <= f(n)$ for a computable $f$.

= Day 3
+ A finitely presentable group with a presentation $Gamma$ is hyperbolic iff $delta_Gamma (n) lt.tilde n$.

  _Remark 1_. The curve $lt.tilde$ asserts that the increasing speed of LHS is less than RHS.

  _Remark 2_. For two different presentation $Gamma$ and $P$ of a same group we have $delta_Gamma minus.tilde delta_P$.
+ Hyperbolic groups are Hopfian (i.e. all surjective endomorphisms are also injective).
+ One-ended hyperbolic groups are co-Hopfian.
+ (*Two finiteness Theorem*) For a hyperbolic group:
  + There are only finitely many finite order elements;
  + There are only finitely many finite subgroups;
+ $"BS"(m, n) := chevron.l a, b | a b^m a^(-1) = b^n chevron.r$ is torsion free.

= Day 4
+ (*Tarshi*) Do non-commutative free groups share the same first order theory?
+ (*Малщев*) Is the commutator subgroup of $F_n$ definable in $F_n$?
+ (*Sela, Харломпович, Мяанаков*) The chain
  $ F_2 subset F_3 subset ... $
  is elementary.
+ (*Sela*) The theory of free groups is stable.
+ (*Gibone*) $"Th"(F_omega := union.big F_n)$ is not superstable.
+ (*Nies*) $F_2$ is homogenuous, i.e. if $"tp"^(F_2) (overline(a)) = "tp"^(F_2) (overline(b))$ then there exists $f in "Aut"(F_2)$ such that $ f(overline(a)) = overline(b). $
+ Facts about free groups:
  + They are Hopfian;
  + They are relative co-Hopfian.
+ An endomorphism $h in "End"(F_2)$ is injective iff $h([e_1, e_2]) != 1$.
  
  _Remark 1_. To prove this, one must use the Hopficity of free groups.

  _Remark 2_. This fact can be used to prove Nies's result: Suppose $overline(a) = overline(w)(e_1, e_2)$, then $ F_2 tack.r.double exists x_1, x_2 ([x_1, x_2] != 1 and overline(w)(x_1, x_2) = overline(a)), $ since $"tp"(overline(a)) = "tp"(overline(b))$, we have $ F_2 tack.r.double exists y_1, y_2 ([y_1, y_2] != 1 and overline(w)(x_1, x_2) = overline(a)). $
+ (*Sklinos*) The type $"tp"^(F_2)(e_1)$ for the free group $F_2 := chevron.l e_1, e_2 chevron.r$ is NOT isolated.
+ (*Nies, Sklinos*) $"Th(Free groups)"$ does not admit a prime model.
+ (*Problem*) $"SL"_2 (ZZ)$ is stable.
+ (*Stability*) A structure $M$ is called stable if for any formula $phi(overline(x), overline(y))$, there exists $n in NN$ such that for any $(overline(a)_i)_(i < k)$ and $(overline(b)_i)_(i < k)$, if
  $ M tack.r.double phi(overline(a)_i, overline(b)_j) "iff" i < j, $
  then $k < n$.
+ Modules are stable (Thus abelian groups are stable).
+ $(RR, +, dot, 0, 1)$ is not stable.
+ (*$lambda$-stable theory*) A first order theory is $lambda$-stable where $lambda$ is an infinite cardinal, if for any subset $A subset M tack.r.double T$, we have $|A| <= lambda$ implies $|S(A)| <= lambda$, where $S(A)$ is the stone space of $A$.
+ (*Generic types for a group*) For a stable group $G$, a definable set $X$ is generic if there exists $(g_i)_(i in NN)$ such that $union.big_(i in NN) g_i X$ covers $G$.
+ $"Th(Free groups)"$ has $2^(aleph_0)$ many countable models (Hints: $|S_1 ("Th(Free groups)")| = 2^(aleph_0)$).
+ A groups is called connected if it has no proper definable subgroups of finite index.
