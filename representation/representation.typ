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
  Notes on Representation Theory
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

This is the note on representation theory.

Main references:

+ #link("https://arxiv.org/pdf/0901.0827")[_Introduction to representation theory_ (arXiv 0901.0827)], Pavel Etingof, Oleg Golberg, Sebastian Hensel, Tiankai Liu, Alex Schwendner, Dmitry Vaintrob, and Elena Yudovina. Accessed at 2025-10-22.

Abberiviations, default settings, terminologies:
- Intertwining maps: morphisms between representations (see #link("https://www.math.nagoya-u.ac.jp/~larsh/teaching/S2021_A/lecture_1.pdf")[Larsh's Note, Definition 3]);
- ACF: Algebraic Closed Field;
- $FF$: an arbitrary field;
- $k$: an algebraic closed field;
- $A$: an algebra over an algebraic closed field $k$;


= Basic notions of representation theory

#definition(title: "Irreducible and indecomposable representation")[
  A *nonzero* representation $V$ of algebra $A$ is called:
  - *Irreducible* if the only sub-representations are $0$ and $V$;
  - *Indecomposable* if it is not isomorphic to a direct sum of two *nonzero* representations.
]

#theorem(title: "Schur's Lemma")[
  Let $V_1, V_2$ be representations of an algebra $A$ over an arbitrary field $FF$, and let $phi: V_1 -> V_2$ be a nontrivial morphism between reps. Then:
  - If $V_1$ is irreducible, $phi$ is injective;
  - If $V_2$ is irreducible, $phi$ is surjective.
]<Schur>
#proof[
  Since both $ker phi$ and $im phi$ are sub-representations of $V_1$ and $V_2$, resp.
]
#remark[
  If both $V_1$ and $V_2$ are irreducible, then $phi$ must be an isomorphism, or trivial.
]

#corollary(title: "Schur's Lemma for algebras over a ACF")[
  If we further assume $FF = k$ is an ACF and $V$ is finite dimensional in @Schur, then we have this result:

  For any endomorphism of an irreducible *finite dimensional* representation over an ACF $phi: V -> V$, we claim that $phi = lambda dot "id"$ for some $lambda in k$, i.e. $phi$ is a scalar operator.
]<SchurACF>
#proof[
  Thanks to your linear algebra course, we know that any endomorphism $phi: V -> V$ of a _finite dimensional_ vector space $B$ over an ACF admits a eigenvalue $lambda in k$ and, $(phi - lambda dot "id")$ is not a isomorphism since its determinant equals $0$.

  So $(phi - lambda dot "id") = 0$ must be the trivial map since $V$ is irreducible.
]

By this corollary, we obtain a good description of irreducible representations of commutative algebras. The key is that if $rho: A -> "End"(V)$ is a representation and $A$ is commutative, then $rho_a: V -> V$ is automatically a intertwining operator for all $a in A$.

#theorem(title: [$A$ commutative: Irreducible $<==>$ $1$-dimensional])[
  If $A$ is commutative and $rho: A -> "End"(V)$ is an representation of $A$, then $V$ is irreducible $<==>$ $V$ is $1$-dimensional.
]
#proof[
  - ($<==$): Trivial;
  - ($==>$): Since $rho_a: V -> V$ is an intertwining map and $V$ is irreducible, we know that $rho_a$ is an isomorphism. By @SchurACF, $rho_a$ is a scalar operator, since $V != 0$ by the definition of irreducible representation, $V$ must be $1$-dimensional.
]
