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
  - _A Basic Course in Algebraic Topology_ (GTM 127), William S. Massey, Springer.
  - _A Concise Course in Algebraic Topology_, Peter May, availabe at https://www.math.uchicago.edu/~may/CONCISE/ConciseRevised.pdf.

We denote the concatenation of two path $g_12: x_1 ~~> x_2$ and $g_23: x_2 ~~> x_3$ by $g_12 dot g_23: x_1 ~~> x_2$, i.e., we apply $g_12$ *first*, then $g_23$.

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

In short: Covering space is a locally trivial bundle with discrete fiber.

This whole section can be rewritten in groupoid-theoretic language, as done in [May, Chapter 3].

== Examples and non-exmaples
Examples:
+ *The trivial bundle*: Identity $"id"_X: X -> X$ is a covering space, with fiber ${*}$.
+ *Global trivial bundle with discrete fiber*: For a discrete space $D$, the projection $X times D ->> X$ is of course a covering space, and $D$ is the fiber.
+ *Exponential*: The exponential function $"exp": RR -> S^1$ sends $theta$ to $(cos theta, sin theta)$ is a local trivial bundle with fiber $ZZ$.

Note that to be a covering map, the fiber must be _discrete_. Here is one of non-exmaples:
+ The projection $S^1 times [0, 1] ->> S^1$ is not a covering map, since the fiber $[0, 1]$ is not discrete.

== Basic Topological Properties
#theorem(title: "fiber-wise diagonal of covering space is open and closed")[
  For $p: E -> X$ a covering, the diagonal $Delta (E) := {(e, e): e in E}$ is both closed and open in $E times_X E$, the pullback of $p: E -> X$.
] <diagonal>
#proof[
  See #link("https://ncatlab.org/nlab/show/covering+space")[nLab - _Covering spaces_, Lemma 3.2].
]

This will be used to prove the result: two lifts in a covering space of a path are either same, or different everywhere.

== Produce covering spaces from group actions
In this section, $G$ is a group endowed with discrete topology and $X$ is an arbitrary space. We fix a $G$-action $alpha: G -> "Aut"_("Top")(X)$, then it induces a covering space if this action is good enough. We always write $g x$ for $alpha_g x$.

The investigations of group actions on spaces will help us to prove the correspondence between $"Sub"(pi_1 (X))$ and $"Cov"(X)$ for a good enough $X$, such as spaces which admit a universal covering space.

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

#theorem(title: "lifts out of connected space into covering spaces are unique relative to any point")[
  For a commutative diagram
  #align(center, diagram({
     node((-1, 1), [$Y$])
     node((0, 1), [$X$])
     node((0, 0), [$E$])
     edge((-1, 1), (0, 1), [$f$], label-side: right, "->")
     edge((0, 0), (0, 1), [$p$], label-side: left, "->")
     edge((-1, 1), (0, 0), [$tilde(f)_1$], label-side: center, "->", bend: -9deg)
     edge((-1, 1), (0, 0), [$tilde(f)_2$], label-side: center, shift: 0.15, "->", bend: 9deg)
  }))
  where $Y$ is connected and $p: E -> X$ a covering, either $tilde(f)_1$ and $tilde(f)_2$ are same, or different everywhere.
]
#proof[
  These two lifts $tilde(f)_1$ and $tilde(f)_2$ induces a map $angle.l tilde(f)_1, tilde(f)_2 angle.r: Y -> E times_X E$.

  Since $Delta(E)$ is clopen in $E times_X E$ (recall @diagonal), the pre-image of it under $angle.l tilde(f)_1, tilde(f)_2 angle.r$ is also clopen. But $Y$ is connected, so the pre-image is either $Y$ or empty.
]

There is another proof does not use @diagonal from [Massey, Chapter V, Lemma 3.2] (and thus we need not to prove those tedious point-set topological results):

#proof[
  For simplicity we write $tilde(f)_i$ as $f_i$.

  We prove that, $K := {y in Y: f_1 y = f_2 y}$ is clopen.
  - $K$ is closed: We prove that its closure $overline(K) = K$ itself. For $a in overline(K) - K$, i.e. $f_1 a != f_2 a$, but $p f_1 a = p f_2 a$. Now let $V_1, V_2 subset E$ be the elementary neihgbourhoods of these two point $p f_1 a$ and $p f_2 a$ resp. Since $E$ is a covering space, by definition $V_1$ and $V_2$ are disjoint.
    
    Now consider $W := f_1^(-1) V_1 inter f_2^(-1) V_2$ which is an open neihgbourhood of $a$, and $f_1 W inter f_2 W = emptyset$ by the definition of $V_1$ and $V_2$, this implies $W inter K = emptyset$, contradicts to the assumption that $a in overline(K)$.

  - $K$ is open: We prove that for any $y in K$, there exists an open neihgbourhood of $y$ which contained in $K$.

    If $y in K$, i.e. $f_1 y = f_2 y =: tilde(y)$, let $V$ be the component in $E$ contains $tilde(y)$. Now consider $W := f_1^(-1) V inter f_2^(-1) V$ which is an open neihgbourhood of $y$, we claim that $W subset K$.

    For $a in W$, $f_1 a$ and $f_2 a$ are both in $V$, an elementary neihgbourhood of $tilde(y)$ in $E$, which is homeomorphic to an open set around $p tilde(f)$. Note that both $f_1 a, f_2 a in V$ are pre-images of $p f_1 a = p f_2 a$, since $p$ restricted to $V$ is a homeomorphism, it must be injective and thus $f_1 a = f_2 a$, so $a in K$.
]

