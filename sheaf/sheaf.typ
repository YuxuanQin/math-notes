#show link: underline
#set heading(numbering: "1.")
#set par(
  justify: true,
)

///// ↑↑↑ SETTINGS ↑↑↑ /////

#align(center, text(17pt)[
 Notes on _Manifolds, sheaves and cohomology_
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


= Notations
- $X, Y, Z$: topological spaces.
  - $tau_X$: the topology of space $X$, i.e., the set of open sets.
- $F, G$: general (pre)sheaves.
- $cal(O)_X$: structure sheaf associated with ringed space $X$.
  - For open set $U subset X$, we use $cal(O)_U$ to denote $cal(O)_X|_U$.
- $KK$: used for denoting $RR$ or $CC$.
- $alpha$: a generalized natural number, i.e., $alpha in NN$ or $alpha = infinity$.
- $C^alpha_X$: Sheaf of $C^alpha$ functions, on a suitable space $X$.

*Warning: All "(pre)manifolds" are either $C^alpha$ real-(pre)manifolds for some $alpha$, or $C^omega$ complex-(pre)manifolds.*

To be more imformative we may use:
- $(M, C^alpha_M)$: for real-manifolds;
- $(M, "hol"_M)$: for complex-manifolds;
- $(M, cal(O)_M)$: for general manifolds;

#line(length: 100%)

= Presheaf of ($E$-valued) funcions
Given a bare set $E$, those presheaves $P$ such that $P(U)$ is some kinds of subset of $"Set"(U, E)$ for all opens $U$, where the restriction map is the obvious one.

= Morphisms between stalks are alyways more convenient
  - The possisble reason of this phenomena is that, in general you can't go back from a set of local data to global data in presheaves, and _sheaves_ are about local data, so it is difficult to define a morphism from $"Sh"(F)$ to $F$ for presheaves F. But the stalk $F_x$ _is_ about local data and permit you to construct an element by pure local data.
  - For example, in the proof of *Example 3.30*, one can easily define a morphism $alpha_x: tilde(F)_x := "Sh"(F)_x -> F_x$ by specify that, for an element $(g, {U_i})$ in $tilde(F)U$, the equvilence class defined by $(g|_(U_x), U_x)$ where $x in U_x$. And this is indeed a well morphism, which induces a map $tilde(F)_x -> F_x$.

= Constant sheaves
Unfortunately, the name is a little bit confusing (at least in some kind), since for such a sheaf $F$ and an open $U$, the elements of $F U$ is _not_ constant functions but _locally constant_ function.
  - But it can be fixed by viewing that such sheaves are the sheafification of _constant presheaves_. The proof is straightforward by *Example 3.30*.

= Restriction of presheaves
For a presheaf $F: tau^"op"_(X) -> "Set"$, we can restrict it to a open $U subset X$ by pre-composing the inclusion functor $"inckusion": tau^"op"_(U) -> tau^"op"_(X)$. This is a presheaf by definition.

= Locally constant sheaves
Those are sheaves $F$ such that for any open $U$, there exist an open cover ${U_i}$ on where $F$ is a constant sheaf, i.e., $F U_i$ is a constant sheaf for all $i$. This name should be interpreted as "Locally (constant sheaf)".

= Constant sheaves and trivial etale spaces
We all agree something to be "constant" is some kinds of triviality, and under the equivalence of categories, this triviality should be preserved. And it is the fact that *constant sheaves correspond to trivial etale spaces*! To prove so, one need to prove that $"Et"(F)$ for some constant sheaf $F$ is a trivial etale space, _or_ $"Sh"(S, pi)$ is a constant sheaf. And after trials one find that the latter is much easier.

  - Remark of "trivial etale spaces": The most trivial etale space of a topological space $X$ is ... $X$ it self with the indentity map. The second class of trivial etale spaces is the class of $X times E$ where $E$ is a set equipped with discrete topology, with the projection map.
  - Add the prefix "locally" we immediately obtain the finer correspondence between _locally constant sheaves_ and _locally trivial etale space_, i.e., _covering spaces_.

= Ringed spaces
  - Objects: A ringed space is a topological space $X$ with a $R$-algebra sheaf $cal(O)_X$, where $R$ is a ring. 
  - Morphisms: A morphism between two ringed spaces $(X, cal(O)_X)$ and $(Y, cal(O)_Y)$ is a pair $(f, f^flat)$:
    - $f : X -> Y$ is a continuos map;
    - $f^flat : cal(O)_Y -> f_* cal(O)_X$ is a morphism between sheaves. (pronounced as "f flat")
  - _Remark:_ By the adjunction of $f^(-1) tack.l f_*$, to specify the $f^flat$ is equivalent to specify $f^natural: f^(-1)cal(O)_Y -> cal(O)_X$.

