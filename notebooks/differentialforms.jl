### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ f66c5349-258a-4218-81f9-57d86b1f9c34
using Plots

# ╔═╡ ffd4c917-7cd5-46c8-bba1-58e4b4fc47b9
using PlutoUI

# ╔═╡ 90fb24e0-c88b-11eb-3a76-7712f64d0d6f
md"# Notes on Manifolds and Differential Forms"

# ╔═╡ 273c5aa8-e0b2-4139-89a9-ac4cd7a51464
md"Personal notes on based on my reading of Reyer Sjamaar's lecture notes on [Manifolds and Differential Forms](http://pi.math.cornell.edu/~sjamaar/teach.html)."

# ╔═╡ 2da4aa34-44b6-4d61-8378-2165a7da73af
TableOfContents(; depth = 4)

# ╔═╡ f8f45f3b-e0b3-46e5-bf5b-7a77b750ee29
md"A *differential form of degree k* or a *k-form* on ``\mathbb{R}^n`` is an expression

$$\alpha = \sum_I f_I dx_I.$$"

# ╔═╡ 74112867-542a-4e7a-b695-991830f7f04a
md"``I`` is a multi-index ``(i_1, i_2, \ldots, i_k)`` of *degree* ``k`` -- a vector consisting of ``k`` integer entries ranging between ``1`` and ``n``.  The ``f_I`` are smooth function on ``\mathbb{R}^n`` called the coefficients of ``\alpha`` and ``dx_I`` is an abbreviation for

$$dx_{i_1} dx_{i_2}\cdots dx_{i_k}.$$

Some authors use

$$dx_{i_1} \wedge dx_{i_2} \wedge \cdots \wedge dx_{i_k}$$

to distinguish this product from the tensor product.
"

# ╔═╡ 6ef9ce1d-e64b-43c9-aabd-eaae3b9c946d
md"**Example** 

$$\alpha = \sin(x_1 + e^{x_4})dx_1dx_5 + x_2 x_5^2dx_2dx3 + 6dx_2dx_4 + \cos x_2dx_5dx_3$$

and

$$\beta = x_1x_3x_5dx_1 dx_6 dx_3 dx_2$$

represent a ``2``-form on ``\mathbb{R}^5`` and a ``4``-form on ``\mathbb{R}^6``, respectively.  The form ``\alpha`` consists of four terms corresponding to the multi-indices ``(1, 5), (2, 3), (2, 4),`` and ``(5,3)``.  The form ``\beta`` consists of one term, correpsonding to the multi-index ``(1,6,3,2)``.

Note, however, that ``\alpha`` could equally well be regarded as a ``2``-form on ``\mathbb{R}^6`` that does not involve the variables ``x_6``.  To avoid such ambiguities it is good practice to state explicitly the domain of the definition when writing the differential form.

Another reason for being precise about the domain of a form is that the coefficients ``f_I`` may not be defined on all of ``\mathbb{R}^n``, but only an open subset ``U \subseteq \mathbb{R}^n``.  In such a case we say ``\alpha`` is a ``k``-form on ``U``.  Thus the expression ``\ln(x^2 + y^2)zdz`` is not a ``1``-form on ``\mathbb{R}^3``, but on the open set ``U = \mathbb{R}^3 \setminus \{(x, y, z) | x^2 + y^2 \not= 0\}``."

# ╔═╡ a04ad4d6-225c-4e2e-b81f-25914dc7b743
md"Think of ``dx_i`` as an infinitesimal increment in the variable ``x_i`` and of ``dx_I`` as the volume of an inifinitesimal ``k``-dimensional rectangular block with sides ``dx_{i_1}, dx_{i_2}, \ldots, dx_{i_k}``.  A more precise definition is given in Section ``7.2``.  By volume we here mean *oriented* volume, which takes into account the order of the variables.  Thus, if we interchange two variables, the sign changes:

$$dx_{i_1} dx_{i_2} \cdots dx_{i_q} \cdots dx_{i_p} \cdots dx_{ik} = -dx_{i_1} dx_{i_2} \cdots dx_{i_p} \cdots dx_{i_q} \cdots dx_{i_k}.$$

This is called *anticommutativity* or *graded commutativity*, or the *alternating property*.  In parcticular, this rule implies ``dx_i dx_i = -dx_i dx_i``, so that ``dx_i dx_i = 0`` for all ``i``."

# ╔═╡ a5255eb1-0d70-4f3d-8ee8-f3a6fd6d3375
md"**Examples**

* A ``0``-form on ``\mathbb{R}^n`` is simply a smooth function ``f``, no ``dx``s.
* A general ``1``-form on ``\mathbb{R}^n`` is

$$f_1 dx_1 + f_2 dx_2 + \ldots + f_n dx_n$$

* A general ``2``-form on ``\mathbb{R}^n`` is

$$\begin{aligned} \sum_{i,j} f_{i,j}dx_i dx_j = & f_{1,1}dx_1 dx_1 + f_{1,2}dx_1 dx_2 + \ldots + f_{1,n}dx_1 dx_n + \\ & f_{2,1}dx_2 dx_1 + f_{2,2}dx_2 dx_2 + \ldots f_{2,n}dx_2 dx_n + \\
& \ldots  + \\
& f_{n,1} dx_n dx_1 + f_{n,2}dx_n dx_2 + \ldots + f_{n,n}dx_n dx_n \end{aligned}$$

