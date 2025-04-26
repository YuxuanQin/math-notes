#import "@preview/theorion:0.3.3": *
#import cosmos.clouds: *
#show: show-theorion

// ↑ Theorem Environment ↑ //

#show link: underline
#set heading(numbering: "1.")
#set par(
  justify: true,
)

///// ↑↑↑ SETTINGS ↑↑↑ /////

#align(center, text(17pt)[
 Notes on _Measure, Integration and Real Analysis_
])

#grid(
  columns: (1fr),
  align(center)[
Author: #text(font: "Noto Serif CJK SC")[秦宇轩]（Qin Yuxuan）\
Last complied at #datetime.today().display() \
  ],
)

///// ↑↑↑ TITLES ↑↑↑ /////

#outline()
#line(length: 100%)

///// ↑↑↑ Contents ↑↑↑ /////

= Measure



= Integration
The main idea of integration is that _every function can be approximated by simple function_. And, we can almost replace every function concerned with its approximation sequence (Examples are the proof of additivity of integration.).

== Integration of simple funcitons
#definition(title: "Simple Function")[
  Those functions are precisely whose range is finite.
]

#lemma[
  Every simple function admits a normal form as:
  $ sum_(E in cal(E)) c_E chi_E. $
where $cal(E)$ is a finite family of sets, $c_E$ are real number and $chi$ is the characteristic function.
]

== Integration plays well with limit, absolute value and ordering
#theorem(title: "Monotone Coverage")[
  For measurable space $(X, S, mu)$ and a sequence of increasing measurable funcitons $f_i$, if $f(x) := lim_k f_k (x)$ is defined for all $x$, then we have: $ lim_k integral f_k d mu = integral f d mu. $
#proof[Omitted]
]

#theorem(title: "Absolute Value Inequality")[
  For measurable function $f$ we have
  $ abs(integral f d mu) <= integral abs(f) d mu. $
  #proof[By triangle inequality.]
]

To prove integration preserve ordering we will first introduce a lemma:

#lemma(title: "Positive function admit positive integration")[
  If $f >= 0$ then $ integral f d mu >= 0. $
]

#theorem(title: "Ordering are preserved")[
  For $f >= g$ we have $ integral f >= integral g. $
  #proof[Consider $integral (f - g)$.]
]

== Integrations on small sets are small
#theorem(title: "You can not be powerful every where")[
  For measurable function $g$, if it is not so extraordinary (that is, $integral g < infinity$), then for any $epsilon > 0$ there exists a number $delta$ such that
  $ integral_B g < epsilon, $
  for all $B$ with $mu B < delta$.

  #proof[
    Consider easy cases first: if $g$ is a simple function, then just let $delta = 1/2 max (g) dot epsilon$, since $integral_B g <= mu B dot max (g)$.

    If $g$ is not simple, then we just simply force it be simple.
  ]
]

== Domination Theorem
The powerful dominate the weak, thought I don't like the fact but, a fact is a fact.


