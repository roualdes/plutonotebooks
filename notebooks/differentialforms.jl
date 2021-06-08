### A Pluto.jl notebook ###
# v0.14.4

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

"

# ╔═╡ 1cef4f0a-e34e-467a-814f-d3bca7ab420e
begin
	section(t) = @htl("<h2 id=$t>$t</h2>")
	subsection(t) = @htl("<h4 id=$(split(t, " ")[1])>$t</h4>")
end

# ╔═╡ e912ef1b-734f-4ddd-9007-6e08ed97e384
section("Differential Forms on Euclidean Space")

# ╔═╡ cbae3bf3-a90b-4518-94f8-383ccaa4bec6
subsection("2.1 Elementary Properties")

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
# ╠═ffd4c917-7cd5-46c8-bba1-58e4b4fc47b9
# ╠═540192f3-b4db-43bb-9f27-5f435df43d92
# ╠═1cef4f0a-e34e-467a-814f-d3bca7ab420e
