////////////////////////////////////////////////////////////////////
///////////////////////////  Settings  ////////////////////////////
////////////////////////////////////////////////////////////////////
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge  // Commutative diagram

#import "@preview/theorion:0.4.1": *  // Theorem environment
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
#let colim = $"colim"$


////////////////////////////////////////////////////////////////////
////////////////////////////  Title  ///////////////////////////////
////////////////////////////////////////////////////////////////////
// Title
#align(center, text(17pt)[
  Notes on Codensity, locally presentable category and Compactness
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

#outline()

= Locally presentable category
_Ref_. #link("https://ncatlab.org/nlab/show/locally+presentable+categories+-+introduction")[_Locally presentable categories -- introduction_ (nLab)].

== Filtered category

*Filtered category is the categorification of the concept of directed set*: in a directed set $D$, there must be a mutual upper bound $m$ for every pair of elements $a$ and $b$, i.e. $a <= m$ and $b <= m$. In the common categorification of posets, this means there exists morphisms $a -> m$ and $b -> m$.

But objects are not the only inhabitants in a category -- A good categorification must do something to morphisms. So we further require that there must be a mutual upper bound of every pair of morphisms. Combine these two requirements we obtain the definition of filtered category.
#definition(title: [Filtered category])[
  A category is called filtered if every *finite* diagram has a cocone.
]

#example[
- Every category with a final object;
- Every finitely cocomplete category.
- The natural numbers $(NN, <=)$;
]

We can extend this definition: what if we require every diagram with cardinality smaller than a given cardinal $lambda$ has a cocone? (Note that $lambda = omega := |NN|$ in the definition of filtered category)

To do so we must introduce regular cardinals.

*References*: #link("https://ncatlab.org/nlab/show/filtered+category")[_Filtered category_ (nLab)]
== Regular cardinals
A regular cardinal is a cardinal *closed under union*.

#definition(title: "Regular cardinal")[
The cardinality $κ = |S|$ of a set $S$ is regular if every disjoint union of sets of cardinality smaller than $κ$ and indexed by a set of cardinality smaller than $κ$ is itself of cardinality smaller than $κ$.
]

#example[
- The smallest regular cardinal is $omega$;
- Assumeing the Axiom of Choice, the successor of any infinite cardinal us regular;
]

The concept of regular cardinal is used in the definition of $lambda$-filtered category, $lambda$-accessible catgeory and so on in category theory.

Then notions make sense for all cardinals, not necessarily regular. However, the relevant concepts reduce to those for regular cardinals: If $λ$ is not a regular cardinal, then a category has $λ$-filtered colimits if and only if it has $λ^+$-filtered colimits, and $lambda^+$ is always a regular cardinal (assuming the axiom of choice). In this case, a category is locally $λ$-presentable if and only if it is locally $λ^+$-presentable. (See nLab for references)



== $kappa$-filtered category, $kappa$-filtered colimit and $kappa$-compact object
#definition(title: [$kappa$-filtered category])[
   For $κ$ a regular cardinal, a $κ$-filtered category is one where every diagram of size $<κ$ has a cocone.
]

#definition(title: [$kappa$-filtered colimit])[
   A $kappa$-filtered colimit is a colimit over a $kappa$-filtered diagram.
]

A crucial charactering property of $kappa$-filtered colimit is the following:

#proposition[
   A colimit in $mset$ is $κ$-filtered precisely if it commutes with all $κ$-small limits.
]
#remark[
   When $kappa = omega$, this is the well known result for filtered colimits in $mset$: filtered colimits commutes with finite limits.
]

#definition(title: [$kappa$-compact object])[
   An object $A$ in a catgeory $cal(C)$ is a $kappa$-compact object if the co-yoneda embedding of $A$ commutes with $kappa$-filtered colimits:
   $ colim_D cal(C)(A, X) iso cal(C)(A, colim_D X), $
   where $X: D -> cal(C)$ is a $kappa$-filtered diagram.

  We say $A$ is *small* if it is $kappa$-compact for some regular cardinal $kappa$.
]

== Locally presentable catgeory
A catgeory is locally presentable if all objects can be presented \/ generated by a buch of small objects.

#definition(title: "Locally presentable catgeory")[
  A _locally small category_ $cal(C)$ is locally presentable if:
  - It admits all small colimits;
  - There is a small set $S$ of small objects generated $cal(C)$, i.e. every object in $cal(C)$ is a colimit of objects in $S$.
]

There are many exmaples of such categories (see nLab for more):

*References*:
- #link("https://ncatlab.org/nlab/show/locally+presentable+category")[_Locally presentable category_ (nLab)].
- #link("https://mattecapu.github.io/ct-zulip-archive/stream/229199-learning.3A-questions/topic/motivation.20for.20accessible.20categories.html#266217215")[_motivation for accessible categories_ on Category Theory Zulip server].

