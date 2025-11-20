////////////////////////////////////////////////////////////////////
///////////////////////////  Settings  ////////////////////////////
////////////////////////////////////////////////////////////////////
#import "@preview/fletcher:0.5.5" as fletcher: diagram, node, edge  // Commutative diagram

#import "@preview/theorion:0.4.1": *  // Theorem environment
// #import cosmos.fancy: *
#import cosmos.rainbow: *
// #import cosmos.clouds: *
#show: show-theorion

#show link: set text(red)
// Fonts
#set text(lang: "zh", region: "cn")
#set text(font: (
  (name: "libertinus serif"),
  "Noto Serif CJK SC"
))

// Paragraph indent
#set par(first-line-indent: 2em)

// Enable justification
#set par(justify: true)

// Set numbering
#set heading(numbering: "1.")

#let iso = symbol("≅")

////////////////////////////////////////////////////////////////////
////////////////////////////  Title  ///////////////////////////////
////////////////////////////////////////////////////////////////////
// Title
#align(center, text(17pt)[
  泛函分析提纲
])

// Author and date
#grid(
  columns: (1fr),
  align(center)[
著者: 秦宇轩 (QIN Yuxuan) \
最后更新于 #datetime.today().display() \
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

这是一份泛函分析提纲（不是笔记！），仅包含我认为重要的结论。

参考书目：
+ 许全华《泛函分析讲义》。
+ 朱森《泛函分析讲义》（吉林大学内部教材）


= 拓扑空间简介
TODO

= 完备度量空间
#theorem(title: "Arzela-Ascoli 定理")[
  有很多版本，许全华上面的更深一些，不过这里只记录吉大讲义版本：

  设 $(X, d)$ 是*紧度量空间*，$E subset C(X)$ 是一族连续函数，则 $E$ 列紧等价于以下两个条件同时成立：
  - $E$ 中函数*一致有界*；
  - $E$ 中函数*同等连续*，即对任意 $epsilon >0$，存在 $delta$ 使得
    $ sup_(f in E) sup_(x, y in X\ d(x, y) < delta) |f(x) - f(y)| < epsilon. $
]

#theorem(title: "Montel 定理")[
  设 $cal(F) := {f_n}_(n in NN) subset "Hol"(Omega)$ 是一列在区域 $Omega$ 上一致有界的解析函数，则对任意*完全位于* $Omega$ *内的有界区域* $D$（即 $overline(D) subset Omega$），$cal(F)$ 恒有子列在 $D$ 上一致收敛。
]
#proof[
  要用 Arzela-Ascoli 定理。核心思想是利用 $D$ 的有界性得出 $overline(D)$ 的紧性，然后通过 Cauchy 积分公式得出 $cal(F)$ 在 $overline(D)$ 的某一个开覆盖上都同等连续，然后由紧性，可以抽有限次，得到一致收敛的子子子子子列。
]

如果需要举 “一致连续但不同等连续”…… 之类的例子，可以用这族函数 ${f_n (x) := (-1)^n + x^n}$，这族函数在 $C[-1/2, 1/2]$ 中既一致有界又同等连续，但在 $C[-2, 2]$ 中这两个性质都不具备。详见朱森例 1.72.

= 赋范空间、连续线性映射
#definition(title: "等价的范数")[
  线性空间 $X$ 上的两个范数 $p_1, p_2$ 若诱导出相同的拓扑，则称这两个范数等价。
]
#remark[
  等价范数保持紧性、线性空间的完备性。
]

