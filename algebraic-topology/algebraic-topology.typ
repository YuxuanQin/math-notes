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

  Then by the proposition in Section 4, Chapter 1 of [May], we need only to prove that $gamma [h(a, -)] = "id"$, but by the definition of relative homotopy, $h(a, -) equiv a$ so the equation is tautology.
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
  - *The "new" fashion*: A covering space over $X$ is a morphism $p: E -> X$ such that: for all $x in X$, there exists an open neihgbourhood $x in U_x$ such that $p^(-1)(U_x) tilde.equiv U_x times p^(-1)(x)$, where $p^(-1)(x)$ equipped with discrete topology.
  - *The "old" fashion*: A covering space over $X$ is a morphism $p: E -> X$ such that: for all $x in X$, there exists an _path-connected_ open neihgbourhood $U_x$ such that each path-connected component of $p^(-1)(U_x)$ is homeomorphic to $U_x$ via $p$.

The new fashion can be found in [Wedhorn], [Löh], and #link("https://ncatlab.org/nlab/show/covering+space")[_covering space_ on nLab]; while the old one can be found in [Massey] and [May].

#remark[
  The old fashion definition is in fact not consistent:
    - [Massey] requires that both covering spaces and base spaces are _path-connected_ and _locally path-connected_.
    - [May] requires nothing.
]

TODO: Verify that nLab's definition of covering space coinsides with May's: the number of path-connected components of $p^(-1)(U_x)$ equals to $|p^(-1)(x)|$

In short: Covering space is a locally trivial bundle with discrete fiber.


== Examples and non-exmaples
Examples:
+ *The trivial bundle*: Identity $"id"_X: X -> X$ is a covering space, with fiber ${*}$.
+ *Global trivial bundle with discrete fiber*: For a discrete space $D$, the projection $X times D ->> X$ is of course a covering space, and $D$ is the fiber.
+ *Exponential*: The exponential function $"exp": RR -> S^1$ sends $theta$ to $(cos theta, sin theta)$ is a local trivial bundle with fiber $ZZ$.

Note that to be a covering map, the fiber must be _discrete_. Here is one of non-exmaples:
+ The projection $S^1 times [0, 1] ->> S^1$ is not a covering map, since the fiber $[0, 1]$ is not discrete.


== Produce covering spaces from group actions
In this section, $G$ is a group endowed with discrete topology and $X$ is an arbitrary space. We fix a $G$-action on space $X$: $alpha: G -> "Aut"_("Top")(X)$, then it induces a covering space if this action is good enough. We always write $g x$ for $alpha_g x$.

Denote the orbit of $x in X$ as $G x := {g x : g in G}$.

Firstly we need some definitions:

#definition(title: "Orbit space")[
  The orbit space $G\X$ of $X$ related to the action $alpha$ is defined as: $ G\X := {G x : x in X}. $

  We endow this set with quotient topology induced from the projection $X ->> G\X$.
]




== Lebesgue number
Yes, Lebesgue and algebraic topology. We should say "thank you" to him for the following useful lemma:

#theorem(title: "Lebesgue number")[
  For an open covering ${U_i}$ of a _compact metric space_ $X$, there exists $delta > 0$, which is called a Lebesgue number, such that for all $x in X$ the open ball centered $x$ with radius $delta$ is fully contained in one of those open sets, formally: $B(x, delta) subset U_i$ for some $U_i$.
]
#proof[
  Suppose not, that is, for all $n$, there exists $x_n$ such that $B(x_n, 1/n)$ does not fully contained any $U_i$.

  Since $X$ is compact, ${x_n}$ has a covergence subsequence ${y_n}$ tends to $y_0$. Let $epsilon_n$ the associated radius of $y_n$. Since ${U_i}$ is an open cover of $X$, there exists $epsilon_0 > 0$ and $N$ such that $B(y_0, epsilon) subset U_i$ for some $i$, and for all $m > N$ we have $y_m in B(y_0, epsilon_0 / 2)$.

  Now make $m$ so large that $epsilon_m < epsilon_0 / 2$ and $m > N$, so $B(y_m, epsilon_m) subset B(y_0, epsilon_0) subset U_i$, contradiction to our assumption!
]
#remark[
  We need $X$ to be compact, otherwise there may be no such $delta$, for example: ${B(r, r/2)}_(r in (0, 1))$ covers $(0, 1)$.

  Compactness ensures the existence of covergence subsequence of a infinite sequence: suppose ${x_n}$ does not admit a covergence subsequence, then for all $x in X$, there exists a open neihgbourhood $U_x$ of $x$ that only contains finitely many $x_n$. Now note that ${U_x}$ is an open cover of a compact space so it admits a finite subcover ${V_x}$, and their union only contains finitely many $x_n$.

  Since ${V_x}$ covers $X$, we know that there are only finitely many distinct points in ${x_n}$, which implies this sequence itself must coverage, contradiction!
]

