#import "@preview/theorion:0.3.3": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge  // Commutative diagram
#import cosmos.fancy: *
#show: show-theorion

// ↑ Theorem Environment ↑ //

#show link: underline
#set heading(numbering: "1.")
#set par(
  justify: true,
)


// Self Defined Symbols
#let iso   = symbol("≅")
#let hp    = symbol("≃")
#let mset  = $bold("Set")$
#let sset  = $bold("sSet")$
#let mgrp  = $bold("Grp")$
#let mtop  = $bold("Top")$
#let simp  = $"Simp"$
#let sing  = $"Sing"$
#let inj   = $arrow.hook.r$
#let ch    = $"Ch"$
#let sh    = $bold("Sh")$
#let cala  = $cal(A)$
#let calo  = $cal(O)$
#let et    = $bold("Ét")$
#let ab    = $bold("Ab")$
#let colim = $"colim"$
#let Hom   = $"Hom"$
#let diff  = $bold("Diff")$
#let mnfd  = $bold("Mnfd")$
#let yo    = $"よ"$
#let fib   = $"Fib"$
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

= Ch 5: Linearization of Manifolds
#definition(title: "Rank of a morphism between manifolds")[
  For a morphism (i.e. smooth map) $F: M -> N$ between manifolds, define the rank of $F$ at a point $p in M$ as:
    $ "rk"_p (F) := dim im T_p F, $
  where $T_p F: T_p M -> T_(F(p)) N$ is the differential of $F$.
]

Note that we obtain a function $"rk"_((-)) F: M -> NN$.

#proposition(title: [$"rk"_((-)) F^(-1) (NN_r^+)$ is open])[
  For morphisms between manifolds $F: M -> N$ and any given $r in NN$, the following subset of $M$ is open:
  $ {p in M: "rk"_p F >= r}. $
]
#proof[
  By restricting the domain to a smaller open subset $U subset M$ we can assume $M subset KK^n$ and $N subset KK^m$, thus $T_p F$ can be identifies with an element $A$ in $Hom_KK (KK^n, KK^m)$, which can be viewd as a matrix.

  So we just need to prove ${A in "Mat"_(n times m): "rk" A >= r}$ is open, but this can be done by checking the complement, for simplicity denoted by $C$, which consists of matrices whose all $r$-minors vanish.

  Since the determinent is continuous and thus preserve the $r$-minor vanishing properties, $C$ is closed. So the given set is open. 
]

#corollary[
  For morphism between manifolds $F: M -> N$:
  + The set $U := {p in M: F "is an immersion at" p} subset M$ is open.
  + The set $V := {p in M: F "is an submersion at" p} subset M$ is open.
]
#proof[
  We give the proof of 1.

  Since $M$ is a manifold there is an atlas ${U_i}_(i in I)$ where $U_i iso KK^(n_i).$

  Note that
  $ U = union.big_(i in I) {p in U_i: F "is an immersion at" p}, $
  and for all $p in U_i$, we have $T_p M iso T_p U_i iso KK^(n_i)$, so the differential map of $F$ is
  $ T_p F: T_p M iso T_p U_i iso KK^(n_i) -> T_(F(p)) N. $
  And thus
  $ {p in U_i: F "is an immersion at" p} = {p in U_i: "rk"_p F >= dim T_p M = n_i} $
  is an open subset since $n_i$ is a fixed natural number.

  Finally $U$ is open because it is an union of open sets.
]


= Ch 6: Lie Groups
Lie group is the group object in the category of smooth manifolds, so to investigate the group action on a manifold we should first learn something about Lie group.

== Derivative of a Lie algebra
This is (seemingly) a standard result: given a finite dimensional Lie algebra $frak(g)$, the automorphism group $"Aut"(frak(g))$ is actually a Lie group. TODO: proof.

#definition(title: "Derivative of a Lie algebra")[
  Given a finite dimensional Lie algebra $frak(g)$, the Lie algebra of the Lie group $"Aut"(frak(g))$ is called the *space of derivatives* of $frak(g)$.
]

