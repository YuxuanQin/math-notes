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
 Notes on _Manifolds, sheaves and cohomology_
])

#grid(
  columns: (1fr),
  align(center)[
Author: #text(font: "Noto Serif CJK SC")[秦宇轩]（Qin Yuxuan）\
Last compiled at #datetime.today().display() \
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

= Sheaf valued at the empty set 
For sheaf $F$ defined on a topological space $X$, we claim that $F(nothing) = "singleton"$. The reason is that the empty-indexed product in any category is its (if exists) initial object, in the category $bold("Set")$ this means that $product_nothing = "singleton"$. Also note that $product.co_nothing = nothing$.

So $product.co_nothing = nothing$ is a cover of $nothing$, and since $F$ is a sheaf,
$ F(nothing) -> product_nothing = product_nothing $
is a equalizer, so $F(nothing) = "singleton"$.

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

  - Remark of "trivial etale spaces": The most trivial etale space of a topological space $X$ is ... $X$ it self with the identity map. The second class of trivial etale spaces is the class of $X times E$ where $E$ is a set equipped with discrete topology, with the projection map.
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

= $(KK, C^alpha_KK)$ is a manifold
The only needed chart is $"id": (KK, C^alpha_KK) -> (KK, C^alpha_KK)$.

We alyways equip $KK$ with this maniold struture, if without warning.


= A Yoneda-style lemma of structure sheaf (Prop. 4.17)
Given an arbitrary $KK$-premanifolds $(M, cal(O)_M)$, we claim that $"PMfd"(-, KK) tilde.eq cal(O)_M$. The isomorphism is given by $ [(t, t^flat): U -> KK] |-> [t^flat_KK ("id"_KK)]. $

Note that $t^flat: C^alpha_KK -> t_*cal(O)_U$ is a morphism between sheaves. And $cal(O)_U V = cal(O)_M (U inter V)$, so $t^flat_KK ("id"_KK) in cal(O)_U U = cal(O)_M U$, which implies these morphism is well-defined, at least in the layer of codomain.


  _proof:_ This is indeed a morphism between sheaves of $KK$-algebra. *TODO*

= Torsor
A torsor is a group forgotten its identity. More precisely, for a group object $G$ in $bold("Sh")(X)$ (thus a sheaf of groups), a $G$-torsor is a sheaf $T$ such that:
  - There is a simply transitive $G$-action on $T$;
  - $T$ is non trivial for a open covering of $X$.

When $X = "singleton"$ we have $bold("Sh")(X) tilde.eq bold("Set")$. So at this time a torsor is just a set, and there is a bunch of group structures on $T$ induced by a bijection from $T$ to $G$. More explicitly for a fixed element $t in T$ we can define a bijection $alpha_t : T -> G$ as $x |-> g$ where $g$ is the unique one such taht $g t = x$.

For any sheaf of groups $G$ we obtain a category $bold("Tors")(G)$, further, it is a groupoid since in $bold("Set")$ any morphism between $G$-torsors are isomorphism.

$G$ itself is a torsor as well, those isomorphic to $G$ as torsors are called trivial. If $T(X)$ is non-empty then for all opens $U$ we have $T(U) tilde.eq G(U)$ naturally and thus $T tilde.eq G$. That is, *if $T(U)$ is non-empty then $T$ is trivial*.

#example[The primitive function sheaf $"Prim"_f$ for a holomorphic function $f: M -> CC$ on complex plane is an $CC_M$-torsor. Where $CC_M$ is the constant sheaf target $M$, that is $CC_M (U) := {g : U -> M "locally constant"}$.]

#example[For a bunch of discrete points ${p_i}$ on complex plane and a bunch of principal part $f_i$, we construct the Mittag-Leffler sheaf $"ml"$ on $CC$ as a sheaf of meromorphic funtions with only possisble singular points are ${p_i}$, where $"ml"(U) := {g: U -> CC, "around" p_i "has principal" f_i}$. Then $"ml"$ is a $cal(O)_CC$-torsor. ]

*Notation*: By $H^1(X, G)$ we mean the isomorphic calsses of $G$-torsors.

= Cech cohomology
== Motivation
See #link("https://math.stackexchange.com/questions/4709130/what-is-the-motivation-behind-the-definition-of-cech-cohomology")

Notation stolen from section "Torsor".

The Mittag-Leffler problem has a solution if and only if there is a bunch holomorphic functions ${h_i}$ around ${p_i}$ respectively such that $f_i + h_i = f_j + h_j$ for all $i, j$. Indeed we can construct a meromorphic function $g:= f_i + h_i$ which is a solution. Conversly, if there is a solution $g$ we define $h_i := g - f_i$. *TODO*

== Definition
#definition(title: "Cech cohomology of a covering")[
  For a fixed open covering $cal(U) = (U_i)$ of $X$ and a sheaf of groups $G$, we define:
  - A Cech 1-cocycles of $G$ on $cal(U)$ is a tuple $theta = (g_(i j))$ with $g_(i j) in G(U_(i j))$ and satisfies the _cocycle condition_: $ g_(i j)g_(j k) = g_(i k). $
    
    The set of all 1-cocycles are denoted by $hat(Z)(cal(U), G)$. It carries a group struture defined as component-wise multiplication.

  - Two cocycles $theta$ and $theta'$ are called cohomologous if and only if there exist a bunch of elements $h_i in G(U_i)$ such that
    $ h_i g_(i j) = g'_(i j) h_j. $
    
    (Being cohomologous is an equivalent relation.)

Finally we define the *Cech cohomology on $cal(U)$*: 
$ hat(H)(cal(U), G) := (hat(Z)(cal(U), G)) / "cohomologous". $

In general $hat(H)(cal(U), G)$ is not a group. 
]

It's straightforward to extend this definition to global, first note that all covering of $X$ form a category $bold("Cov")(X)$ with refinements as morphisms and, $hat(H)(-, G): bold("Cov")^"op" (X) -> bold("Grp")$ is a functor.

#definition(title: [Cech cohomology on $X$])[
  The "global" cohomology is defined as a colimit:

  $ hat(H)(X, G) := "colim"_(cal(U)) hat(H)(cal(U), G).  $
  
]