This theorem is especially useful and when we want to prove something about covering spaces, it serves as a bridge from the trivial covering to general situations. We will see such examples in the next section, where we concern lifting properties.

== Lifting Properties


#theorem(title: "Lifting of paths")[
  For a given covering space $p: hat(X) ->> X$ and a path $f: I -> X$ with the initial point $x_0 := f(0)$, then for any $hat(x_0) in hat(X)$ such that $p(hat(x_0)) = x_0$, there exists an unique path $hat(f): I -> E$ with initial point $hat(x_0)$ such that $p compose hat(f) = f$.

  In diagram:
#align(center, diagram({
   node((0, 0), [${0}$])
   node((0, 1), [$[0, 1]$])
   node((1, 0), [$hat(X)$])
   node((1, 1), [$X$])
   edge((0, 0), (0, 1), "hook->")
   edge((0, 0), (1, 0), [$hat(x_0)$], label-side: left, "hook->")
   edge((0, 1), (1, 1), [$f$], label-side: right, "->")
   edge((1, 0), (1, 1), [$p$], label-side: left, "->>")
})) induces an unique $hat(f)$ such that 

#align(center, diagram({
   node((0, 0), [${0}$])
   node((0, 1), [$[0, 1]$])
   node((1, 0), [$hat(X)$])
   node((1, 1), [$X$])
   edge((0, 0), (0, 1), "hook->")
   edge((0, 0), (1, 0), [$hat(x_0)$], label-side: left, "hook->")
   edge((0, 1), (1, 1), [$f$], label-side: right, "->")
   edge((1, 0), (1, 1), [$p$], label-side: left, "->>")
   edge((0, 1), (1, 0), [$exists! hat(f)$], label-side: center, "->")
})) commutes.
]
#proof[
The main idea is that we first prove the case $hat(X)$ is _global trivial_, and then proceed to the general case.

- *Trivial Case*: Suppose $hat(X) tilde.equiv X times D$ for a discrete space $D$.
  - Existence: We define $hat(f)(t) := (f(t), d_0)$, where $d_0 = "pr"_2(hat(x_0))$. It is continuous and indeed a lifting.
  - Uniqueness: For another lift $tilde(f): [0, 1] -> hat(X)$, since the diagram commutes, we have $tilde(f)(t) = (f(t), d(t))$ and $d(0) = d_0$.
    
    A continuous image of a path-connected space is again path-connected, so $tilde(f)(I)$ is path-connected and we claim that $d(t) equiv d_0$. Otherwise, because all discrete spaces are not path-connected, $(tilde(f)(t_1), d(t_1))$ can not be connected to $(tilde(f)(t_2), d(t_2))$ by path since $D$ is discrete.

- *General Case*: Thanks to the local triviality of a covering space, for each $x in X$ there exists a open neihgbourhood $U_x$ such that $p^(-1)(U_x) tilde.equiv U_x times D$ a trivial covering of $U_x$, where $D := p^(-1)(x)$ is equipped with discrete topology.
  
  Now we need only to divide $f$ into pieces of sub-paths ${f_i}$ that each of them is fully contained in some trivial open neihgbourhoods. Then use the result from the trivial case we obtain sub-liftings ${hat(f_i)}$, and finally glueing them!

  Since $[0, 1]$ is compact and ${f^(-1)(U_x)}_(x in X)$ is an open cover of it, we obtain a finite subcover ${f^(-1)(V_x)}$, now we let $1/n$ be a Lebesgue number of this cover where $n$ is a integer, and divide $[0, 1]$ into ${[0, 1/n], [1/n, 2/n], ..., [1 - 1/n, 1]}$. Let $f_k: [(k - 1)/n, k/n] -> X$ be the restriction of $f$. By the definition of $n$, image of each $f_k$ is contained in a trivial open neihgbourhood $U_k$, and thus the problem for each $f_k$ reduces into the global trivial case, finally we obtain the sub-liftings ${hat(f_i)}$ with the given initial point of $hat(f_(k+1))$ defined to be the final point of $hat(f_k)$.

  Now glued them, we obtain the lifting $hat(f)$.

  For the uniqueness, if there are two such liftings, restrict them to $[(k - 1)/n, k/n]$ and by the uniqueness of trivial case, these two restriction are same. Thus the two liftings are same.

]