#theorem(title: "有限维线性空间上的所有范数都等价")[
  如其名。
]
#proof[
  基本思想：范数等价是等价关系，只需证明所有范数和某一个范数等价即可。

  通常做法是证明任意范数 $p$ 和最大模范数 $|| dot ||_oo$ 等价。设 $x in KK^n$ 是任意向量。

  - $p(sum_(k <= n) x_k e_k ) <= p(sum_(k <= n) e_k) dot max_k |x_k| = p(sum_(k <= n) e_k) dot ||x||_oo$，则取 $C_1 = p(sum e_k)$ 即可。

  - 另一个方向要用到单位球面的紧性，注意 $p: (KK^n, || dot ||_oo) -> [0, +oo)$ 连续，则因单位球面紧，$p$ 取到最小值 $C_2$，则
    $ p(x) = ||x||_oo p(x/(||x||_oo)) >= C_2 ||x||_oo. $
    因为 $x/(||x||_oo)$ 在单位球面上。
]
#remark[
  + 证明第二点中声称单位球面紧，当然可以通过欧氏空间的一般理论得到，但是下文提到的 Riesz 表示定理能给一种通用证明。
  + 因 $(KK^n, ||dot||_oo)$ 完备且等价范数保持一些良好性质（参考上一个注解），知任何有限维赋范空间都是 Banach 空间，且有界闭集 $<==>$ 紧集。
]

下面我们展示无穷维空间中两个不等价的范数：

设 $C([0, 1])$ 表示 $[0, 1]$ 上的全体实连续函数，$f in C([0, 1])$，定义 $||f||_oo := sup |f|$ 为最大模范数，容易证明这个范数完备。

再定义 $L^1$ 范数 $||f||_1 := integral_0^1 |f|$，这个范数不完备。

#theorem(title: "Riesz 定理")[
  设 $(E, ||dot||)$ 是赋范空间，则 $E$ 有限维 $<==>$ 单位闭球 $overline(B)(0, 1)$ 紧。
]

#proposition(title: [Banach 空间中的子空间有限维 $==>$ 闭])[
]

#proposition(title: [$E$ 是 Banach 空间 $<==>$ 绝对收敛级数都收敛])[]

== 连续线性映射
#theorem(title: [连续 $<==>$ 有界])[
  设 $f: X -> Y$ 是赋范空间之间的线性映射，则 $f$ 连续 $<==>$ $f$ 有界。
]
#proof[
  - $f$ 连续，则在 $0$ 附近小于 $1$，因 $f(0) = 0$，则存在 $r$，对任意 $x in X$，有 $||f(r dot x/(||x||))|| < 1$，知 $f$ 有界。
  - 另一个方向显然。
]

所以，为了在研究中充分利用赋范线性空间上的几何信息，我们通常只考虑有界线性映射，记为 $cal(B)(X, Y)$。

容易证明 Banach 空间和有界线性映射构成范畴，记为 $bold("Ban")$。

#theorem[
设 $E$ 是赋范空间，$F$ 是 Banach 空间，$U$ 有限维赋范空间，则

- $cal(B)(E, F)$ 也是 Banach 空间；
- $cal(L)(U, E) = cal(B)(U, E)$；
]
#proof[
  - 第一点：不难；
  - 第二点：有限维赋范空间上的所有范数都等价，外加三角不等式足矣。
]

== $L_p$ 空间
#definition(title: [$L_p$ 空间])[
  设 $(Omega, cal(S), mu)$ 是一个测度空间，若 $f: Omega -> KK$ 满足
  $ integral_Omega |f|^p d mu < oo, $
  则称其为 $p$-方可积。

  定义 $L_p (Omega)$ 为在测度意义下相等的全体 $p$-方可积函数。

  定义
  $ ||f||_p := (integral_Omega |f|^p d mu)^(1/p). $
]


#theorem(title: "Holder 不等式")[
  设 $p, q in (0, +oo]$ 且 $1/p + 1/q = 1/r$，若 $f in L_p (Omega), g in L_q (Omega)$，则 $f g in L_r (Omega)$ 且
  $ ||f g||_r <= ||f||_p ||g||_q. $
]
#remark[
  当 $p = q = 2$ 时，这个不等式告诉我们
  $ integral |f g| <= ||f||_2 ||g||_2, $
  因此我们可以在 $L_2(Omega)$ 上定义内积 $(f, g) := |integral f g| < integral |f g|$ 存在。

  有了内积，就可以利用 Hilbert 空间的理论了，这可以算是 Fourier 分析的开端。
]