= Ch 7: Torsors and the First Čech Cohomology
The exact reason why people defined the Čech Cohomology in such a complex way remains unknown to me, but if take for grant then the introduction of torsors is, in some sense, natural out of the consideration of providing an alternative definition.

== Torsors
In the context of group theory, torsor is just a $G$-set whose action is freely transitive. And it is natural to generalize this definition to other $mset$-like categories, i.e. topoi.

Torsors are geometric model of the first non-abelian cohomology of a sheaf, that means, the equivalence class of torsors of a group sheaf $G$ is isomorphic to the first Čech cohomology group, see @torsor-cech-eq for more.

We can form the category of torsors $bold("Tors")(cala)$ of a given group sheaf $cal(A)$, and a surprising result is
#theorem(title: [$bold("Tors")(cala)$ is a groupoid])[
  + $bold("Tors")(cala)$ is a groupoid;
  + An $cala$-torsor $T$ is trivial iff $T(X) != emptyset$
]

The following theorem is a good example of using the equivalence between $sh(X)$ and $et(X)$:
#theorem[
$H^1 (X, cala) = 0$ for locally constant sheaf $cala$ and simply connected, path-connected $X$.
]<simply-connected-implies-cech-trivial>

We can use this theorem to prove the classical result
#proposition[
  Let $M subset CC$ be open, then a holomorphic function $f: M -> CC$ admits primitives if $M$ is simply-connected
]<primitive-exists>

#proof[
  We define the primitive sheaf $"Prim"_f$:
    $ U |-> "Prim"_f (U) := {"Primitives of" f "on" U}, $

  This is a $CC_M$-torsor with action by addition:
    $ CC_M (U) times "Prim"_f (U) -> "Prim"_f (U),\ (h, F) |-> h + F. $

  Note that the assertion is equivalent to $"Prim"_f (M) != emptyset$, which is again equivalent to $"Prim"_f$ is trivial.

  Now by @simply-connected-implies-cech-trivial, $H^1 (M, CC_M)$ is trivial, so $"Prim"_f iso CC_M$ thus $"Prim"_f (M) != emptyset$.
]   
    
#proposition(title: "Logarithm is a torsor")[
Let $M subset CC$ be open and $f: M -> CC$ be holomorphic. Define the sheaf $log_f in sh(M)$:
  $ log_f U := {g in "holomorphic"(U): exp compose g = f}. $

Then
  + $log_f$ is a $ZZ_M$-pseudotorsor;
  + $log_f$ is a torsor iff $f$ does not vanish on $M$
]
#proof[
  + Trivial;
  + For every point $p in M$, there exists an open ball $p in B_p$ such that $B_p subset M$ because $M$ is open. So When $f$ does not vanish on $M$, ${B_p}_(p in M)$ trivialises $log_f$, which is a classical result from complex analysis#footnote[Non-vanishing functions admit logarithm on open balls. See, for example, Freitag Theorem II.2.9.].
]

So, when $M$ is simply connected and $f$ does not vanish on $M$, we have $H^1 (M, ZZ_M)$ is trivial, which means $log_f (M) != emptyset$.

If $f$ admits a primitive on $M$, then by methods of complex analysis we can give a explicit logarithm of $f$, which is defined in Freitag, Theorem II.2.9. But we still need to prove the existence of primitives on a simply connected open set, which can be proved by @primitive-exists.

Torsors are amazing!


=== Torsors and principal bundles
In this subsection, we generalize torsor to any category with product.

#definition(title: "Torsors in general categories")[
  Let $cal(C)$ be a category with products, and $G in cal(C)$ a group object. A $G$-torsor in $cal(C)$ is an object $T in cal(C)$ with an action map $alpha: G times T -> T$ such that the shear map
    $G times T -> T times T$
  is an isomorphism.
]

