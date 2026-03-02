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
#let sh   = $bold("Sh")$
#let psh  = $bold("PSh")$
#let simp = $"Simp"$
#let sing = $"Sing"$
#let inj  = $arrow.hook.r$
#let ch   = $"Ch"$
#let exp  = $"exp"$
#let calo = $cal(O)$


////////////////////////////////////////////////////////////////////
////////////////////////////  Title  ///////////////////////////////
////////////////////////////////////////////////////////////////////
// Title
#align(center, text(17pt)[
  Notes on Riemann Surface
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

Ref. #link("https://www.mathi.uni-heidelberg.de/~freitag/skripten/riemfl.pdf")[Prof. Dr. Freitag's Notes].

= Sheaves
To implement a homology theory for sheaves, one must first consider the concept of "exactness", and everything is just fine for presheaves, but what if we take a closer look at sheaves?

Suppose we have a sequence of sheaves and maps between them:
#align(center, diagram({
   node((-2, 0), [$0$])
   node((-1, 0), [$F$])
   node((0, 0), [$G$])
   node((1, 0), [$H$])
   node((2, 0), [$0,$])
   edge((-2, 0), (-1, 0), "->")
   edge((-1, 0), (0, 0), [$alpha$], label-side: left, "->")
   edge((0, 0), (1, 0), [$beta$], label-side: left, "->")
   edge((1, 0), (2, 0), "->")
}))

one may want to define the exactness of this sequence by checking if $ker beta = im alpha$, which works just perfect well in the case of presheaves, but *the image of a map between sheaves need not to be a sheaf again*!

#important-box[/ Non-example: Consider the map in $sh(CC)$:
  $ exp: calo -> calo^* $
  where $calo$ is the well-known ($ZZ$-module valued, under addition) sheaf of holomophic functions on $CC$ and $calo^*$ is the multiplicative version, i.e. the ($ZZ$-module valued, under multiplication) sheaf of holomophic functions *without zeros* on $CC$.

  Denote the "image" of $exp$ as $K := im exp$, where $K U := {exp f: f "is holomophic on" U}$, we claim that it is not a sheaf.

  _proof by contradiction_. If $K$ is a sheaf, then consider these two open sets which cover $CC^*$:

    $ H_1 := {z: - pi /2 <= "arg" z <= pi}, H_2 := {z: pi / 2 <= "arg" z <= 2 pi}. $

    Now let $f_1 = id in K(H_1)$ and $f_2 = id in K(H_2)$, we note $f_1 |_(H_12) = f_2 |_(H_12) = id$ so by the definition of a sheaf there must exist a $f = id in K(H_1 union H_2) = K(CC^*)$, but this means there is a holomorphic logarithm on $CC^*$ which is impossible!]

So we can not ccompare the kernel and the image, but need to compare the kernel with *the sheafification of image*#footnote[Contrary to the pathological behaviour of the image, the kernel is always a sheaf.]!

#definition(title: "Exactness of sheaves")[
A sequence of sheaves 
#align(center, diagram({
   node((-2, 0), [$0$])
   node((-1, 0), [$F$])
   node((0, 0), [$G$])
   node((1, 0), [$H$])
   node((2, 0), [$0,$])
   edge((-2, 0), (-1, 0), "->")
   edge((-1, 0), (0, 0), [$alpha$], label-side: left, "->")
   edge((0, 0), (1, 0), [$beta$], label-side: left, "->")
   edge((1, 0), (2, 0), "->")
}))
is exact iff $sh(im alpha) = ker beta$.
]