我们为什么研究 $L_p$ 空间？

#theorem(title: [$||dot||_p$ 是个范数，再不济也能诱导一个度量])[
  - 当 $p in [1, +oo]$ 时，$||dot||_p$ 是 $L_p$ 上的范数，记诱导出的度量为 $d_p$；
  - 当 $p in (0, 1)$ 时，$d_p (f, g) := ||f - g||_p^p$ 是度量。
]
#remark[
  这两个结论直接来源于 Минковский 不等式：
  - For all $p in [1, +oo]$, we have $||f + g||_p <= ||f||_p + ||g||_p$;
  - For all $p in (0, 1)$, we have $||f + g||_p^p <= ||f||_p^p + ||g||_p^p$.
]

#theorem(title: "终极之梦")[
  对于任意 $p in (0, +oo]$，$(L_p, d_p)$ 完备。
]

关于可分性

#example[
  $l_p$ 和 $L_p$ 在 $p in [1, +oo)$ 时都可分。
]

= Hilbert 空间
Hilbert 空间就是*完备内积空间*。由于配备了性质良好的内积，Hilbert 空间的对偶空间和其本身等距同构（Riesz 表示定理），这和普通的赋范向量空间不同，后者的对偶空间通常不同构于本身。




= 拓扑向量空间
== 基本定义
拓扑向量空间：加法和数乘在拓扑意义下连续的向量空间。

#definition(title: "两种神秘集合")[
设 $E$ 是数域 $FF$ 上的向量空间，$A subset E$ 是子集（不必是子空间！），则定义：

  - *平衡集*：若取任意标量 $|lambda| <= 1$，对任意 $x in A$ 有 $lambda x in A$，则称 $A$ 平衡；
  - *吸收集*：若取任意 $x in A$，存在 $alpha > 0$，对任意标量 $|lambda| <= alpha$ 有 $lambda x in A$，则称 $A$ 吸收。
]

#remark[
- 对任意集合，取内部保持凸性； 
- 对于 $0$ 附近的集合，取内部保持平衡性。
]

== 半赋范空间
半赋范空间就是配备了*半范数拓扑*的*向量空间*，因此，本节所出现的空间不都是拓扑向量空间，请注意定义。

#definition(title: "半范数")[
  设 $E$ 是 $FF$ 上的向量空间，且 $p: E -> FF$ 是线性泛函，若：
    - *非负*：对任意 $x in E$，有 $p(x) >= 0$；
    - *正定*：对任意 $x in E, lambda in FF$，有 $p(lambda x) = |lambda| p(x)$；
    - *三角不等式*；
  则称 $p$ 是一个半范数。
]

和范数一样，半范数能诱导拓扑，但是半范数的性质决定了诱导拓扑的性质不会很好，具体而言：

#proposition(title: "Hausdorff 等价于范数")[
半范数 $p$ 诱导的拓扑 Hausdorff，当且仅当 $p$ 是范数。
]

正是如此，我们常常考虑一族半范数所诱导的拓扑，希望能得到 Hausdorff 拓扑。具体而言，考虑定义在 $E$ 上的一族半范数 ${p_i}_(i in I)$，定义这族半范数所诱导的拓扑为 $tau$：对任意 $O subset E$，定义 $O in tau$ 当且仅当存在指标集 $Lambda$ 使得

$ O = union.big_(alpha in Lambda) B_i (x_i, r_i), $

其中，$B_i (x_i, r_i)$ 是 $p_i$ 诱导拓扑中的开球。

但是这样可能会得到不相容的开集：按定义，我们需要验证开集公理，任意并公理是显然的，问题出在有限交公理。

因此，我们需要对半范数族加一些限制。

#definition(title: "定向半范数族诱导的拓扑")[
如果 ${p_i}$ 是一族*定向的*半范数，则上文所述的联合拓扑良定义。
]