Torsors are preserved under the map from $cal(C)$ to the slice catgeory $cal(C)\/B$ for $B in cal(C)$:
#definition(title: "Torsors over an object")[
  Suppose $(T, alpha: G times T -> T)$ is a torsor in a category $cal(C)$.

  For $B in cal(C)$, we have a slice map $ (- times B): cal(C) ->> cal(C)\/B$ as:
    $ C |-> (C times B, "pr"_B). $

  This slice map preserves products so $G times B$ is also a group in $cal(C)\/B$.

  Now we define *a $G$-torsor over $B in cal(C)$* is a $(G times B)$-torsor in $cal(C)\/B$.
]

#definition(title: "Princial bundles")[
  Given a topological group $G$ and a space $B$, a $G$-princial bundle $P$ over $B$ is defined as a $G$-torsor over $B$, with a local trivialization.
]

== $H(cal(U), cal(A)) iso caron(H)(cal(U), cal(A))$<torsor-cech-eq>
This is just like $H^"Sing" iso H^"Simp"$.

Sometimes it is more convenient to compute the cohomology in another way.

A good example of using different definition to obtain fast proof of something related to the first Čech cohomology is the following proposition:
#proposition[
  $cala in sh_ab (X) => caron(H)^1 (X, cala) in ab$
]
#proof[
When $cala$ is a sheaf of abelian groups, by the definition of Čech cohomology it is obvious that $caron(H)(cal(U), cala)$ is an abelian group.

Since $ab$ admit arbitrary colimit and
  $ caron(H)^1 (X, cala) = colim_(cal(U)) caron(H)^1(cal(U), cala), $

this property is immediate.

]
#remark[
To prove this result by the definition using torsor is unimaginable.
]



== Extend the short exact sequence
Given a exact sequence of group sheaves on $X$:
#align(center, diagram({
   node((-2, 0), [$1$])
   node((-1, 0), [$cala'$])
   node((0, 0), [$cala$])
   node((1, 0), [$cala''$])
   node((2, 0), [$1$])
   edge((-2, 0), (-1, 0), "->")
   edge((-1, 0), (0, 0), [$iota$], label-side: left, "hook->")
   edge((0, 0), (1, 0), [$pi$], label-side: left, "->")
   edge((1, 0), (2, 0), "->")
}))

We can extend it#footnote[It can be extended to infinity, but now we just focus on the first cohomology groups.].

#theorem(title: "Extend exact sequence of sheaves")[

  For group sheaves $cala, cala'$ and $cala''$, the following sequence of *pointed sets* is exact:

    #align(center, diagram({
       node((-2, 0), [$1$])
       node((-1, 0), [$cala'(X)$])
       node((0, 0), [$cala(X)$])
       node((1, 0), [$cala''(X)$])
       node((-2, 1), [$caron(H)^1(X, cala')$])
       node((-1, 1), [$caron(H)^1(X, cala)$])
       node((0, 1), [$caron(H)^1(X, cala'')$])
       edge((-2, 0), (-1, 0), "->")
       edge((-1, 0), (0, 0), [$iota$], label-side: left, "hook->")
       edge((0, 0), (1, 0), [$pi$], label-side: left, "->")
       edge((1, 0), (-2, 1), [$delta$], label-side: center, "->")
       edge((-2, 1), (-1, 1), "->")
       edge((-1, 1), (0, 1), "->")
    }))
]<extend-cech>
#warning-box[
  $caron(H)^1(X, cala)$ is _not_ a group in general, but it is a pointed set.
]

= Ch 8: Bundles
In the previous chapter we found an isomorphism between the first Čech Cohomology and the equvilence class of torsors, i.e. if we can give a full classification of all the torsors, we can also decide $caron(H)^1 (X, cala)$, where $cala in sh_ab (X)$.

What if the sheaf $cala$ is not abelian but a general sheaf of groups? How should we describe the Čech cohomology group? In this chapter we will see one way is to use twists, and we will give further descriptions of $caron(H)^1 (X, cal(G))$ for different kinds of $cal(G) in sh_mgrp (X)$ by investigating different kinds of twists, like fiber bundles and vector bundles.

