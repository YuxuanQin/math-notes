#show link: underline
#set text(font: (
  (name: "libertinus serif", covers: "latin-in-cjk"),
  "Noto Serif CJK SC"
))
#set heading(numbering: "1.")

///// ↑↑↑ SETTINGS ↑↑↑ /////

#align(center, text(17pt)[
  Quick notes about category theory
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


= The category of categories $"Cat"$ is co/complete.

  _proof:_ We will prove this interesting statment by the realization-nerv relation between $"Cat"$ and $"sSet"$.

      First note that:
      - $"h": "sSet" -> "Cat"$ is the *left* adjoint, which preserves *colimit*.
      - $"Nerv": "Cat" -> "sSet"$ is the *right* adjoint; and it is *fully faithful*, which implies the counit $epsilon: "h" compose "Nerv" => "id"_"Cat"$ is an isomorphism.
  
      Then we start the main proof:
     
    - *Cocompleteness*: For all functors $F: J -> "Cat"$, since the counit of realization-nerv adjunction is an isomorphism, we have $"h" compose "Nerv" compose F tilde.eq F$. The left-hand-side *does* have colimit since
      $ "colim"("h" compose "Nerv" compose F) tilde.eq "h"("colim"("Nerv" compose F)). $
      And the latter colimit is in $"sSet"$, which is cocomplete since it is a presheaf category.

      Also note that there is another abstract proof based on theory of enriched category, see #link("https://math.stackexchange.com/questions/272479/properties-of-mathbfcat")[The answer of Keith Harbaugh].
    - *Completeness*: There is a general theorem: Reflective full subcategory is closed under limit. (Reason: Every reflective subcategory inclusion is a monadic functor, and monadic functor creat limit. Reference: #link("https://ncatlab.org/nlab/show/reflective+subcategory#ReflectiveSubcategoryInclusionIsMonadic")[Prop 5.1] and #link("https://ncatlab.org/nlab/show/monadic+functor#MonadicFunctorsCreateLimits")[Prop 3.1]).
       
      However, the arbitrary products and equalizer in $"Cat"$ is obvious. So we do not need the above abstract theorem (at least in this proof).
    
      Also see #link("math.jhu.edu/~eriehl/context.pdf")[Riehl Example 4.5.14 (vi), Page 143].

= Localization of categories and reflective full subcategories
  There is a complex relation between localization of categories and reflective full subcategories.
  - The localization can be done on any classes of morphisms $W$ in category $cal(C)$, but when the class $W$ is a _weak equivalence_ (includes all isomorphisms and satisfies the #link("https://ncatlab.org/nlab/show/two-out-of-three")[two-out-of-three rule]) things become smoother.
    - Note that the general localization is also called _category of fractions_.
  - All reflective subcategories are localizations, see #link("https://ncatlab.org/nlab/show/reflective+localization#ReflectiveSubcategoriesAreLocalizations")[Prop 3.1].

= Right adjoints is fully faithful $<==>$ The counit is an isomorphism
  _proof:_ For counit $epsilon: F U -> "Id"_D$, thanks to the triangle equallity we have $U epsilon_d compose eta_(U d) = id_(U d)$, where $eta$ is the unit, we know that there exists a counterpart $l$ of $eta_(U d)$ in $D(x, y)$ such that $epsilon_d compose l = "id"_d$, since $D$ is fullu faithful.

= Properties of monadic functors
For monadic functor $U: cal(D) -> cal(C)$ with left adjoint $F: cal(C) -> cal(D)$ and induced monad $T := U F$, induced comparison functor $K: cal(D) -> cal(C)^T$, we claim that $U$:
  + ... is faithful

    _proof:_ In fact for a monad induced by a general adjunction where the right adjoint is $U$, there is a decomposition of $U$: $U = U^T compose K$ where $U^T: C^T -> C$ is the forgetful functor and $K$ the comparison functor.
  
      Note that $U^T$ is always faithful, so when $K$ is a equivalence their composition is also faithful.
  
    - _Remark:_ A maybe useful observation: For functor $U: cal(D) -> cal(C)$, it is faithful if and only if the induced natural transformation $cal(D)(x, y) -> cal(C)(U x, U y)$ is a monomorphism.
  + ... creats limit

    _proof:_ Here I only make a short description, please draw a diagram by yourself, really, it is benifit for you.

    Suppose $H: J -> cal(D)$ is a diagram, and $"lim" U H$ exists in $cal(C)$ with a bunch of projections $p_i$, we need to construct a limit in $cal(D)$. Thanks to the equivalence between $cal(D)$ and $cal(C)^T$, we need only to construct limit in the later category.

    Define $V := "lim" U H$ We claim that the object $(V, h: U F V -> V)$ is the limit we want, where $h$ is induced by the universal property of $V$ with a bunch of morphisms $U epsilon_(H i) compose U F p_i: U F V -> U H i$. One can verify that $h$ is indeed satisfies the requirements of $cal(C)^T$. (*Warning*: please note that the triangle equallity of $T$-module $(c, v_c: T c -> c)$ is that $v_c compose eta_c = "id"_c$! Caution that the right hand side is _not_ $"id"_(T c)$!).
    
    $V$ is a universal cone in $cal(C)^T$ can be infered from its universal property in $cal(C)$.

    So $"lim" K H$ exists and thus $"lim" H$ does so.

    - _Remark:_ The diagram chasing is cubersome, please also see #link("https://math.stackexchange.com/questions/3632207/creation-of-limits-and-diagram-chasing/3632325")[Disccusion on math exchange].

    

     we need to prove that it both preserves and reflects limits.
      - Preserves limits: Since $U$ is a right adjoint.
      - Reflects limits: Since all faithful functors reflects limits, and $U$ is just faithful.
