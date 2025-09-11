////////////////////////////////////////////////////////////////////
///////////////////////////  Settings  ////////////////////////////
////////////////////////////////////////////////////////////////////
#import "@preview/fletcher:0.5.3" as fletcher: diagram, node, edge  // Commutative diagram

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

// Set numbering
#set heading(numbering: "1.")

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

I must admit that I almost know nothing about serious geometric group theory and large-scale geometry, and this note should not be used as a study matetial. I just written the things interested me down.


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
  - _Remark:_ For group $G = angle.l S | R angle.r$ finitely generated, we can define the length for any element $g in G$ as $|g|_G := min_(g = h) |h|_"Cayley"$.

+ (*Hyperbolic Group*) A group is called hyperbolic if its Cayley graph is hyperbolic as a metric spacce.
  - _Remark:_ This is just one of the many definitions of hyperbolic groups.

+ Some facts:
  - $"Cay"(G, A)$ for $A$ a generating set of $G$, is a proper space with all geodesics.
  - $G$ acts on $"Cay"(G, A)$ by sendind $(r, g)$ to $r dot g$, which is an isometry, i.e. $d(r g, r h) = d(g , h)$.
  - The above action is properly-discontinuous, i.e., for compact $X subset "Cay"(G, A)$, the set ${g: g X inter X != emptyset}$ is finite.
  - The action is co-compact, i.e., $"Cay"(G, A) \/ G$ is compact.
  
+ (*Svarč-Milnar Theorem*) See Löh's book.