Because of the alternating property (see [Section 2.1](#2.1)), the terms ``f_{i,i}dx_i dx_i`` vanish and a pair of terms ``f_{1,2}dx_1 dx_2`` and ``f_{2,1}dx_2 dx_1`` can be grouped as ``f_{1,2}dx_1 dx_2 + f_{2,1}dx_2 dx_1 = (f_{1,2} - f_{2,1})dx_1 dx_2``.  We can thus re-write any ``2``-form into at most 

$$n-1 + n-2 + \ldots + 2 + 1 = 0.5 * n * (n - 1)$$

components.

* A general ``n-1``-form can be written as a sum of ``n`` components

$$f_1 dx_2 \cdots dx_n + f_2 dx_1 \cdots dx_n + \ldots + f_n dx_1 + dx_{n-1} = \sum_{i=1}^n f_i dx_1 \cdots \widehat{dx}_i \cdots dx_n$$

where ``\widehat{dx}_i`` is short hand for the full ``n``-form where the factor ``dx_i`` is omit.

* Every ``n``-form on ``\mathbb{R}^n`` can be written as ``f dx_1 dx_2 \cdots dx_n``.

* The special ``n``-form ``dx_1 \cdots dx_n`` is known as the *volume form*.

* Forms of degree ``k > n`` on ``\mathbb{R}^n`` are always ``0``, because at least one variable has to repeat in any expression ``dx_{i_1} \cdots dx_{i_k}``.  By convention forms of negative degree are ``0``.
"

# ╔═╡ 1b63a8d0-309a-4dc6-80c9-01d354917bb7
md"In general a form of degree ``k`` is written

$$\alpha = \sum_I f_I dx_I$$

where the ``I`` are increasing multi-indices, ``1 \leq i_1 < i_2 < \ldots < i_k \leq n``.  The total number of increasing multi-indices of degree ``k`` is ``{n \choose k}``."

# ╔═╡ e4355bf9-546a-4a08-8d34-f5beebf7f091
md"Two ``k``-forms ``\alpha = \sum_I f_I dx_I`` and ``\beta = \sum_I g_I dx_I`` are considered equal iff ``f_I = g_I`` for all ``I``."

# ╔═╡ ae8fd591-ca24-4f29-ab68-ddf310a73456
md"The collection of all ``k``-forms on an open set ``U`` is denoted ``\Omega^k(U)``.  Since ``k``-forms can be added together and multiplied by scalaras, the collection ``\Omega^k(U)`` constitutes a vector space."

# ╔═╡ 6aa73bcd-a0a8-434a-b054-49a748294ebe
md"A form is *constant* if the coefficients ``f_I`` are constant functions.  The set of constant ``k``-forms is a linear subspace of ``\Omega^k(U)`` of dimension ``{n \choose k}``. A basis of this subspace is given by the forms ``dx_I``, where ``I`` ranges over all increasing multi-indices of degree ``k``.  The space ``\Omega^k(U)`` itself is infinit-dimensional."

# ╔═╡ 3fc8e981-74d9-457d-b893-26f5c7c566e7
md"The *(exterior) product* of a ``k``-form is ``\alpha = \sum_I f_I dx_I`` and an ``l``-form ``\beta = \sum_J g_J dx_J`` is defined to be the ``k+l``-form

$$\alpha \beta = \sum_{I, J} f_I g_J dx_I dx_J.$$"

# ╔═╡ 2321e281-94a6-4168-bed1-3c025fbe0ebc
md"Usually many terms in a product cancel out or can be combined.  For instance,

$$(ydx + xdy)(xdxdz + ydydz) = y^2dxdydz + x^2dydxdz = (y^2 - x^2) dx dy dz.$$"

# ╔═╡ b47d6381-a485-4b37-aa3b-960a205b017e
md"Consider an arbitrary form ``\alpha`` of degree ``k``.  Its ``p``-th power ``\alpha^p`` is of degree ``kp``, which is greater than ``n`` if ``k>0`` and ``p>n``, so that 

$$\alpha^{n+1} = 0$$

for any form ``\alpha`` on ``\mathbb{R}^n`` of positive degree."

# ╔═╡ d4d92ee8-39b9-48c3-b0ab-e13eb4fa1310
md"The alternating property combines with the multiplication rule to give the following result on *graded commutativity*.

$$\beta\alpha = (-1)^{kl}\alpha\beta$$

for all ``k``-forms ``\alpha`` and all ``l``-forms ``\beta``."

# ╔═╡ 7299fc05-167f-487f-8ef0-04a089834573
md"Specifically, when ``\alpha = \beta``, then we get ``\alpha^2 = (-1)^{k^2}\alpha^2 = (-1)^k \alpha^2``.  This equality is vacuous if ``k`` is even, but tells us that ``\alpha^2 = 0`` if ``k`` is odd."

# ╔═╡ e6751f89-4445-4cfd-865d-6e4eed3f8c05
md"Note then that for an odd degree form ``\alpha``, ``\alpha^2 = 0``."

# ╔═╡ 1d9c1d57-2fef-4a9a-88e7-aed67caa5a52
md"If ``f`` is a ``0``-form, that is a smooth function, we define ``df`` to be the ``1``-form

$$df = \sum_{i=1}^n \frac{\partial f}{\partial x_i} dx_i.$$"

# ╔═╡ 31612d50-94a8-4e8b-95a7-1d9f2c152998
md"Then we have the product or Leibniz rule

$$d(fg) = fdg + gdf.$$"

# ╔═╡ 91b9e344-7a90-4d75-91db-3b2d12ecbe4b
md"If ``\alpha = \sum_I f_I dx_I`` is a ``k``-form and each of the coefficients ``f_I`` is a smooth function, then we define ``d\alpha`` to be the ``k+1``-form

$$d\alpha = \sum_I df_I dx_I = \sum_I \sum_{i=1}^n \frac{\partial f}{\partial x_i} dx_i dx_I.$$"

# ╔═╡ f297b43d-ef49-4527-b194-710aae2d9e1e
md"The operation ``d`` is called *exterior differentiation*.  An operator of this sort is called a first-order partial differentiation operator, because it involves the first partial derivatives of the coefficients of a form."

# ╔═╡ e91d166a-dd93-4004-8de8-8e3c95333c4e
md"If ``\alpha`` is an ``n``-form on ``\mathbb{R}^n``, then ``d\alpha = 0`` since it is of degree ``n+1``."

# ╔═╡ 815947bb-4a63-4d4f-8e0c-656eea006d1e
md"The operator ``d`` is linear and satisfies the Leibniz rule.

i. For all ``k``-forms ``\alpha`` and ``\beta`` and all scalaras ``a, b``, 
$$d(a\alpha + b\beta) = ad\alpha + bd\beta.$$

ii. For all ``k``-forms ``\alpha`` and ``l``-forms ``\beta``

$$d(\alpha\beta) = (d\alpha)\beta + (-1)^k \alpha d\beta.$$ 

i. follows from linearity of partial differentiation.  To prove ii., let ``\alpha = \sum_I f_I dx_I`` and ``\beta = \sum_J g_J dx_J``.  Then

$$\begin{aligned} d(\alpha\beta) & = \sum_{I,J} d(f_I g_J) dx_I dx_J \\
& = \sum_{I,J} (f_I dg_J + g_J df_I)dx_I dx_J \\
& = \sum_I df_I dx_I \sum_J g_J dx_J + (-1)^k \sum_I f_I dx_I \sum_J dg_J dx_J \\
& = (d\alpha)\beta + (-1)^k \alpha d\beta.
\end{aligned}$$

where the third equality follows from moving ``dg_J`` behind the ``k`` components of ``dx_I``."

# ╔═╡ dd2013dd-95a1-4631-9913-473da7350168
md"One of the most curious properties of the exterior derivative is that for any form ``\alpha``

$$d(d\alpha) = d^2\alpha = 0$$

since for any smooth function the mixed partial derivatives ``\frac{\partial^2 f_I}{dx_i dx_j}`` and ``\frac{\partial^2 f_I}{dx_j dx_i}`` are equal, and the alternating property gives them opposite signs."

# ╔═╡ 8aa6db49-8385-4472-8221-f8ab66dc2d37
md"A form ``\alpha`` is *closed* if ``d\alpha = 0`` and is *exact* if ``\alpha = d\beta`` for some form ``\beta`` of degree one less than ``\alpha``."

# ╔═╡ 0d079799-63f8-417c-948e-11918162d7e1
md"Every exact form is closed since if ``\alpha = d\beta`` then ``d\alpha = d^2\beta = 0``."

# ╔═╡ 92ad8328-c350-48e7-8521-256fc61f8159
md"The form ``-ydx + xdy`` is not closed and therefore can not be exact.  On the otherhand, ``ydx + xdy`` is closed and exact, since ``d(xy) = ydx + xdy``."

# ╔═╡ 1bea6f05-0015-4f5e-85d0-b1f1a5f743e8
md"For a ``0``-form (function) ``f`` on ``\mathbb{R}^n`` to be closed, all its partial derivaties must vanish, which means it is constant."

# ╔═╡ 18912d6a-c0c2-4b05-92a5-3922982b7a7c
md"A nonzero constant function is not exact, because forms of degree ``-1`` are ``0``."

# ╔═╡ 2eb519f2-b8e0-4c9c-af71-c5b2c55e61ef
md"Consider the ``1``-form ``\alpha = \sum_{i=1}^n f_i dx_i``.  Determining whether ``\alpha`` is exact means solving the equation ``dg = \alpha`` for the function ``g``.  This amounts to 

$$\frac{\partial g}{\partial x_1} = f_1, \; \frac{\partial g}{\partial x_2} = f_n, \; \ldots, \; \frac{\partial g}{\partial x_n} = f_n,$$

a system of *first-order partial differential equations*.  Finding a solution is sometimes called *integrating* the system.  This is only possible is ``\alpha`` is closed, otherwise if ``\alpha`` is not closed then ``\alpha`` is not exact."

# ╔═╡ a32763ee-401d-439c-b773-7fc686c02b8e
md"The ``1``-form ``\alpha`` is closed if and only if

$$\frac{\partial f_i}{\partial x_j} = \frac{\partial f_j}{\partial x_i}$$

for all ``1 \leq i < j \leq n``.  These identities must be satisfied for the system above to be solvable and are therefore called the integrability conditions for the system."

# ╔═╡ 6c245821-988f-44ce-b046-684b3b4579d8
md"Let ``\alpha = ydx + (z\cos yz + x) dy + y\cos yz dz``.  Then

$$d\alpha = dy dx + (z(-y\sin yz) + \cos yz)dz dy + dx dy + (y(-z\sin yz) + \cos yz)dy dz = 0$$

so ``\alpha`` is closed.  Is ``\alpha`` exact?  Let's solve the equations

$$\frac{\partial g}{\partial x} = y, \; \frac{\partial g}{\partial y} = z\cos yz + x, \; \frac{\partial g}{\partial z} = y \cos yz$$

by successive integration.  The first equation gives ``g = yx + c(y,z)``, where ``c`` is a function of ``y`` and ``z`` only.  Substituting into the second equation gives ``\partial c/\partial y = z\cos yz``, so ``c = \sin yz + k(z)``.  Substituting inot the third equation gives ``k' = 0``, so ``k`` is a constant.  So ``g = xy + \sin yz`` is a solution and therefore ``\alpha`` is exact."

# ╔═╡ eea260c5-b32e-47ca-861b-20d74c29e3dd
md"The technique in [Example 2.9](#ex2.9) will always work for a ``1``-form defined on all of ``\mathbb{R}^n``, hence every closed ``1``-form on ``\mathbb{R}^n`` is exact."

# ╔═╡ 8c7ffc59-f017-4e7e-a0dd-d1d395d98927
md"The ``1``-form on the punctured plane ``\mathbb{R}^2 \setminus \{0\}`` defined by

$$\alpha_0 = -\frac{y}{x^2 + y^2} dx + \frac{x}{x^2 + y^2} dy = \frac{-ydx + xdy}{x^2 + y^2}$$

is called the angle form for reasons to be determined later.  Since

$$\frac{\partial}{\partial x} \frac{x}{x^2 + y^2} = \frac{y^2 - x^2}{(x^2 + y^2)^2}, \; \frac{\partial}{\partial y} \frac{y}{x^2 + y^2} = \frac{x^2 - y^2}{(x^2 + y^2)^2}$$

it follows that the angle form is closed.  We shall see later that the angle form is not exact."

# ╔═╡ d56ab788-53d4-4ab5-8327-40aa59afacf2
md"``{n \choose k}`` is the number of ways of partitioning a pile of ``n`` objects into a pile of ``k`` objects and a pile of ``n-k`` objects, thus

$${n \choose k} = {n \choose n-k}.$$

So in some sense there are as many ``k``-forms as there are ``n-k``-forms.  The *Hodge star operator* turns ``k``-forms into ``n-k``-forms.  The Hodge star of ``\alpha`` is denoted by ``*\alpha`` or sometimes ``\alpha^*``.  If ``\alpha = \sum_I f_I dx_I``, then

$$*\alpha = \sum_I f_I(*dx_I),$$

where ``*dx_I = \epsilon_I dx_{I^c}``."

# ╔═╡ 33f51c39-d012-4a53-bc69-d65b29ac4d36
md"Here, for any increasing multi-index ``I``, ``I^c`` denotes the complementary increasing multi-index, which consists of all numbers between ``1`` and ``n`` that do not occur in ``I``.  The factor ``\epsilon_I`` is a sign,

$$\epsilon_I = \begin{cases} 
	1 \; & dx_I dx_{I^c} = dx_1 dx_2 \cdots dx_n \\
    -1 \; & dx_I dx_{I^c} = -dx_1 dx_2 \cdots dx_n \\
\end{cases}$$."

# ╔═╡ 3356be97-a02f-44b5-a2b3-c1b81b2752b4
md"In other words, ``*dx_I`` is the product of all the ``dx_j``s that do not occur in ``dx_I``, times a factor ``\pm 1`` which is chosen in such a way that ``dx_I(*dx_I)`` is the volume form

$$dx_I(*dx_I) = dx_1 dx_2 \cdots dx_n.$$"

# ╔═╡ dffa149f-9f98-4747-ac61-9ac5e924d8f0
md"Let ``n = 6`` and ``I = (2, 6)``.  Then ``I^c = (1, 3, 4, 5)``, so ``dx_I = dx_2 dx_6`` and ``dx_{I^c} = dx_1 dx_3 dx_4 dx_5``.  Therefore

$$dx_I dx_{I^c} = dx_2 dx_6 dx_1 dx_3 dx_4 dx_5 = -dx_1 dx_2 dx_3 dx_4 dx_5 dx_6$$,

which shows that ``\epsilon_I = -1``.  Hence, ``*(dx_2 dx_6) = -dx_1 dx_3 dx_4 dx_5``."

# ╔═╡ cc614b68-d423-4143-9eeb-9c1b62f64af9
md"On ``\mathbb{R}^2`` we have ``*dx = dy`` and ``*dy= -dx``.  On ``\mathbb{R}^3`` we have

$$\begin{aligned}
*dx = dydz, \; & {*}(dxdy) = dz \\
*dy = -dxdz = dzdx, \; & {*}(dxdz) = -dy \\
*dz = dxdy, \; & {*}(dydz) = dx \\
\end{aligned}$$"

# ╔═╡ 45babecc-1287-4287-a7c8-91a3b6b30800
md"On ``\mathbb{R}^n`` we have ``{*}1 = dx_1 dx_2 \cdots dx_n``, ``{*}(dx_1 dx_2 \cdots dx_n) = 1``, and

$$\begin{aligned}
*dx_i = (-1)^{i+1}dx_1 dx_2 \cdots \widehat{dx}_i \cdots dx_n, \; & 1 \leq i \leq n \\
{*}(dx_i dx_j) = (-1)^{i+j+1}dx_1 dx_2 \cdots \widehat{dx}_i \cdots \widehat{dx}_j \cdots dx_n, \; & 1 \leq i < j \leq n \\
\end{aligned}$$"

# ╔═╡ 76159970-0813-4a9b-b59b-71fac92c4a86
md"A *vector field* on an open subset of ``U`` of ``\mathbb{R}^n`` is a smooth map ``F: U \to \mathbb{R}^n``.  We write ``\mathbf{F}`` in components as

$$\mathbf{F}(\mathbf{x}) = (F_1(\mathbf{x}), F_2(\mathbf{x}), \ldots, F_n(\mathbf{x}))',$$

or as ``\mathbf{F} = \sum_{i=1}^n F_i \mathbf{e}_i``, where ``\mathbf{e}_1, \mathbf{e}_2, \ldots, \mathbf{e}_n`` are the standard basis vectors of ``\mathbb{R}^n``."

# ╔═╡ f38b3e20-df6a-413f-8917-56c858c3c237
md"Vector fields in the plane can be plotted by placing the vector ``\mathbf{F}(\mathbf{x})`` with its tail at the point ``\mathbf{x}``.  Black dots are the *zeros* of the vector fields, where ``\mathbf{F}(\mathbf{x}) = \mathbf{0}``."

# ╔═╡ 1fd1ee4d-0d59-4197-8154-6296bc1defd4
begin
	x1 = -1:0.1:1
	y1 = -1:0.1:1
	df(x, y) =	0.1 .* [-y, x]
	x1s = [x for x in x1 for y in y1]
	y1s = [y for x in x1 for y in y1]
	p1 = quiver(x1s, y1s, quiver = df)
	scatter!(p1, [0.0], [0.0], color = :black, label = false)
end

# ╔═╡ eca07af4-f8de-4b52-aaaf-cc064e70ae2a
begin
	x2 = -0.5:0.1:2
	y2 = -0.5:0.1:2
	df2(x, y) = 0.05 .* [x*y - x, y - x*y]
	x2s = [x for x in x2 for y in y2]
	y2s = [y for x in x2 for y in y2]
	p2 = quiver(x2s, y2s, quiver = df2)
	scatter!(p2, [1.0], [1.0], color = :black, label = false)
end

# ╔═╡ a7aefd56-4623-46b0-8a5b-630b98121947
md"We can turn ``\mathbf{F}`` into a ``1``-form ``\alpha`` by using the ``F_i`` as coefficients: ``\alpha = \sum_{i=1}^n F_i dx_i``.  For instance, the ``1``-form ``\alpha = -ydx + xdy`` corresponds to the vector field ``\mathbf{F} = -y\mathbf{e}_1 + x\mathbf{e}_2``."

# ╔═╡ 15460e8b-e97a-4f18-a061-63fe09a4985b
md"We should think of ``d\mathbf{x} = (dx_1, dx_2, \ldots, dx_n)'`` as a vector-valued ``1``-form.  Then we can write ``\alpha = \mathbf{F} \cdot d\mathbf{x}``.  Clearly, ``\mathbf{F}`` is determined by ``\alpha`` and vice versa.  Thus vector fields and ``1``-forms are symbiotically associated to one another."

# ╔═╡ d357a943-dd38-435c-ad8a-4ae1032512c3
md"vector field ``\mathbf{F} \leftrightarrow 1``-form ``\alpha`` via ``\mathbf{F} \cdot d\mathbf{x} = \alpha``."

# ╔═╡ c0bd3379-efea-4cc8-836e-46c80af5bc6f
md"Intuitively, the vector-valued ``1``-form ``d\mathbf{x}`` represents an infinitesimal displacement.  If ``\mathbf{F}`` represents a force field, such as gravity or electricity acting on a particle, then ``\alpha = \mathbf{F} \cdot d\mathbf{x}`` represnts the *work* done by the force when the particle is displaced by an amount ``d\mathbf{x}``.  If the particle travels along a path, the total work done by the force is found by *integrating* ``\alpha`` along the path."

# ╔═╡ f5148e4a-08be-49c6-ab61-a43e682e7d16
md"The correspondence between vector fields and ``1``-forms behaves in an interesting way with respect to exterior differentiation and the Hodge star operator.  For each function ``f`` the ``1``-form ``df = \sum_{i=1}^n (\partial f / \partial x_i) dx_i`` is associated to the vector field

$$\nabla f = \sum_{i=1}^n \frac{\partial f}{\partial x_i} \mathbf{e}_i = \left(\frac{\partial f}{\partial x_1}, \frac{\partial f}{\partial x_2}, \ldots, \frac{\partial f}{\partial x_n} \right)'.$$ This vector field is called the *gradient* of ``f`` (or equivalently the transpose of the Jacobi matrix of ``f``)."

# ╔═╡ 2efef754-47a5-42d9-a6a4-ea2db82fb28a
md"``\nabla f \leftrightarrow df``: ``df = \nabla f \cdot d\mathbf{x}``"

# ╔═╡ 3201912e-7301-4df8-9837-b43d0f51bf3b
md"Start with a vector field ``\mathbf{F}`` and let ``\alpha = \mathbf{F}\cdot d\mathbf{x}``.  Then

$${*}\alpha = \sum_{i=1}^n F_i ({*}dx_i)$ = \sum_{i=1}^n F_i(-1)^{i+1}dx_1 dx_2 \cdots \widehat{dx}_i \cdots dx_n$$."

# ╔═╡ 3584867f-4572-4781-a5c5-20e061f7df25
md"Using the vector-valued ``n-1``-form 

$$\begin{aligned}
{*}d\mathbf{x} & = ({*}dx_1, \ldots, {*}dx_n)' \\
& = (dx_2 \cdots dx_n, -dx_1 dx_3 \cdots dx_n, \ldots, (-1)^{n+1}dx_1 dx_2 \cdots dx_{n-1})' \\
\end{aligned}$$

we can also write ``{*}\alpha = \mathbf{F}\cdot *d\mathbf{x}``."

# ╔═╡ cfad90eb-a8dc-422f-9235-33756922ded0
md"Intuitively, the vector-valued ``n-1``-form ``*d\mathbf{x}`` represents an infinitesimal ``n-1``-dimensional hypersurface perpendicular to ``d\mathbf{x}``.  In fluid mechanics, the flow of a fluid or gas in ``\mathbb{R}^n`` is represented by a vector field ``\mathbb{F}``.  The ``n-1``-form ``*\alpha`` then represents the *flux*, that is the amount of material passing through the hypersurface ``*d\mathbf{x}`` per unit time."

# ╔═╡ 4d1fd32f-de8f-4c16-8fef-ab6c0724b152
md"We have

$$\begin{aligned} d{*}\alpha & = d(\mathbf{F}\cdot *d\mathbf{x})  \\ 
& = d\left(\sum_{i=1}^n F_i (-1)^{i+1} dx_1 dx_2 \cdots \widehat{dx}_i \cdots dx_n \right) \\
& = \sum_{i=1}^n \sum_{j=1}^n \frac{\partial F_i}{\partial x_j} (-1)^{i+1} dx_j  dx_1 dx_2 \cdots \widehat{dx}_i \cdots dx_n\end{aligned}.$$

When ``j\not=i`` then there's two ``dx_j``s which equal ``0``, so that the double sume reduces to one sum

$$\begin{aligned} d{*}\alpha 
& = \sum_{i=1}^n \sum_{j=1}^n \frac{\partial F_i}{\partial x_j} (-1)^{i+1} dx_j  dx_1 dx_2 \cdots \widehat{dx}_i \cdots dx_n \\
& = \sum_{i=1}^n \frac{\partial F_i}{\partial x_j} (-1)^{i+1} dx_i  dx_1 dx_2 \cdots \widehat{dx}_i \cdots dx_n \\
& = \sum_{i=1}^n \frac{\partial F_i}{\partial x_j}  dx_1 dx_2 \cdots dx_i \cdots dx_n \\
& = \left( \sum_{i=1}^n \frac{\partial F_i}{\partial x_j} \right) dx_1 dx_2 \cdots dx_n \\
& = \textrm{div}(\mathbf{F})d\mathbf{x} \\
\end{aligned}$$"

# ╔═╡ 33ee9534-3810-4333-aa7d-6a7858822982
md"The function ``\textrm{div}(\mathbf{F}) = \sum_{i=1}^n \frac{\partial F_i}{\partial x_i}`` is the *divergence* of ``\mathbf{F}``.  Thus, if ``\alpha = \mathbf{F}\cdot d\mathbf{x}``, then

$$d{*}\alpha = d(\mathbf{F}\cdot {*}d\mathbf{x}) = \textrm{div}(\mathbf{F})dx_1 dx_2 \cdots dx_n.$$

An alternative way of writing this identity is obtained by applying ``*`` to both sides, which gives

$$\textrm{div}(\mathbf{F}) = *d{*}\alpha,$$

which should probably be read as ``*(d({*}\alpha))``."

# ╔═╡ 315fc0e5-d562-4e40-96e5-4dc51c495593
md"A very different identity is found by first aply ``d`` and then ``*`` to ``\alpha``:

$$d\alpha = \sum_{i,j = 1}^n \frac{\partial F_i}{\partial x_j} dx_j dx_i = \sum_{1 \leq i < j \leq n} \left(\frac{\partial F_j}{dx_i} - \frac{\partial F_i}{\partial dx_j} \right) dx_i dx_j,$$

and hence

$$*d\alpha = \sum_{1 \leq i < j \leq n} (-1)^{i+j+1} \left(\frac{\partial F_j}{dx_i} - \frac{\partial F_i}{\partial dx_j} \right) dx_1 dx_2 \cdots \widehat{dx}_i \widehat{dx}_j \cdots dx_n.$$"

# ╔═╡ a5de86a9-dd6e-45b4-b92e-af12ed54b037
md"In three dimensions, ``*d\alpha`` is a ``1``-form and so is associated to a vector field, namely

$$\textrm{curl}(\mathbf{F}) = \left( \frac{\partial F_3}{\partial x_2} -  \frac{\partial F_2}{\partial x_3}\right) \mathbf{e}_1 - \left( \frac{\partial F_3}{\partial x_1} -  \frac{\partial F_1}{\partial x_3}\right) \mathbf{e}_2 + \left( \frac{\partial F_2}{\partial x_1} -  \frac{\partial F_1}{\partial x_2}\right) \mathbf{e}_3,$$

the *curl* of ``\mathbf{F}.``  Thus, for ``n = 3``, if ``\alpha = \mathbf{F} \cdot d\mathbf{x}``, then

$$\textrm{curl}(\mathbf{F}) \cdot d\mathbf{x} = *d\alpha.$$"

# ╔═╡ 027631a9-3b6e-4fc3-8160-7f07e29f89e1
md"The *parallelepiped* spanned by the columns of the ``n \times n``-matrix ``A`` is by definition the set of all linear combinations of ``\sum_{i=1}^n c_i \mathbf{a}_i``, where the coefficients ``c_i`` range over the unit interval ``[0, 1]``.  A parallelepiped spanned by a single vector is called a *line segment* and a parallelepiped spanned by two vectors is called a *parallelogram*."

# ╔═╡ 716b444a-65ab-4d23-abf2-4687e440f455
md"The determinant of ``A`` is variously denoted by 

$$\det{(A)} = \det{(\mathbf{a}_1, \mathbf{a}_2, \ldots, \mathbf{a}_n)} = \det{(a_{i,j})}_{1 \leq i, j \leq n} = |A|$$"

# ╔═╡ 67c0978f-3698-4a35-8551-fe908725a181
md"**Expansion on the ``j``-th column**.  Define the determinant of ``A`` to be

$$\det{(A)} = \sum_{i=1}^n (-1)^{i+1} a_{i,j} \det{(A^{i,j})},$$

where ``A^{i,j}`` denotes the ``(n-1) \times (n-1)``-matrix obtained from ``A`` by crossing out the ``i``-th row and ``j``-th column.  This recursive definition relies on the base case where the determinant of a ``1 \times 1``-matrix ``(a)`` is simply the number ``a``.  This sometimes useful definition has two serious flaws: first it is exteremly inefficient computationally, and second it obscures the relationship with volumes of parallelepipeds."

# ╔═╡ cde7422b-5db5-459a-bb9a-185ac3c18d22
md"A far better definition follows from a characterization by a few simple axioms, which make good sense in view of its geometrical significance.  To motivate these axioms we first consider the case of a ``2 \times 2``-matrix ``A``, the columns of which are vectors ``\mathbf{a}_1, \mathbf{a}_2`` in the plane."

# ╔═╡ 454043e7-bb83-4c04-bef7-eed918fd59f9
md"Consider the shear transformation of adding any multiple ``b`` of ``\mathbf{a}_1`` to ``\mathbf{a}_2``.  The shear transformation ``(\mathbf{a}_1, \mathbf{a}_2) \to (\mathbf{a}_1, \mathbf{a}_2 + b\mathbf{a}_1)`` does not change the oriented area."

# ╔═╡ 838e43bf-98aa-4e7c-8cea-8ec9283123c9
md"Consider multiplying the first column by a scalar ``c``, ``(\mathbf{a}_1, \mathbf{a}_2) \to (c\mathbf{a}_1, \mathbf{a}_2)``, which effectively stretches (if ``c > 1``) or compresses (if ``0 < c < 1)`` and thus changes the oriented area by a factor of ``c``.  If ``c`` is negative, then a *positively oriented* parallelogram, where the angle from edge ``\mathbf{a}_1`` to edge ``\mathbf{a}_2`` is counterclockwise, will become *negatively oriented* in the sense that the angle from edge ``c\mathbf{a}_1`` to edge ``\mathbf{a}_2`` is clockwise.  Therefore multiplying ``\mathbf{a}_1`` by a negative ``c`` also changes the oriented area by a factor of ``c``."

# ╔═╡ 0141487a-d330-458d-9883-c7bd5351cb3a
md"Similarly, interchanging the columns of ``A`` has the effect of reversing the orientation of the parallelogram, which changes the sign of its oriented area."

# ╔═╡ 20430725-6e6c-4103-af07-ff18d9e11b51
md"To generalize this to higher dimensions, recal the *elementary column operations* which come in three types: adding a multiple of any column of ``A`` to any other column (type I); multiplying a column by a nonzero constant (type II); and interchanging any two columns (type III).  As suggested by the above descriptions on a parallelogram, type I does not affect the determinant, type II mulitplies by the corresponding constant, and type II causes a sign change."

# ╔═╡ 594af7d8-3e80-4771-ac4a-4453b54ed21d
md"A *determinant* is a function ``\det`` which assignes to every ``n \times n`` matrix ``A`` a number ``\det{(A)}`` subject to the following axioms:

  i. If ``E`` is an elementary column operation, then ``\det{(E(A))} = k\det{(A)}``, where

$$k = \begin{cases} 
	1 \; & E \text{ is of type I} \\
    c \; & E \text{ is of type II} \\
	-1 \; & E \text{ is of type III} \\
\end{cases}$$

  ii. ``\det{(I)} = 1.``"

# ╔═╡ 6935e7d8-50b2-47ed-b695-924764c732d7
md"Axiom ii. is a normalization convention, which is justified by the reasonable requirement that the unit cube in ``\mathbb{R}^n`` should have oriented volume ``1``."

# ╔═╡ 00582b53-9861-4733-bc22-01e74c6ee01b
md"The function ``\det`` is unique."

# ╔═╡ 303f0666-fb3a-4052-b05e-6e988231b4b7
md"$$\det{(A)} = \sum_{\sigma \in S_n} \text{sign}(\sigma)a_{1, \sigma(1)} a_{2, \sigma(2)}, \cdots, a_{n, \sigma(n)}.$$

``S_n`` stands for the collection of all *permutations* of the set ``\{1, 2, \ldots, n\}``.  A permutation is a way of ordering the numbers ``1, 2, \ldots, n``.  Permutations are usually written as ``n``-tuples containing each of these numbers exactly once.  Thus for ``n = 2`` there are only two permutations: ``(1, 2)`` and ``(2, 1)``.  For a general ``n`` there are ``n!`` permutations."

# ╔═╡ 47b7a585-8848-423e-a8a9-4a16a44975cb
md"An alternative way of thinking of a permutation is as a bijective map from the set ``\{1, 2, \ldots, n\}`` to itself.  For example, for ``n = 5`` a possible permutation is ``(5, 3, 1, 2, 4)``, and we think of this as a shortand notation for the map ``\sigma`` given by ``\sigma(1) = 5, \sigma(2) = 3, \sigma(3) =1, \sigma(4) = 2,`` and ``\sigma(5) = 4``.  The permutation ``(1, 2, 3, \ldots, n-1, n)`` then corresponds to the identity map of the set ``\{1, 2, \ldots, n)``."

# ╔═╡ f350cadf-1c10-4f00-8f5b-4d6d72176571
md"If ``\sigma`` is the indentity permutation, then clearly ``\sigma(i) < \sigma(j)`` whenever ``i < j``.  However, if ``\sigma`` is not the identity permutation, it cannot preserve the order in this way.  An *inversion* of ``\sigma`` is any pair of numbers ``i`` and ``j`` such that ``1 \leq i < j \leq n`` and ``\sigma(i) > \sigma(j)``.  The *length* of ``\sigma``, denoted by ``l(\sigma)``, is the number of inversions of ``\sigma``."

# ╔═╡ 1cef4f0a-e34e-467a-814f-d3bca7ab420e
begin
	function section(level::String, title::String) 
		return HTML("<$level id=$(split(title, " ")[1])>$title</$level>")
	end
	
	function part(name::String)
		id = SubString(name, 1, 1)
		return (n::String, t::String = "") -> HTML("""<span id=$(id*n)><b>$name $n</b><em>$(" " * t)</em></span>""")
	end

	example = part("Example")
	proposition = part("Proposition")
	corollary = part("Corollary")
	definition = part("Definition")
	theorem = part("Theorem")
end

# ╔═╡ e912ef1b-734f-4ddd-9007-6e08ed97e384
section("h2", "2 Differential Forms on Euclidean Space")

# ╔═╡ cbae3bf3-a90b-4518-94f8-383ccaa4bec6
section("h4", "2.1 Elementary Properties")

# ╔═╡ 23648b46-5280-420c-83ce-7c650062a9ac
proposition("2.1")

# ╔═╡ 89464fa4-3185-45f7-9c9e-5d9be1340b9b
corollary("2.2")

# ╔═╡ bba65c0e-da2a-4b75-9cb9-688f47c4be9f
section("h4", "2.2 The exterior derivative")

# ╔═╡ 00fbac5a-a309-4654-998e-8e34ef87278e
proposition("2.5")

# ╔═╡ 479b40c3-4065-4a65-a537-15bc1994a96e
proposition("2.6")

# ╔═╡ b64c8e1c-23d2-4be2-9d75-00a60cea3221
section("h4", "2.3 Closed and exact forms")

# ╔═╡ 7c7d9750-3358-45ae-ba4e-ba79543fa8fa
proposition("2.7")

# ╔═╡ ace41d7d-6745-4dac-848a-2ce2fac255be
example("2.8")

# ╔═╡ 39074231-8c01-4a36-89a6-45ca89d993af
example("2.8.1")

# ╔═╡ fd07751c-5a23-4e48-8bce-a598424ab56e
example("2.8.2")

# ╔═╡ 2aed704c-4e7f-43a5-b1df-4e0a9319e041
example("2.9")

# ╔═╡ 6414b4fc-3445-4fb7-97a2-d3c38cfca31c
example("2.10")

# ╔═╡ 26de5f23-64cc-4b8d-a599-088a212c2a4a
section("h4", "2.4 The Hodge star operator")

# ╔═╡ d52ccce6-fb72-4781-9989-fff3492d4978
example("2.11")

# ╔═╡ e4775257-e6be-4c6f-a45c-75e0ecbf1651
example("2.12")

# ╔═╡ dd73a4df-f564-4d35-93de-a25e5a74efc9
section("h4", "2.5 div, grad, and curl")

# ╔═╡ e49596cb-ddd1-42b7-9220-98c42e050234
section("h2", "3 Pulling back forms")

# ╔═╡ 53f037b0-b278-44fb-a486-bd83b172a359
section("h4", "3.1 Determinants")

# ╔═╡ 5b5b613b-8a61-4f73-bdd6-da2aa2020943
definition("3.1", "Determinant")

# ╔═╡ 2d2eb9ff-b3c5-4e35-bcb8-4f955171629d
theorem("3.3", "Uniqueness of Determinants")

# ╔═╡ f874ae8d-95ff-4449-8755-f8aa8227d6ce
theorem("3.5", "Existence of Determinants")

# ╔═╡ Cell order:
# ╠═90fb24e0-c88b-11eb-3a76-7712f64d0d6f
# ╠═273c5aa8-e0b2-4139-89a9-ac4cd7a51464
# ╠═2da4aa34-44b6-4d61-8378-2165a7da73af
# ╠═e912ef1b-734f-4ddd-9007-6e08ed97e384
# ╠═cbae3bf3-a90b-4518-94f8-383ccaa4bec6
# ╠═f8f45f3b-e0b3-46e5-bf5b-7a77b750ee29
# ╠═74112867-542a-4e7a-b695-991830f7f04a
# ╠═6ef9ce1d-e64b-43c9-aabd-eaae3b9c946d
# ╠═a04ad4d6-225c-4e2e-b81f-25914dc7b743
# ╠═a5255eb1-0d70-4f3d-8ee8-f3a6fd6d3375
# ╠═1b63a8d0-309a-4dc6-80c9-01d354917bb7
# ╠═e4355bf9-546a-4a08-8d34-f5beebf7f091
# ╠═ae8fd591-ca24-4f29-ab68-ddf310a73456
# ╠═6aa73bcd-a0a8-434a-b054-49a748294ebe
# ╠═3fc8e981-74d9-457d-b893-26f5c7c566e7
# ╠═2321e281-94a6-4168-bed1-3c025fbe0ebc
# ╠═b47d6381-a485-4b37-aa3b-960a205b017e
# ╠═23648b46-5280-420c-83ce-7c650062a9ac
# ╠═d4d92ee8-39b9-48c3-b0ab-e13eb4fa1310
# ╠═7299fc05-167f-487f-8ef0-04a089834573
# ╠═89464fa4-3185-45f7-9c9e-5d9be1340b9b
# ╠═e6751f89-4445-4cfd-865d-6e4eed3f8c05
# ╠═bba65c0e-da2a-4b75-9cb9-688f47c4be9f
# ╠═1d9c1d57-2fef-4a9a-88e7-aed67caa5a52
# ╠═31612d50-94a8-4e8b-95a7-1d9f2c152998
# ╠═91b9e344-7a90-4d75-91db-3b2d12ecbe4b
# ╠═f297b43d-ef49-4527-b194-710aae2d9e1e
# ╠═e91d166a-dd93-4004-8de8-8e3c95333c4e
# ╠═00fbac5a-a309-4654-998e-8e34ef87278e
# ╠═815947bb-4a63-4d4f-8e0c-656eea006d1e
# ╠═479b40c3-4065-4a65-a537-15bc1994a96e
# ╠═dd2013dd-95a1-4631-9913-473da7350168
# ╠═b64c8e1c-23d2-4be2-9d75-00a60cea3221
# ╠═8aa6db49-8385-4472-8221-f8ab66dc2d37
# ╠═7c7d9750-3358-45ae-ba4e-ba79543fa8fa
# ╠═0d079799-63f8-417c-948e-11918162d7e1
# ╠═ace41d7d-6745-4dac-848a-2ce2fac255be
# ╠═92ad8328-c350-48e7-8521-256fc61f8159
# ╠═39074231-8c01-4a36-89a6-45ca89d993af
# ╠═1bea6f05-0015-4f5e-85d0-b1f1a5f743e8
# ╠═fd07751c-5a23-4e48-8bce-a598424ab56e
# ╠═18912d6a-c0c2-4b05-92a5-3922982b7a7c
# ╠═2eb519f2-b8e0-4c9c-af71-c5b2c55e61ef
# ╠═a32763ee-401d-439c-b773-7fc686c02b8e
# ╠═2aed704c-4e7f-43a5-b1df-4e0a9319e041
# ╠═6c245821-988f-44ce-b046-684b3b4579d8
# ╠═eea260c5-b32e-47ca-861b-20d74c29e3dd
# ╠═6414b4fc-3445-4fb7-97a2-d3c38cfca31c
# ╠═8c7ffc59-f017-4e7e-a0dd-d1d395d98927
# ╠═26de5f23-64cc-4b8d-a599-088a212c2a4a
# ╠═d56ab788-53d4-4ab5-8327-40aa59afacf2
# ╠═33f51c39-d012-4a53-bc69-d65b29ac4d36
# ╠═3356be97-a02f-44b5-a2b3-c1b81b2752b4
# ╠═d52ccce6-fb72-4781-9989-fff3492d4978
# ╠═dffa149f-9f98-4747-ac61-9ac5e924d8f0
# ╠═e4775257-e6be-4c6f-a45c-75e0ecbf1651
# ╠═cc614b68-d423-4143-9eeb-9c1b62f64af9
# ╠═45babecc-1287-4287-a7c8-91a3b6b30800
# ╠═dd73a4df-f564-4d35-93de-a25e5a74efc9
# ╠═76159970-0813-4a9b-b59b-71fac92c4a86
# ╠═f38b3e20-df6a-413f-8917-56c858c3c237
# ╠═1fd1ee4d-0d59-4197-8154-6296bc1defd4
# ╠═eca07af4-f8de-4b52-aaaf-cc064e70ae2a
# ╠═a7aefd56-4623-46b0-8a5b-630b98121947
# ╠═15460e8b-e97a-4f18-a061-63fe09a4985b
# ╠═d357a943-dd38-435c-ad8a-4ae1032512c3
# ╠═c0bd3379-efea-4cc8-836e-46c80af5bc6f
# ╠═f5148e4a-08be-49c6-ab61-a43e682e7d16
# ╠═2efef754-47a5-42d9-a6a4-ea2db82fb28a
# ╠═3201912e-7301-4df8-9837-b43d0f51bf3b
# ╠═3584867f-4572-4781-a5c5-20e061f7df25
# ╠═cfad90eb-a8dc-422f-9235-33756922ded0
# ╠═4d1fd32f-de8f-4c16-8fef-ab6c0724b152
# ╠═33ee9534-3810-4333-aa7d-6a7858822982
# ╠═315fc0e5-d562-4e40-96e5-4dc51c495593
# ╠═a5de86a9-dd6e-45b4-b92e-af12ed54b037
# ╠═e49596cb-ddd1-42b7-9220-98c42e050234
# ╠═53f037b0-b278-44fb-a486-bd83b172a359
# ╠═027631a9-3b6e-4fc3-8160-7f07e29f89e1
# ╠═716b444a-65ab-4d23-abf2-4687e440f455
# ╠═67c0978f-3698-4a35-8551-fe908725a181
# ╠═cde7422b-5db5-459a-bb9a-185ac3c18d22
# ╠═454043e7-bb83-4c04-bef7-eed918fd59f9
# ╠═838e43bf-98aa-4e7c-8cea-8ec9283123c9
# ╠═0141487a-d330-458d-9883-c7bd5351cb3a
# ╠═20430725-6e6c-4103-af07-ff18d9e11b51
# ╠═5b5b613b-8a61-4f73-bdd6-da2aa2020943
# ╠═594af7d8-3e80-4771-ac4a-4453b54ed21d
# ╠═6935e7d8-50b2-47ed-b695-924764c732d7
# ╠═2d2eb9ff-b3c5-4e35-bcb8-4f955171629d
# ╠═00582b53-9861-4733-bc22-01e74c6ee01b
# ╠═f874ae8d-95ff-4449-8755-f8aa8227d6ce
# ╠═303f0666-fb3a-4052-b05e-6e988231b4b7
# ╠═47b7a585-8848-423e-a8a9-4a16a44975cb
# ╠═f350cadf-1c10-4f00-8f5b-4d6d72176571
# ╠═f66c5349-258a-4218-81f9-57d86b1f9c34
# ╠═ffd4c917-7cd5-46c8-bba1-58e4b4fc47b9
# ╠═1cef4f0a-e34e-467a-814f-d3bca7ab420e