This result will be used to provide a neccessary condition of TODO: (a $G$-space $Y$ is a covering space of $Y slash G$ via the canonical projection with $"Aut"(Y) = G$)


#theorem(title: "Lifting of homotopies")[
  TODO.
]
#proof[
  TODO.
]

#theorem(title: "Lifting of arbitrary maps")[
  Let $(tilde(X), p)$ be a covering of $X$ and $tilde(x)_0 in tilde(X)$ be a pre-image of $x_0$. Suppose $Y$ is *connected and locally path-connected*. For a continuous map $phi: (Y, y_0) -> (X, x_0)$, there exists a lifting $tilde(phi): (Y, y_0) -> (tilde(X), tilde(x)_0)$ if and only if $phi_* pi_1(Y, y_0) subset p_* pi_1 (tilde(X), tilde(x)_0)$.

#align(center, diagram({
   node((-1, 1), [$(Y,y_0)$])
   node((0, 1), [$(X,x_0)$])
   node((0, 0), [$(tilde(X),tilde(x)_0)$])
   edge((-1, 1), (0, 1), [$phi$], label-side: left, "->")
   edge((0, 0), (0, 1), [$p$], label-side: right, "->")
   edge((-1, 1), (0, 0), [$exists tilde(phi)$], label-side: left, "-->")
}))
]
#proof[
  For simplicity we denote the fundamental group of a space $W$ at point $w$ as $pi (W, w)$, i.e. omit the subscript $1$.
  - If such $tilde(phi)$ exists, then since the fundamental group $pi: "Top"_* -> "Grp"$ is a functor, the following diagram also commutes:
  #align(center, diagram({
     node((-1, 1), [$pi (Y,y_0)$])
     node((0, 1), [$pi (X,x_0)$])
     node((0, 0), [$pi (tilde(X),tilde(x)_0)$])
     edge((-1, 1), (0, 1), [$phi_*$], label-side: left, "->")
     edge((0, 0), (0, 1), [$p_*$], label-side: right, "->")
     edge((-1, 1), (0, 0), [$tilde(phi)_*$], label-side: left, "-->")
  }))
  So the desired property is immediate.
  - If $phi_* pi_1(Y, y_0) subset p_* pi_1 (tilde(X), tilde(x)_0)$, we need to construct a $tilde(phi)$ such that the diagram in theorem commutes.

    Note that $Y$ is global path-connected since it is connected and locally path-connected, so there exists at least one path $g: y_0 ~~> y$ for all point $y in Y$. Then by compose $phi$ we obtain a path $phi g: x_0 ~~> x := phi g (y)$. By the lifting property of paths in $X$, we then obtain a path $tilde(phi g)$ in $tilde(X)$ with the chosen initial point $tilde(x)_0$, let $tilde(x)$ be the final point of this lifting path.

    So we start with an arbitrary point $y$ in $Y$ and end with a point $tilde(x)$ in $tilde(X)$, and we, bravely, define $tilde(phi)(y) = tilde(x)$.

    Of course we need to verify this procedure is well-defined:
      - *$tilde(x)$ is independent with the connecting path:* Suppose we have two different paths $g_1, g_2: y_0 ~~> y$, and the resulting final points by using these paths in $tilde(X)$ are $tilde(x)_1$ and $tilde(x)_2$, resp. We need to verify $tilde(x)_1 = tilde(x)_2$.

        Let $g_2^(-1): y ~~> y_0$ be the inverse path of $g_2$, then $g_1 dot g_2^(-1): y_0 ~~> y_0$ is an (representative) element in $pi (Y, y_0)$. And thus $phi_* (g_1 dot g_2^(-1)) = (phi g_1) dot (phi g_2)^(-1) in pi (X, x_0)$. By assumption, there exists a path $alpha in pi (tilde(X), tilde(x)_0)$ such that $p_* alpha = (phi g_1) dot (phi g_2)^(-1)$.

        So tired, for a complete proof see #link("https://ncatlab.org/nlab/show/covering+space")[nLab - _Coverign space_, Proposition 3.9].
      - *$tilde(phi)$ makes the diagram commutative:* Because of the lifting property of $tilde(phi g)$.
      - *$tilde(phi)$ is continuous:* TODO.
]

