////////////////////////////////////////////////////////////////////
///////////////////////////  Settings  ////////////////////////////
////////////////////////////////////////////////////////////////////
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge  // Commutative diagram

#import "@preview/theorion:0.4.1": *  // Theorem environment
#import cosmos.fancy: *
//#import cosmos.rainbow: *
//#import cosmos.clouds: *
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

// Self Defined Symbols
#let iso = symbol("≅")
#let hp = symbol("≃")
#let mset = $bold("Set")$
#let sset = $bold("sSet")$
#let mgrp = $bold("Grp")$
#let mtop = $bold("Top")$
#let simp = $"Simp"$
#let sing = $"Sing"$
#let inj  = $arrow.hook.r$
#let ch   = $"Ch"$


////////////////////////////////////////////////////////////////////
////////////////////////////  Title  ///////////////////////////////
////////////////////////////////////////////////////////////////////
// Title
#align(center, text(17pt)[
  Notes on Differential Geometry
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

= References
Robbin & Salamon - #link("https://people.math.ethz.ch/~salamon/PREPRINTS/diffgeo.pdf")[_Introduction to Differential Geometry_]

= Notes on Chpater 2: _Foundations_
== Notes on _Vector Fields and Flows_
#important-box[
  In this section we assume: 
    - $M$ is an $n$-manifold;
    - $X: M -> T M$ is a vector field.
]

#definition(title: "Vector filed")[
  Vector fields are just smooth global sections of the tangent bundle $T M$ for a smooth manifold $M$.
]

#definition(title: "Integral curve of a vector field")[
  An integral curve of a vector field $X: M -> T M$ is a continuously differentiable function $gamma: I -> M$ where $I subset RR$ is an open interval, such that
  $ dot(gamma)(t) = X(gamma(t)) in T_(gamma(t))M iso RR^n $
  for all $t in I$.
]
#remark[
  From the attached condition of $gamma$, we can see it is actually smooth.
]

#theorem(title: "Integral curves exist and \"unique\"")[
  Given vector field $X: M -> T M$ and a point $p_0 in M$, we have:
    + There exists an integral curve $gamma: I -> M$ of $X$, and further satisfies the initial point condition: $0 in I$ and $gamma(0) = p_0$
    + For any two integral curves $(gamma_1, I_1)$ and $(gamma_2, I_2)$ of $X$ both preserve the initial point, i.e. send $0$ to $p_0$, they coincide on the intersection of domain:
      $ gamma_1 = gamma_2 "on" I_1 inter I_2. $
]<icexist>
#proof[
  + One can use the existence theorem of ordinary differential equations on $RR^n$.
  + This oen is more subtle, first from the local uniqueness theorem of ODE we know the the kernel is open:
    $ ker(gamma_1, gamma_2) = {t in I: gamma_1(t) = gamma_2(t)}, $
    and then one proves the kernel is clopen, so it must be the whole intersection.
]
#remark[
  According to the second part of @icexist, we can glue two different integral curves both preserve the initial point, and they are perfectly compatible.
]

With the above remark in mind, the following definition is natural:
#definition(title: "Maximal existence interval of a initial point")[
  For a given initial point $p_0$ in $M$, the *maximal existence interval* $I(p_0)$ related to $p_0$ of a vector filed $X$ is defined as:
    $ I(p_0) := union.big {I: "there is a integral curve with" I "as domain and preserve initial point"} $
]

We glue all the integral curves and obtain an unique "maximal" curve $gamma_(p_0): I(p_0) -> M$. With this huge curve in hand we define the flow of a vector field:

#definition(title: "Flow of a vector field")[
  A flow is literally athe trace of a point.

  The flow of $X$ is the map $phi: cal(D) -> M$ where
    $ cal(D) := product.co_(p in M) I(p), $
  and $phi (p, t) := gamma_p (t)$.
]

Note that $cal(D) subset M times RR$ is a subset of a manifold, so one may interested in the smoothness properties of $phi$.

#remark[
  The flow is actually the induced map from the following diagram:
    #align(center, diagram({
       node((-1, 0), [$I(p)$])
       node((0, 1), [$M$])
       node((1, 0), [$I(q)$])
       edge((-1, 0), (0, 1), [$gamma_p$], label-side: right, "->")
       edge((1, 0), (0, 1), [$gamma_q$], label-side: left, "->")
       edge((-1, 0), (1, 0), [$dot dot dot$], label-side: center, " ")
    }))
]

Do you remember there is also a concept named "flow" in dynamic system that satisfies the following condition?
$ phi^t compose phi^s = phi^(t s). $
This condition does not come from void, and in the following theorem we can find the "flow" defined here also satisfies this condition!

#theorem(title: "Flows are indeed flows")[
  Let $phi: cal(D) -> M$ is the flow of the vector filed $X: M -> T M$, then:
  + $cal(D) subset M times RR$ is open;
  + $phi$ is smooth.
  + For every $s, t in RR$ with $s + t in I(p_0)$, we have:
      $ phi(t + s) = phi(t, phi(s, p_0)). $
]
#proof[
  TODO
]
#remark[
  The third part of this theorem means, if we denote $phi(t, -)$ by $phi^t (-)$:
    $ phi^(t + s) = phi^t compose phi^s. $
  So flows indeed share some same properties with "flows" defined in dynamic system!
]

But to fully justify the shared name we must try to extend $I(p_0)$ to the whole line $RR$, and at the same time ensure the homomorphism-like property remains, since in dynamic system, flows are defined for all reals.

To do so, we cheat: restrict attention on a special kind of vector field that just enforce the associated flow to be defined everywhere!
