### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ ffd4c917-7cd5-46c8-bba1-58e4b4fc47b9
using PlutoUI

# ╔═╡ 540192f3-b4db-43bb-9f27-5f435df43d92
using HypertextLiteral

# ╔═╡ 90fb24e0-c88b-11eb-3a76-7712f64d0d6f
md"# Notes on Manifolds and Differential Forms"

# ╔═╡ 273c5aa8-e0b2-4139-89a9-ac4cd7a51464
md"Personal notes on based on my reading of Reyer Sjamaar's lecture notes on [Manifolds and Differential Forms](http://pi.math.cornell.edu/~sjamaar/teach.html)."

# ╔═╡ 2da4aa34-44b6-4d61-8378-2165a7da73af
TableOfContents()

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
md"**Examples**

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


# ╔═╡ 1cef4f0a-e34e-467a-814f-d3bca7ab420e
begin
	section(t) = @htl("<h2 id=$t>$t</h2>")
	subsection(t) = @htl("<h4 id=$(split(t, " ")[1])>$t</h4>")
	ss(s, t) = HTML("<$s id=$(split(t, " ")[1])>$t</$s>")
end

# ╔═╡ e912ef1b-734f-4ddd-9007-6e08ed97e384
section("Differential Forms on Euclidean Space")

# ╔═╡ cbae3bf3-a90b-4518-94f8-383ccaa4bec6
subsection("2.1 Elementary Properties")

# ╔═╡ bba65c0e-da2a-4b75-9cb9-688f47c4be9f
subsection("2.2 The exterior derivative")

# ╔═╡ b64c8e1c-23d2-4be2-9d75-00a60cea3221
subsection("2.3 Closed and exact forms")

# ╔═╡ dd848965-062e-4daf-8c16-fc598a6d09c4
ss("h6", "topics")

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
# ╠═d4d92ee8-39b9-48c3-b0ab-e13eb4fa1310
# ╠═7299fc05-167f-487f-8ef0-04a089834573
# ╠═e6751f89-4445-4cfd-865d-6e4eed3f8c05
# ╠═bba65c0e-da2a-4b75-9cb9-688f47c4be9f
# ╠═1d9c1d57-2fef-4a9a-88e7-aed67caa5a52
# ╠═31612d50-94a8-4e8b-95a7-1d9f2c152998
# ╠═91b9e344-7a90-4d75-91db-3b2d12ecbe4b
# ╠═f297b43d-ef49-4527-b194-710aae2d9e1e
# ╠═e91d166a-dd93-4004-8de8-8e3c95333c4e
# ╠═815947bb-4a63-4d4f-8e0c-656eea006d1e
# ╠═dd2013dd-95a1-4631-9913-473da7350168
# ╠═b64c8e1c-23d2-4be2-9d75-00a60cea3221
# ╠═8aa6db49-8385-4472-8221-f8ab66dc2d37
# ╠═0d079799-63f8-417c-948e-11918162d7e1
# ╠═92ad8328-c350-48e7-8521-256fc61f8159
# ╠═ffd4c917-7cd5-46c8-bba1-58e4b4fc47b9
# ╠═540192f3-b4db-43bb-9f27-5f435df43d92
# ╠═dd848965-062e-4daf-8c16-fc598a6d09c4
# ╠═1cef4f0a-e34e-467a-814f-d3bca7ab420e