对于一般的半范数族，我们有办法让它成为定向族：

#definition(title: "半范数族的定向化")[
设 $E$ 是向量空间，对 $E$ 上一族（任意规模的）半范数 ${p_i}_(i in I)$，我们可以加入一些新的半范数，使其成为一个定向集，具体构造如下：

对于任意有限子集 $J subset I$，定义一个新的半范数 $q_J$，对 $x in E$，令

$ q_J(x) := max_(j in J) p_j (x). $

可以验证，这样的到的东西仍是半范数，并且是 ${p_j}_(j in J)$ 的上界。

因此，我们得到了原族的定向化：

$ {p_j} union.big {q_J: J subset I "有限"}. $
]

#definition(title: "一般半范数族诱导的拓扑")[
指其定向化后诱导的拓扑。
]

#remark[
半范数族 ${p_i}$ 所诱导的拓扑 Hausdorff $<==>$ ${p_i}$ 可分点，即对任意 $x != 0$，存在 $p_i$ 使 $p_i (x) != 0$.

配合这个结论，Hahn-Banach 定理告诉我们，在 Hausdorff 局部凸空间中，非平凡的线性泛函足够多。
]

有了半范数族诱导的拓扑以后，我们的向量空间具备了双重结构，我们希望拓扑结构和代数结构相容，所幸的确如此：

#theorem(title: "半范数族诱导的拓扑结构与代数结构相容")[
TODO
]

#definition(title: "半赋范空间")[
向量空间 $E$ 配备一族半范数 ${p_i}$ 拓扑，就称为半赋范空间，记为 $(E, {p_i})$
]

#theorem(title: "半赋范空间的凸邻域基")[
半赋范空间 $(E, {p_i})$ 的原点有一组凸邻域基。
]
#proof[
我们可以直接写出来这组凸邻域基：原点附近的全体开球。
]

#remark[半赋范空间的积仍然是半赋范空间。]
#proof[TODO]

== 局部凸空间
上节提到，半赋范空间的原点具备凸邻域基，本节证明其逆命题也成立。

#definition(title: "局部凸空间")[
若拓扑向量空间 $E$ 的原点有一组*凸邻域基*，则称其为*局部凸空间*。
]

#theorem(title: "局部凸空间有美妙的原点邻域基")[
设 $E$ 是局部凸空间，则其在原点处有一组*凸的平衡开邻域基*。
]
#remark[
有了这个性质，我们就能构造一族 Минковский 泛函，又因为 Минковский 泛函都是半范数，我们就得到了一族半范数，而这族半范数正好能诱导出我们需要的拓扑。
]


本节的主要目标是：若 $E$ 是拓扑向量空间，则有 $E$ 局部凸 $<==>$ $E$ 半赋范。

半赋范推局部凸的那个方向，上一节已经证过。

现在假设 $E$ 局部凸，我们要构造一族半范数，使得这族半范数诱导的拓扑和原来的拓扑一致。Минковский 构造了如下泛函：

#definition(title: "Минковский 泛函")[
设 $E$ 是拓扑向量空间，$Omega$ 是原点处的*凸平衡开邻域*，则称泛函 $p_Omega: E -> RR$,
$ p_Omega (x) := inf {lambda > 0: x/lambda in Omega} $
为对应于 $Omega$ 的 Минковский 泛函。
]
#remark[

]

= Baire 纲定理

#theorem(title: "开映射定理")[
若 $E, F$ 都是 Banach 空间，$u in cal(B)(E, F)$ 满足 $u(E) subset F$ *不是*贫集，则以下两论断成立：

+ 存在 $r > 0$ 使得 $r B_F subset u(B_E)$，进而得知 $u$ 满；
+ $u$ 开；
]
#corollary[
满则自动开；
]

#theorem(title: "闭图像定理")[
这是一个判断线性映射是否有界的定理。

