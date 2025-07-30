#import "@preview/commute:0.3.0": node, arr, commutative-diagram
#show link: underline
#set text(font: (
  (name: "libertinus serif"),
  "Noto Serif CJK SC"
))
#set heading(numbering: "1.")

///// ↑↑↑ SETTINGS ↑↑↑ /////

#align(center, text(17pt)[
  Notes on Algebra
])

#grid(
  columns: (1fr),
  align(center)[
Author: 秦宇轩（Qin Yuxuan）\
Last compiled at #datetime.today().display() \
  ],
)

///// ↑↑↑ TITLES ↑↑↑ /////

#outline()
#line(length: 100%)

///// ↑↑↑ Contents ↑↑↑ /////

= The algebraic closure of finite field
Fix a prime $p$, we claim that the algebraic closure of finite field $FF_(p^n)$ (for all $n >= 1$) is:
$ overline(FF)_p := union.big_(k in NN) FF_(p^k!). $

Reasons:
  + We know that $FF_(p^k)$ is the splitting field of $x^(p^k) - x$ on $FF_p$ for all naturals $k >= 1$;
  + For $k | m$ we have $(x^(p^k) - x ) | (x^(p^m) - x)$, since if $x^(p^k) = x$ then $x^(p^m) = (x^(p^n))^(p^(m - n)) = x^(p^(m - n))$ and so on and so on, terminates at $x^(p^0) = x$ since $k | m$. So we always have $FF_(p^(k!)) subset FF_(p^((k + 1)!))$;
  + For any non-constant polynomial $f in overline(FF)_p$, there exist a natural number $k$ such that all coefficients of it are in $FF_(p^k!)$, then the splitting field of $f$ is a finite extension of $FF_(p^k!)$ and thus is also finite with characteristic $p$ in form $FF_(p^m)$ for some naturals $m$, so its splitting field is contained in $(FF)_(p^(m!))$ by point 2, thus finally its splitting field is contained in $overline(FF)_p$.

_Ref_. #link("https://planetmath.org/algebraicclosureofafinitefield")[_algebraic closure of a finite field_. Planetmath. Ver. 2025-07-09].