In short: *bundles are geometric models of Čech cohomology*.

== Twists, Principal bundles and Vector bundles
The universal idea behind Čech cohomology is the cocycle condition.

=== Twists
For different kinds of manifolds, the condition satisfied by transition functions between open sets in atlas varies, for example in the catgeory of $diff$ which consists of smooth manifolds, the transition functions between $U_1, U_2 in "atlas"$ should be smooth, but in the category of topological manifolds we only need the transition functions to be continuous.

Even if we are in the same category, we may want to restrict our attention to a specific kind of manifolds with specific condition to transition functions, this can be modeled by twists.

TODO: 上面的東西似乎不對，因爲 twists 是針對態射而言，而流形的 transition functions 是只針對自身而言。

We say, for simplicity, for a given manifold $B$, a morphism in the slice category $mnfd\/B$ is a $B$-morphism.

#definition(title: [The *MEGA* group sheaf])[
  For a morphism between manifolds $p: Z -> B$, we define the automorphism sheaf $"Aut"_p in sh_mgrp (Z)$ by
  $ "Aut"_p (U) := {U"-isomorphisms between" p^(-1)(U) -> p^(-1)(U)}, $
  where $U subset Z$ open.
]
#remark[
  All transition functions are automorphism, so every group sheaf is a subsheaf of $"Aut"_p$.
]


#definition(title: "Twist")[
  TODO
]

#theorem(title: "Čech cohomology is modeled by twists")[
  This is an isomorphism between pointed sets:
  $ gamma: {"isomorphism classes of twists of" p "with structure sheaf" cal(G)} -> caron(H)^1 (B, cal(G)). $
]

=== Fiber bundles
There is a special class of morphisms that arises our interest, that is, projections $p: B times F ->> B$. The twists that locally look like a projection is called a fiber bundle.

There is also a special class of subsheaves of $"Aut"_p$:
#definition(title: [$calo_(B; G) inj "Aut"_p$])[
  Given a Lie group $G$ and a faithful $G$-action on a manifold $F$ by a morphism of manifold $G times F -> F$, then we claim:
  $ iota: calo_(B; G) inj "Aut"_p\
  iota_U: g in calo_(B; G)(U) |-> [(b, f) in p^(-1)(U) |-> (b, g(b)f) in p^(-1) U] $
  is a subsheaf inclusion.
]

We give a new name of two twists satisfying those two special conditions above:
#definition(title: [Fiber bundle with basis $B$, typical fiber $F$ and structure group $G$])[
  TODO: definition.
]

And here is what fiber bundles are for: $caron(H)^1 (B, yo_G)$ can be classified by them, where $G$ is a Lie group.

#theorem(title: "Čech cohomology is modeled by fiber bundles")[
  Denote the isomorphism classes of fiber bundles with basis $B$, typical fiber $F$ and structure group $G$ by $fib_(F, G) (B)$, then there is an isomorphism:
  $ fib_(F, G) (B) -> caron(H)^1 (B, calo_(B; G)), $
  where $calo_(B; G)$ sends $U subset B$ open to $mnfd(U, G)$.
]

=== Vector bundles<vector-bundle>
There is a specific kind of Lie groups, namely the general matrices group $"GL"(n, KK)$, and the specific kind of Čech cohomology $caron(H)^1 (X, calo_(B; "GL"(n, KK)))$ can be classified by a special kind of fiber bundles -- vector bundles.

For simplicity we define $"GL"_(n, B) := calo_(B; "GL"(n, KK))$.

By general argument of fiber bundles we have a isomorphism:
$ caron(H)^1 (B, "GL"_(n, B)) iso {"isomorphism classes of vector bundles of rank" n "with basis" B}. $

