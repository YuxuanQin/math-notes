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
  Notes on Algebraic Topology
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


I plan to learn algebraic topology with #link("https://loeh.app.uni-regensburg.de/teaching/topologie1_ws2122/lecture_notes.pdf")[Prof. Löh's notes], some other references:
  - A Basic Course in Algebraic Topology (GTM 127), William S. Massey, Springer.
  - A concise course in Algebraic Topology, Peter May.

= Basic Definitions
== Relative Homotopy
Two morphisms $f$ and $g$ from topology space $X$ to $Y$ is called _homotopic relative to $A$_ for $A subset X$, denoted as $f tilde.eq g "rel" A$, if there exists a morphism $h: X times I -> Y$ such that
  - $h(x, 0) = f(x)$ for all $x in X$;
  - $h(x, 1) = g(x)$ for all $x in X$;
  - $h(a, t) = f(a) = g(a)$ for all $a in A$, $t in I$.

_Remark_. So the classical homotopic relation between two paths with same end points is exactly the relative homotopy when $A = {"initial point", "final point"}$.

== Retract and Deformation Retract
- A subspace $i: A arrow.r.hook X$ is called a _retract_ of $X$ if $i$ admits a left inverse $r: X ->> A$, i.e. $r compose i = "id"_A$;
- It is called a _deformation retract_ of $X$ if $i compose r tilde.eq "id"_X "rel" A$.

_Remark_. Note that $r compose i = "id"_A$ is equivalent to $r compose i tilde.eq "id"_A "rel" A$ -- so the condition of deformation retract is rather natural -- indeed:
  - If $r compose i = "id"_A$, then define the homotopy $h(x, t) = r compose i (x) = "id"_A (x) = x$, which is of course continuous in both $x$ and $t$;
  - If $r compose i tilde.eq "id"_A "rel" A$, then by definition there exists a homotopy $h: A times I -> A$ such that $h(a, t) = r compose i (a) = "id"_A (a)$, implies that $r compose i = "id"_A$.

The main importance of deformation retract is embodied in the following theorem:

#theorem(title: "A deformation retract shares the same fundamental group of the ambinent sapce")[
  For a deformation retract $i: A arrow.r.hook X$, we have $pi_1(A, a) = pi_1(X, a)$ for all $a in A$.
]
#proof[
  Suppose the relative homotopy is witness by $h$.

  Then by the proposition in Section 4, Chapter 1 of [May], we need only to prove that $gamma [h(a, -)] = "id"$, but by the definition of relative homotopy, $h(a, -) == a$ so the equation is tautology.
]
#remark[
  We can prove it directly, first we need a lemma: if $f, g: X -> Y$ is relative homotopic respect to $x_0 in X$, i.e. there exists a homotopy $h: f tilde.eq g "rel" {x_0}$, we claim that $f_* = g_*: pi_1(X, x_0) -> pi_1(Y, y_0)$ where $y_0 := f(x_0) = g(x_0)$.

  By this lemma, and note that $i compose r tilde.eq "id"_A "rel" {a}$, we have $(i compose r)_* = i_* compose r_* = ("id"_A)_*$. Furthur since $A$ is a retract, $r compose i = "id"$ and thus $r_* compose i_* = "id"$. So we finish the proof of the theorem.

  For the lemma, suppose $[p] in pi_1(X, x_0)$ is a path, we prove that $f compose p tilde.eq g compose p$: the homotopy $hat(h): I times I -> Y$ is given by

#align(center)[
#diagram({
   node((0, 0), [$I times I$])
   node((0, 1), [$X times I$])
   node((1, 1), [$Y$])
   edge((0, 0), (0, 1), [$p times "id"$], label-side: right, "->")
   edge((0, 1), (1, 1), [$h$], label-side: right, "->")
   edge((0, 0), (1, 1), [$hat(h)$], label-side: left, "-->")
}).
]
  Note that $hat(h)(s, t) = h(p(s), t)$ is indeed a homotopy between $f$ and $g$. We are finished.
]

This can be used to compute the fundamental group $pi_1(RR^n, x_0)$ for all $x_0 in RR^n$: we claim that ${x_0}$ is a deformation retract of $RR^n$, and one of the required homotopies is given by $h: RR^n times I -> RR^n$ which sends $(x, t)$ to $t x + (1 - t) x_0$.

So $pi_1(RR^n, x_0) = pi_1({x_0}, x_0) = {*}$.

= Covering Space
There are (at least) two definitions of covering spaces over a given base topological space $X$:
  - *The "new" fashion*: A covering space over $X$ is a morphism $p: E -> X$ such that: for all $x in X$, there exists an open neihgbourhood $x in U_x$ such that $p^-1(U_x) tilde.equiv U_x times p^-1(x)$.
  - *The "old" fashion*: A covering space over $X$ is a morphism $p: E -> X$ such that: for all $x in X$, there exists an _path-connected_ open neihgbourhood $U_x$ such that each path-connected component of $p^(-1)(U_x)$ is homeomorphic to $U_x$ via $p$.

The new fashion can be found in [Wedhorn], [Löh], and #link("https://ncatlab.org/nlab/show/covering+space")[_covering space_ on nLab]; while the old one can be found in [Massey] and [May].

#remark[
  The old fashion definition is in fact not consistent:
    - [Massey] requires that both covering spaces and base spaces are _path-connected_ and _locally path-connected_.
    - [May] requires nothing.
]

TODO: Verify that nLab's definition of covering space coinsides with May's: the number of path-connected components of $p^(-1)(U_x)$ equals to $|p^(-1)(x)|$

In short: Covering space is a discrete bundle.


== Lebesgue in Algebraic Topology
Yes, Lebesgue and algebraic topology. We should thanks to him for the following useful lemma:

#theorem(title: "Lebesgue number")[
  For an open covering ${U_i}$ of a _compact metric space_ $X$, there exists $delta > 0$, which is called a Lebesgue number, such that for all $x in X$ the open ball centered $x$ with radius $delta$ is fully contained in one of those open sets, formally: $B(x, delta) subset U_i$ for some $U_i$.
]
#proof[
  Suppose not, that is, for all $n$, there exists $x_n$ such that $B(x_n, 1/n)$ does not fully contained any $U_i$.

  Since $X$ is compact, ${x_n}$ has a coverage subsequence ${y_n}$ tends to $y_0$. Let $epsilon_n$ the associated radius of $y_n$. Since ${U_i}$ is an open cover of $X$, there exists $epsilon_0 > 0$ and $N$ such that $B(y_0, epsilon) subset U_i$ for some $i$, and for all $m > N$ we have $y_m in B(y_0, epsilon_0 / 2)$.

  Now make $m$ so large that $epsilon_m < epsilon_0 / 2$ and $m > N$, so $B(y_m, epsilon_m) subset B(y_0, epsilon_0) subset U_i$, contradiction to our assumption!
]

