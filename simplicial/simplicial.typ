#show link: underline
#set heading(numbering: "1.")
#set par(
  justify: true,
)

///// ↑↑↑ SETTINGS ↑↑↑ /////

#align(center, text(17pt)[
  Notes on simplicial stuffs
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

+ The canonical category of _finite ordered sets_ with _order preserving maps_ is denoted by $Delta$, with a bunch of handy morphisms between neighboors:
  - _co-face_ map $delta^n_i: [n - 1] -> [n]$, whose image is $[0, 1, ..., ("without" i), ..., n]$;
  - _co-degeneracy_ map $sigma^n_i: [n] -> [n - 1]$, which is almost indentity but send both $i$ and $i + 1$ in $[n]$ to $i$ in $[n - 1]$.
+ A *simplicial object* in category $C$ is just a functor $F: Delta^"op" -> C$. We denote $F([k])$ by $F_k$, which is more convenient.
+ Since simplicial objects are contra-variant, we obtain:
  - _face_ map $d^n_i := F(delta^n_i): F_n -> F_(n - 1)$;
  - _degeneracy_ map: $s^n_i := F(sigma^n_i): F_(n - 1) -> F_n$.
+ An $n$-*simplex* of simplicial set $F$ is just an element of set $F_n$.
+ A simplex is called *degenerate* if it is the degeneracy of another simplex. For example, we say an $k$-simplex $x$ (i.e., $x in X_k$) is degenerate if there exists ($k - 1$)-simplex $y$ (i.e., $y in X_(k - 1)$) and some number $i$ such that $x = s_i (y)$.
  - Sometimes we use $D(X_k) := union_i (s^k_i (X_(i - 1)))$ to denote all the degenerate $k$-simplex in $X_k$, for simplicial set $X$.
+ *Moore complex*: Given a simplicial object $U$ in an abelian category $cal(A)$, its associated _Moore complex_ is a chain complex in $cal(A)$, which looks like:
  $ ... -> U_2 -> U_1 -> U_0 -> 0 -> 0 -> ... $
  where the boundary map $partial_n: U_n -> U_n-1$ is defined by the alternating sum of face maps:
  $ partial_n := sum^n_(i = 0) (-1)^i d^n_i. $
  Note that $d^n_k : U_n -> U_(n - 1)$ for all $k$.
    - Also named *the alternating face map chain complex*.
+ *Singular simplicial complex*: For a topological space $X$, its _singular simplicial compelx_ is indeed the simplicial set induced by the nerv-realazation relation of the canonical inclusion $Delta -> "Top"$.
  - So a *singular $n$-simplex* for such a space $X$ is just a morphism from $Delta^n$ to $X$ in $"Top"$, by the Yoneda lemma.
  - The *singular homology* of a space $X$ is just the homology of the moore complex of its singular simplicial compelx. One usually writes $H_n (X, ZZ)$ or just $H_n (X)$ for the singular homology of $X$ in degree $n$.