For $n = 1$ this is:
$ caron(H)^1 (B, "GL"_(1, B))iso {"isomorphism classes of line bundles with basis" B}, $
and since $"GL"_(1, B) = O_B^times$ is an abelian group, $caron(H)^1 (B, "GL"_(1, B))$ is also an abelian group.

#definition(title: "Picard group")[
  We define the Picard group of a manifold $B$ as
  $ "Pic"(B) := caron(H)^1 (B, "GL"_(1, B)), $
  which is an abelain group.

]

Vector bundles are good which embodied in the following equivalence:
$ bold("VectB")_X iso "Finite Locally Free " cal(O)_X-bold("Mod"), $
and the latter is a abelian category, so is $bold("VectB")_X$.

So, by the general operation, i.e. given an abelian group, we can form a $K$-theory of it, we thus obtain the topological $K$-theory.

TODO: The precise process of form a $K$-theory, and is it true that given any abelian category we can do this?
=== Application
The following example shows the power of @extend-cech:

#example[
Consider this exact sequence of Lie groups:
  #align(center, diagram({
     node((-2, 0), [$0$])
     node((-1, 0), [$ZZ$])
     node((0, 0), [$CC$])
     node((1, 0), [$CC^times$])
     node((2, 0), [$0$])
     edge((-2, 0), (-1, 0), "->")
     edge((-1, 0), (0, 0), "hook->")
     edge((0, 0), (1, 0), [$exp(2pi i dot-)$], label-side: left, "->>")
     edge((1, 0), (2, 0), "->")
  }))

By the above theorem (TODO), for every complex manifold $B$, the following sequence of sheaves is also exact:
  #align(center, diagram({
     node((-2, 0), [$0$])
     node((-1, 0), [$ZZ_B$])
     node((0, 0), [$calo_B$])
     node((1, 0), [$calo_B^times$])
     node((2, 0), [$0$])
     edge((-2, 0), (-1, 0), "->")
     edge((-1, 0), (0, 0), "hook->")
     edge((0, 0), (1, 0), [$exp(2pi i dot-)$], label-side: left, "->>")
     edge((1, 0), (2, 0), "->")
  }))

By @extend-cech, we obtain a longer exact sequence
  #align(center, diagram({
     node((-2, 0), [$0$])
     node((-1, 0), [$ZZ^(pi_0(B))$])
     node((0, 0), [$calo_B (B)$])
     node((1, 0), [$calo_B^times (B)$])
     node((-2, 1), [$caron(H)(B, ZZ_B)$])
     node((-1, 1), [$caron(H)(B, calo_B)$])
     node((0, 1), [$caron(H)(B, calo_B^times)$])
     edge((-2, 0), (-1, 0), "->")
     edge((-1, 0), (0, 0), "hook->")
     edge((0, 0), (1, 0), [$exp(2pi i dot-)$], label-side: left, "->>")
     edge((1, 0), (-2, 1), [$delta$], label-side: center, "->")
     edge((-2, 1), (-1, 1), "->")
     edge((-1, 1), (0, 1), "->")
  }))

So a nowhere vanishing holomorphic function admits a logarithm iff $ im(calo_B (B) ->> calo_B^times (B)) = calo_B^times (B), $ iff $ im delta = 0, $ iff $caron(H)(B, ZZ_B) -> caron(H)(B, calo_B)$ is injective.

So when $B$ is simply connected, every nowhere vanishing function admits a logarithm.
]

=== $calo_X$-modules
#text(fill: blue)[Typical example: the tangent bundle].

The main result have been stated in @vector-bundle:

#quote[Vector bundles are good which embodied in the following equivalence:
$ bold("VectB")_X iso "Finite Locally Free " cal(O)_X-bold("Mod"), $
and the latter is a abelian category, so is $bold("VectB")_X$.]

So given an functor $F: calo_X (X)-bold("Mod") -> calo_X (X)-bold("Mod")$ we can apply it to sheaves in $calo_X-bold("Mod")$.

So given a vector bundle we can construct its dual bundle by applying the dual functor to the corresponding $calo_X$-module.
