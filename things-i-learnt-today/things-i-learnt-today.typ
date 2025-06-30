#import "@preview/commute:0.3.0": node, arr, commutative-diagram
#show link: underline
#set text(font: (
  (name: "libertinus serif"),
  "Noto Serif CJK SC"
))
//#set heading(numbering: "1.")

///// ↑↑↑ SETTINGS ↑↑↑ /////

#align(center, text(17pt)[
  What I have learnt today
])

#grid(
  columns: (1fr),
  align(center)[
Author: 秦宇轩（Qin Yuxuan）\
Last complied at #datetime.today().display() \
  ],
)

///// ↑↑↑ TITLES ↑↑↑ /////

#outline()
#line(length: 100%)

///// ↑↑↑ Contents ↑↑↑ /////

= 2025

== 06-30: $F^times$ is cyclic
For finite field $F$, the multiplicative group $F^times$ is cyclic. This result can be used to prove that every finite field is gained from a quotient like $bold(F)_p [x] \/ (pi (x))$, for some prime $p$ and monic irreducible $pi (x)$.

*Main idea*: a group $G$ is cyclic iff there is an element $g$ such that $h = g^k$ for any other element $h$ and some $k$, so we must have $"ord" g = |G|$. But by Lagrange theorem we alyways have $"ord" g | |G|$ for any $g$ in $G$, so it suffices to prove $|G| <= "ord" g$. Thanks to the lemma below, we have $h^("ord" g) = 1$ for all $h$. So the polynomial $x^("ord" g) = 1$ has $|F^times|$ roots, which implies $|F^times| <= "ord" g$.

*Lemma*: In finite ablian group, the order of every element divides the maximal order. (It's fun to prove)

_Ref._ #link("https://kconrad.math.uconn.edu/blurbs/galoistheory/finitefields.pdf")[Finite Field by Conrad].