若 $E, F$ 是 Banach 空间，$u in cal(L)(E, F)$，则：$u$ 有界 $<==>$ $u(E)$ 闭。
]
#remark[
有了这个定理，为证某些线性算子连续（也就是有界），只需要证明其像闭。
]



= Hahn-Banach 定理，弱拓扑、弱 $*$ 拓扑

强形式的 Hahn-Banach 定理 $==>$ 弱形式版本：

#proof[
  假设弱形式的前提成立，即 $(E, || dot ||)$ 是赋范向量空间，$A subset E$ 是子空间，且 $g in cal(B)(A, FF)$，则现在要证明 $g$ 有等范数延拓 $G in cal(B)(E, FF)$，即 $||G|| = ||g||$。

  为使用强版本的 Hahn-Banach 定理，考虑半范数 $p := ||g|| ||dot||$（实际上是范数），显然对任意 $x in A$ 有 $||g x|| <= p(x)$，所以根据强版本 Hahn-Banach 定理，$g$ 有延拓 $G in cal(B)(E, FF)$，且满足

  $ ||G(x)|| <= p(x) = ||g|| ||x||. $

  这告诉我们 $||G|| <= ||g||$.

  注意到 $G|_A = g$，显然有 $||G|| >= ||g||$，所以最终得到了 $g$ 的等范数延拓 $G$，证毕。
]

利用 Hahn-Banach 定理，我们可以通过研究对偶空间来获得关于原空间的信息，具体的结论如下：

#theorem(title: "赋范空间到双对偶空间的等距嵌入")[
  设 $E$ 是赋范空间，则对任意 $x in E$，有
  $ ||x|| = sup_(f in E^*\ ||f||<=1) |f(x)|. $
]
#corollary[
  上述定理实际上在说下面这个映射是等距嵌入：
  $ E -> E^(**), x |-> ["ev"_x: f |-> f(x)]. $
  
  #proof[只需要观察到 $"ev"_x: E^* -> KK$ 满足
  $ ||"ev"_x|| = sup_(f in E^*\ ||f|| <= 1) |"ev"_x (f)| $
  即可。]

  这里，固定 $x in E$，则对于任意 $f in E^*$，有 $|"ev"_x (f)| <= ||f|| dot ||x||$，这意味着 $"ev"_x$ 的确是*有界*线性泛函，故而也连续，即 $"ev"_x in E^(**)$ 是良定义的。
]

另外几个结论，可以作为 Hahn-Banach 定理应用的实例：

#proposition[
  对于任意非零元 $x_0 in E$，存在 $f in E^*$ 使得 $||f|| = 1$，且
  $ f(x_0) = ||x_0|| $
]
#proof[
  定义 $phi: KK x_0 -> KK, k x_0 |-> k ||x_0||$，这显然线性，且 $||phi|| = 1$，$phi(x_0) = ||x_0||$，则根据 Hahn-Banach 定理，存在 $phi$ 的等范数延拓 $Phi in E^*$，容易验证这个 $Phi$ 满足要求。
]

#proposition(title: "隔离")[
  设 $M$ 是赋范线性空间 $E$ 的真闭子空间，$x in E \\ M$，则存在 $f in E^*$，使得以下条件同时成立：
  - $f(x) = 1$;
  - $f(M) = bold(0)$;
]<isolation>

#proof[
  定义 $f: M plus.o KK x -> KK, (m + k x) |-> k$, 这显然线性，至于有界性，只需注意
  $ ||f|| &= sup_(m, k) {|f(m + k x) / (||m + k x||) |} \
          &= sup_(m, k) {1/(||x + m / k ||)} \
          &= 1/("dist"(x, M)).
  $
  因 $M$ 闭，知 $||f||$ 有界。

  利用 Hahn-Banach 定理，立刻得到 $f$ 的延拓，即为所求。
]

利用上面的命题，我们可得如下结果，宗旨仍是通过研究对偶空间获得原空间的信息：