Wow, a bunch of theorems, arguments, we need an application!

#example(title: "Universal Covering Space")[
  If $(tilde(X), p)$ is a covering space of $X$, and $tilde(X)$ is connected, *path-connected and simply-connected*; then it is unique up to isomorphisms.

  Furthur, $tilde(X)$ is the initial object in the category $"Cov"(X)$, which consists of coverings of $X$.
]

#proof[
  For the first part, note that for two such coverings $(tilde(X)_1, p_1)$ and $(tilde(X)_2, p_2)$. Choose $tilde(x)_i in p_i^(-1)(x_0)$, and by the lifting theorem we can lift $p_1$ to an *unique* $tilde(p)_1: (tilde(X)_1, tilde(x)_1) -> (tilde(X)_2, tilde(x)_2)$ since $pi (tilde(X)_1)$ is trivial. By the same argument we obtain $tilde(p)_2: (tilde(X)_2, tilde(x)_2) -> (tilde(X)_1, tilde(x)_1)$. Now consider $tilde(p_1) compose tilde(p)_2: (tilde(X)_2, tilde(x)_2) -> (tilde(X)_2, tilde(x)_2)$, which must be the identity on $(tilde(X)_2, tilde(x)_2)$ since the both this map and the identity map are liftings of $p_2$, and by the lifting theorem, such lifting is *unique*, so the result is immediate. (See also #link("https://ncatlab.org/nlab/show/universal+covering+space")[nLab - _Universal covering space_, Proposition 1.1]).
]

== Covering spaces from group actions
If a group $G$ acts well on a good space, then we obtain a covering map for free, in detail:

#theorem(title: "Covering space from group action")[
  Let $Y$ be a connected, locally path-connected space and let $G$ be a *properly discontinuous* group of homeomorphisms of $Y$, then the projection $p: Y -> Y slash G$ is a regular covering with the deck group $"Deck"(p) := "Aut"(Y, p) = G$.
]

When $Y$ is simply-connected, it is further the universal covering of $Y slash G$, thus we know the fundamental group of $Y slash G$, as $pi_1(Y slash G) = "Deck"(p) = G$.

We can use this theorem to compute fundamental groups of some good spaces.

+ *The fundamental group of $RR P^n$*: We claim
$ pi_1(RR P^n) := cases(
  ZZ "   if" n = 1,
  ZZ slash 2 "if otherwise".
) $
#proof[
  The case of $n = 1$ is left as an excersice.

  When $n >= 2$, consider the antipodal map $T: S^n -> S^n$, which is continuous and nilpotent, i.e. $T^2 = "id"$. Note that ${T, T^2}$ is a group consists of discontinuous homeomorphisms of $S^2$, and $S^n$ is a good space, the theorem tell us $p: S^n -> S^n slash {T, T^2}$ is a covering map with deck group $"Deck"(p) = {T, T^2}$.
]


= Basic notions in Singular Homology
For motivations, see []

== Excision Lemma
The excision lemma is a powerful tool for computing homology groups.

#theorem(title: "Homology is invariant under excision")[
  For a space $X$, the homology group is invariant under tame excision, formally, if $A subset X$ is a subspace and $W subset A$, then
  $ H_n (X, A) tilde.eq H_n (X - W, A - W), $
  provided that $W$ is "totally" contained in $A$, to be precise, $"cl"_X (W) subset "int"_X (A).$
]

We can use this theorem to compute $H_n (S^k)$. (TODO: digest the computation in [Massey])

To prove this result, we need a construction called "subdivision", which is used to restrict our attention of singular cubes to a "smaller" ones without losing any information.

For example, if we are working in a metric space, then subdivision enables us to just consider cubes with diameter less than a given positive number, and the homology groups of those small cubes are isomorphic to the homology groups of all cubes.

To formalize what is "small" in an arbitrary topological space, we need the following definition:

#definition(title: "Small cube")[
  Let $cal(U) := {U_lambda}$ be a family of subsets in $X$ such that ${"int"_X (U_lambda)}$ covers $X$.

  A singular $n$-cube $T: I^n -> X$ is said to be small of order $cal(U)$ if there exists an index $lambda$ such that $"im" T subset U_lambda$.
]

#example(title: "Trivial small cube")[
  The trivial $n$-cube $T$ which sends all things to a single point is small of any order.
]

= (Co)fibration
TODO: Check the proofs in [May].