= Locally ringed spaces
  - Objects: Those ringed spaces such that $cal(O)_(X,x)$ the stalk at $x$ is a _local ring_.
  - Morphisms: Those $(f, f^flat, f^natural)$ such that the morphism $f^natural_x: cal(O)_(Y,f(x)) -> cal(O)_(X,x)$ send the maximal ideal into maximal ideal.

= Properties of morphisms between $KK^n$ subspaces with $C^alpha$ sheaves (Eg. 4.5)
  For open susbets $X subset V$ and $Y subset W$, where both $V$ and $W$ are *finite dimension* $KK$-vector spaces and $KK$-ringed $C^alpha$-map $(f, f^flat) : (X, C^alpha_X) -> (Y, C^alpha_Y)$:
  - $(f, f^flat)$ is automaticallt a *locally* ringed morphism.
  - For all open $U subset Y$, the morphism between structure sheaves $f^flat_U: C^alpha_Y U -> C^alpha_X (f^(-1) U)$ is given by precomposition, i.e., $f^flat = - compose f$.

= Restriction is the left Kan extension (Def. 4.7)
For an open subspace $i : U -> X$ and a sheaf $cal(O)_X$ on $X$, we claim that the restriction of $cal(O)_X$ on $U$, i.e., $cal(O)_U := cal(O)_X|_U$, is isomporhic to $i^(-1) cal(O)_X$.

  - _proof:_ It's straightforward to verify that $cal(O)_U$ is exactly the left Kan extension of $cal(O)_X$ along $i$.
    - _Remark:_ The canonical isomorphism is actually $i^natural: i^(-1)cal(O)_X -> O_U$, the reason is that $i^natural$ is the correspondence of $i^flat$ through the adjunction, but since this adjunction is about left Kan extension and precomposition, $i^natural$ is induced by the universal property of $i^(-1) cal(O)_X$, since there is a morphism $cal(O)_X -> cal(O)_U = cal(O)_X|_U = cal(O)_X compose "bi"$, where $"bi": tau^"op"_X -> tau^"op"_U$ induced by $i$.

= Open subspaces of locally ringed space are also locally ringed (Def. 4.7)
By the above property, the stalk at $u in U$ of $cal(O)_U$ is isomorphic to $"colim"_u  i^(-1)cal(O)_X = cal(O)_(X, u)$, which by assumption is a local ring.

= $C^alpha$-premanifolds
$C^alpha$-Premanifolds are *locally $KK$-ringed spaces* that are *locally isomorphic to open subspace of $KK^n$*, which endowed with $C^alpha$ sheaf, for some $n$.
  - Objects: A triple $(M, cal(O)_M, {U_i})$ where
    - $(M, cal(O)_M)$ is a locally $KK$-ringed space;
    - ${U_i}$ is an open cover of $M$ equipped with a bunch of *isomorphisms* between locally $KK$-ringed spaces: $w_i: (U_i, cal(O)_(U_i)) -> (Y, C^alpha_Y)$, where $Y subset KK^n$ open. 
      - _Remarks:_ $Y$ and $n$ may depend on $i$, while $alpha$ fixed.
  - Morphisms: Plain morphisms between locally ringed space. For such morphisms between $C^alpha$ premanifolds, we usually call them *$C^alpha$-maps*.
    - _Remarks 1:_ When $alpha = infinity$, we call them *smooth* maps. When $alpha = omega$, we call them *analytic* maps.
    - _Remarks 2:_ Isomorphisms between $C^alpha$-premanifolds are called *$C^alpha$-diffeomorphisms*.

= Complex premanifolds
When $KK = CC$, all functions that are $C^alpha$ for any $alpha$ are automatically $C^omega$, so it is dumb to differ them.

Therefore we call them just *complex premanifolds*. 

The fancy name of morphisms between complex premanifolds is "*holomorphic maps*", for isomorphisms, we use "*bi-holomorphic maps*".

= Manifolds
  - Objects: Those premanifolds whose underlying spaces are *Hausdorff* and *second countable* (admit a countable bunch of basis).
  - Morphisms: Inherits from premanifolds.