#theorem(title: [稠密 $<==>$ 话语权])[
  设 $M subset E$ 是赋范线性空间的子空间，则以下两论断等价：
  
  + $M$ 在 $E$ 中稠密；
  + 对任意 $f in E^*$，有 $f|_M = 0$ 蕴含 $f = 0$.
]

#definition(title: "零化子")[
我们顺势引入 “零化子”（annihilator） 的概念：对赋范线性空间 $E$ 及其非空子空间 $M subset E$，定义其零化子为
  $ "ann"_E (M) := M^0 := {f in E^* : f|_M = 0}. $
]<ann>

#remark[
有了这个定义，本定理可表述成：$M subset E$ 稠密 $<==> "ann"_E (M) = 0$.  

也就是说，零化子刻画了子空间的*非稠密程度*，譬如对于最不稠密的子空间 ${0}$，我们有 $"ann"_E ({0}) = E^*$，是全空间，所以 ${0}$ 必定非稠密。
]

#theorem(title: [$X^*$ 可分 $==> X$ 可分])[
设 $X$ 是 Banach 空间，则 $X^*$ 可分 $==> X$ 可分。
]<seperation>

这个定理可以用来证明如下结果：

#theorem(title: [Banach 空间 $E$ 自反 $<==>$ 它的对偶也自反])[
  如题
]<dual>
#proof[
- ($==>$) 容易；
- ($<==$) 设 $E^*$ 自反，即 $E^* = (E^*)^(**) = (E^(**))^*$，为证 $E = E^(**)$，可考虑证明 $iota(E) subset E^(**)$ 稠密且闭，这在任何拓扑空间中都蕴含 $iota(E) = E^(**)$，其中 $iota$ 是典范嵌入。
  - 根据@seperation，为证 $E subset E^(**)$ 稠密，只需证明对任意 $f in (E^(**))^*$，有 $f|_E = 0 ==> f = 0$。如果确有 $f|_E = 0$，则因 $E^* = (E^(**))^*$，得到 $f = 0$，所以 $E$ 在 $E^(**)$ 中稠密；
  - 因为 $E$ 是 Banach 空间，$E$ 在 $E^(**)$ 中闭。
]


#proof[
设 $cal(F) = {f_n}_(n in NN) subset X^*$ 是一个可数稠密子集。按范数定义，存在一列 ${x_n}_(n in NN) subset X$ 使得
$ ||f_n (x_n)|| >= (||f_n||)/2. $

令 $E := {x_n}$，我们将证明 $E$ 是稠密的，从而证明 $X$ 可分。

下面定义 $E$ 的闭张开 $or E := overline("span" E)$，按定义，$E$ 稠密 $<==> or E = X$。

反证法：若 $or E$ 真包含于 $X$，则根据@isolation，我们得到了 $f in X^*$，且其满足
- $||f|| = 1$；
- $f(or E) = 0$. 

此时，可以利用 $cal(F)$ 了。由假设知存在 ${n_k}$ 使得 $f_(n_k) -> f$，这意味着 $||f_(n_k) - f|| -> 0$。因 $||f|| = 1$，进一步有 $f_(n_k)/(||f_(n_k)||) -> f$，但
$ ||f_(n_k)/(||f_(n_k)||) - f|| > ||(f_(n_k)(x_(n_k)))/(||f_(n_k)||) - f(x_(n_k))|| = ||(f_(n_k)(x_(n_k)))/(||f_(n_k)||) - 0||, $

最终，由 $x_(n_k)$ 的定义，知最后的表达式 $> 1/2$，这和我们刚才得到的结论矛盾。
]

#remark[
如果 $X$ 自反，则 $X^*$ 可分 $<==> X$ 可分，因为此时 $X^(**) = X$，然后就可以用@seperation。
]

关于自反空间，我们还有如下结果：
#theorem(title: "Pettis 定理")[
  自反性是闭可遗传的：自反 Banach 空间 $X$ 的闭子空间 $M$ 也是自反的。
]<pettis>

