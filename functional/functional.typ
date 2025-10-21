////////////////////////////////////////////////////////////////////
///////////////////////////  Settings  ////////////////////////////
////////////////////////////////////////////////////////////////////
#import "@preview/fletcher:0.5.3" as fletcher: diagram, node, edge  // Commutative diagram

#import "@preview/theorion:0.4.0": *  // Theorem environment
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
#set par(first-line-indent: 2em)

// Enable justification
#set par(justify: true)

// Set numbering
#set heading(numbering: "1.")

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
Author: 秦宇轩 (QIN Yuxuan) \
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

参考书目：许全华《泛函分析讲义》。


= 拓扑空间简介
TODO

= 完备度量空间
TODO

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



= Hahn-Banach 定理，弱拓扑、弱 $*$ 拓扑

强形式的 Hahn-Banach 定理 $==>$ 弱形式版本：

#proof[
  假设弱形式的前提成立，即 $(E, || dot ||)$ 是赋范向量空间，$A subset E$ 是子空间，且 $g in cal(B)(A, FF)$，则现在要证明 $g$ 有等范数延拓 $G in cal(B)(E, FF)$，即 $||G|| = ||g||$。

  为使用强版本的 Hahn-Banach 定理，考虑半范数 $p := ||g|| ||dot||$（实际上是范数），显然对任意 $x in A$ 有 $||g x|| <= p(x)$，所以根据强版本 Hahn-Banach 定理，$g$ 有延拓 $G in cal(B)(E, FF)$，且满足

  $ ||G(x)|| <= p(x) = ||g|| ||x||. $

  这告诉我们 $||G|| <= ||g||$.

  注意到 $G|_A = g$，显然有 $||G|| >= ||g||$，所以最终得到了 $g$ 的等范数延拓 $G$，证毕。
]