Cofibrations are good inclusions, in the sense that if $i: A arrow.r.hook X$ is a cofibration and $A$ is contractible, then the quotient map $q: X -> X slash A$ is a homotopy equivalence. (TODO: counter-examples when $i$ is not a cofibration)

With this property, we can show that all subgroups of a free group is free again: the main part using cofibration is that, for a maximal tree $T$ of a finite connected plane graph $X$, the inclusion $i: T arrow.r.hook X$ is a cofibration. And note that $T$ is contractible, $X$ and $X slash A$ (a wedge product of circles) share the smae homotopy type, so the fundamental group of any finite connected plane graph is free.

#definition(title: "Cofibration")[
  A map $i: A -> X$ is called a cofibration if it admits the *homotopy extension property* (HEP): for any homotopy $h: A times I -> Y$ makes the upper triangle commutes, it admits an extension $tilde(h): X times I -> Y$, in diagram:
#align(center, diagram({
   node((0, 0), [$A$])
   node((0, 2), [$X$])
   node((2, 0), [$A times I$])
   node((1, 1), [$Y$])
   node((2, 2), [$X times I$])
   edge((0, 0), (0, 2), [$i$], label-side: right, "->")
   edge((0, 0), (2, 0), [$"inl"_0$], label-side: left, "->")
   edge((2, 0), (1, 1), [$h$], label-side: center, "->")
   edge((0, 2), (1, 1), [$f$], label-side: center, "->")
   edge((0, 2), (2, 2), [$"inl"_0$], label-side: right, "->")
   edge((2, 0), (2, 2), [$i times "id"_I$], label-side: left, "->")
   edge((2, 2), (1, 1), [$exists tilde(h)$], label-side: center, "-->")
}))
]

#warning-box[In the definition we do not require $tilde(h)$ to be unique! (And it usually isn't)]

There is an universal test for a map to be a cofibration: the mapping cylinder.

#definition(title: "Mapping Cylinder")[
  For a map $f: X -> Y$ between spaces, we define the mapping cylinder $M f$ of $f$ to be the pushout:
#align(center, diagram({
   node((0, 0), [$A$])
   node((0, 1), [$X$])
   node((1, 0), [$A times I$])
   node((1, 1), [$M f:= X product.co _f (A times I)$])
   edge((0, 0), (0, 1), [$f$], label-side: right, "->")
   edge((0, 1), (1, 1), "->")
   edge((1, 0), (1, 1), "->")
   edge((0, 0), (1, 0), "->")
}))

The category of compactly generated spaces admits pushout so it is well defined.
]

#proposition(title: "Mapping cylinder as universal test")[
  A map $i: A -> X$ is a cofibration if and only if HEP is true for $M i$.
]
#proof[
  One direction is obvious. The other direction can be proved by the universal property of pushout.
]

#proposition(title: "Cofibrations are injective with closed image")[
  As the name suggests.
]
#proof[
  - For injectivity, use the universal property of $M i$, and note that the inclusions into pushout are always injective.
  - For the rest part, TODO.
]


Any map can be decomposed into a cofibration and a homotopy equivalence through its mapping cylinder.

#theorem(title: "Replacing maps by cofibrations")[
  For any map $f: X -> Y$, it admits a decomposition $f = r compose (iota compose "inl"_0)$:
#align(center, diagram({
   node((0, 0), [$X$])
   node((0, 1), [$Y$])
   node((1, 0), [$X times I$])
   node((1, 1), [$M f$])
   node((2, 2), [$Y$])
   edge((0, 0), (0, 1), [$f$], label-side: right, "->")
   edge((0, 0), (1, 0), [$"inl"_0$], label-side: left, "->")
   edge((1, 0), (1, 1), [$iota$], label-side: right, "hook->")
   edge((0, 1), (1, 1), [$i$], label-side: left, "hook->")
   edge((0, 1), (2, 2), "=", bend: -54deg)
   edge((1, 0), (2, 2), [$(x, -) mapsto f(x)$], label-side: left, "->", bend: 54deg)
   edge((1, 1), (2, 2), [$exists ! r$], label-side: center, "-->")
}))

And $r$ is a homotopy equivalence, $(iota compose "inl"_0)$ is a cofibration.
]
#proof[
  TODO

  May claim that it is not hard to directly show that $(iota compose "inl"_0)$ is a cofibration, but there seems to be a more systematic way: the criteria of a map to be a cofibration.
]

#theorem(title: "Criteria of cofibration")[
  For a *closed* subspace $i: A arrow.r.hook X$, the following are equivalent:
  + $(X, A)$ is an NDR-pair;
  + $(X times I, X times {0} union A times I)$ is a DR-pair;
  + $X times {0} union A times I$ is a retract of $X times I$;
  + The inclusion $i: A arrow.r.hook X$ is a cofibration.
]
#proof[
  TODO
]