= Banach 空间的对偶理论
在本章中，我们研究对偶理论，所用符号如次：
+ $iota: E -> E^(**)$ 是典范等距嵌入，$iota(x)$ 简记为 $hat(x)$；
+ 设 $E$ 是 Banach 空间，定义标准配对 $chevron.l -, - chevron.r: X^* times X -> FF$ 为
  $ chevron.l x^*, x chevron.r:= x^*(x), $
  这个运算显然是双线性的；

== 共轭算子
Banach 空间的共轭算子推广了 Hilbert 空间的概念，核心思想是用标准配对模拟内积

#theorem(title: "共轭算子")[
对赋范空间 $E$ 和 $F$，设 $u in cal(B)(E, F)$，则断言存在唯一的 $u^* in cal(B)(F^*, E^*)$ 满足：
+ $chevron.l u^*(f^*), x chevron.r = chevron.l f^*, u(x) chevron.r.$
+ $||u^*|| = ||u||$；
]

#proof[
+ 存在性：直接定义 $u^*$ 为拉回 $u^*(f^*) := f^* compose u$ 即可；至于连续性，注意到
  $ ||u^*(f^*)|| = ||f^* compose u|| <= ||f^*|| ||u|| $
  上式不等式乃是熟知的一般性结果；
+ 唯一性简单；
+ 至于保范数，要用到 Hahn-Banach 定理，有点啰嗦，详见许全华定理 9.1.1。
]

#remark[
保范性告诉我们 $(-)^*: cal(B)(E, F) -> cal(B)(F^*, E^*)$ 是线性等距嵌入。（等距映射都是单射，所以叫嵌入）
]

当 $E, F$ 均为 Banach 空间时，一切都变得更美妙了：

#theorem(title: [$u$ 可逆 $<==> u^*$ 可逆])[
当 $E, F$ 均为 Banach 空间时，题目成立。
]
#proof[
见吉大讲义命题 2.172。
]


== 对零化子的研究
前面的@ann 已经定义过零化子，现在来研究零化子的一般性质（以及为什么要研究这种东西）。本小节中，我们假设 $X$ 是赋范线性空间，$E subset X$ 非空。

Hahn-Banach 定理告诉我们，对于任意 $f in E^*$，我们可以把他保范延拓成 $tilde(f) in X^*$，同时，通过取限制，对于任意 $tilde(f) in X^*$，我们可以得到一个 $tilde(f)|_E in E^*$，也就是说，我们得到下图：

#align(center, diagram({
   node((-1, 0), [$E^*$])
   node((1, 0), [$X^*$])
   edge((-1, 0), (1, 0), [$"Hahn-Banach"$], label-side: left, "->", bend: 36deg)
   edge((1, 0), (-1, 0), [$"Restriction"$], label-side: left, "->", bend: 36deg)
}))

所以，他们之间到底是什么关系？（*警告*：虽然我们都很想，但是这两个 “对应” 的复合不会是恒同，因为 Hahn-Banach 所提供的延拓不唯一。）

#proposition[
$E^0 = (overline(E))^0$ 是 $X^*$ 的子空间，理由：
$ E^0 &= {f: f|_E = 0}, \
      &= {f: E subset ker f}, \
      &= {f: overline(E) subset ker f}, " since" f "is continuous" \
      &= overline(E)^0. $
]

下面定义零化子：

#definition(title: "零化子")[
对赋范线性空间 $E$ 及其非空子空间 $M subset E$，定义其零化子为
  $ "ann"_E (M) := E^perp := M^0 := {f in E^* : f|_M = 0}. $
是的，第一个符号是我自创的，第二个符号是许全华标准，第三个符号是吉大标准。
]

#definition[
对于 $F subset X^*$ 非空，定义它的零化子（或称*预零化子*、下零化子）为
$ "ann"^*_X (F) := F_perp := attach(F, tl: 0) := inter.big_(f in F) ker f. $

请注意：现在对于对偶空间 $E^*$，我们有零化子和下零化子两种概念，一般来说，它们是不一样的，即 $"ann"_(X^*) != "ann"^*_X$，TODO：例子？
]

总结一下，我们现在有两种零化子：
#align(center, diagram({
   node((-1, 0), [$"sub"(X)$])
   node((1, 0), [$"sub"(X^*)$])
   edge((-1, 0), (1, 0), [$"ann"_X (-)$], label-side: left, "->", bend: 36deg)
   edge((1, 0), (-1, 0), [$"ann"^*_X (-)$], label-side: left, "->", bend: 36deg)
}))

这两个映射的方向正好相反，所以我们好奇如果复合它们，会发生什么。

#lemma(title: "两种零化子之间的关系")[
设有赋范线性空间 $X$，$iota: X -> X^(**)$ 是典范等距嵌入，$M subset X$ 和 $G subset X^*$ 均是闭子空间，则
  + $M = "ann"^*_X ("ann"_X (M))$；
  + $G subset "ann"_X ("ann"^*_X (G))$；
  + 如 $X$ 自反，则 2 取等；
]

#proof[
+ 由 Hahn-Banach 定理，$x in.not M <==> exists f in X^*, f|_M = 0 and f(x) != 0$，则取否有
  $ x in M <==> (f in "ann"_X (M) => f(x) = 0), $
  右边就是说 $x in "ann"^*_X ("ann"_X (M))$.

+ 类似；
+ 类似；
]

== 商空间和子空间的对偶空间
零化子能帮助我们研究*闭子空间* $F^*$ 和 $E^*$ 之间的关系。

在开始之前，我们必须定义商空间

#definition(title: "商空间")[
设 $F subset E$ 是 *闭子空间*，则可在商空间 $E slash F$ 上定义范数，对于 $[x] in E slash F$，定义：
$ ||[x]|| := inf {||y||: y ~ x} = inf {||x + e||: e in E}. $

闭子空间对极限封闭，这样才能保证 $||[x]|| = 0 <==> [x] = 0$.
]

#theorem(title: "对偶定理")[
设 $F subset E$ 是 *闭子空间*，则
+ $(E slash F)^* tilde.equiv F^perp$；
+ $F^* tilde.equiv E slash F^perp$；
]

这个定理可以用来证明一些维数相关的东西，譬如这题：

#proposition[
  设 $X$ 是赋范线性空间，$E = chevron.l x_1,..., x_n chevron.r subset X$ 是 $n$ 维子空间，则 $"codim" E^perp = n$.
]

#proof[
按定义，$"codim" E^perp = dim (X^* slash E^perp)$，由对偶定理，这等于 $dim E^* = n$（请注意有限维子空间都是闭的）
]

另一个用到对偶定理的结果（和@pettis 对照着看）：

#proposition[
  设 $X$ 是自反 Banach 空间，$M subset X$ 是闭子空间，则 $X slash M$ 也是自反空间。
]

#proof[
因 $M$ 闭，由对偶定理 $(X slash M)^* iso M^perp subset X^*$.

另外，熟知 $X^*$ 也是 Banach 空间，又 $M^perp subset X^*$ 是闭子空间，则 $M$ 也是 Banach 空间。

由@dual，$X^*$ 也自反。最终，由 Pettis 定理（@pettis），得到 $M^perp$ 也自反。

由于同构，$(X slash M)^*$ 是 Banach 空间且自反，此时再用@dual，得到 $X slash M$ 也自反！
]

#remark[
这题很不错，我们总共用到了如下结论：

+ Banach 空间的闭子空间依然是 Banach 空间；
+ Banach 空间自反 $<==>$ 它的对偶空间也自反；
+ Banach 空间的自反性是闭传递的，也就是说，自反 Banach 空间的闭子空间依然是自反的。

本题的结论可以说加强了上述第三点：自反性是闭商传递的！
]


