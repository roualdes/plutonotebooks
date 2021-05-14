### A Pluto.jl notebook ###
# v0.14.4

using Markdown
using InteractiveUtils

# ╔═╡ d8fdab19-0c10-4696-b5df-cfd7ee9fac66
using PlutoUI

# ╔═╡ 675b7996-b2ab-11eb-378f-e5182b4b1e42
md"# Manipulations? of Distributions"

# ╔═╡ ef98d806-5b7f-4d81-8f93-354a2c2ec9c2
TableOfContents()

# ╔═╡ 48b5b560-f2e7-4048-82cb-9fba1e666929
md"TODO This notebook is not titled well.  With some calculus-2 tools, we can fairly easily deal with algebraic manipulations of two distributions and also functions of distributions.  No need for random variables at all.  Need (cumulative) distribution functions, Fundamental Theorem of Calculus, and the Dirac delta function.  Distribution functions should be it's own notebook, with links to this notebook and to somthing about [Riemann-Stieltjes integrals](https://en.wikipedia.org/wiki/Riemann%E2%80%93Stieltjes_integral); it's these two topics that make distribution functions worthy."

# ╔═╡ 133705ee-5679-4ead-ba3e-f4fdf7479b7a
md"## Function of a single distribution"

# ╔═╡ 5eccf84b-338b-4f58-802f-f2836f7f0cc7
md"Consider a distribution ``\mathbb{P}`` with distribution function ``F`` and density function ``f = F'``.  A bijective function ``h`` transforms ``F`` into a new distribution function ``G`` and thus creates a new distribution.  The distribution function ``G`` can be derived as follows.  

Start by writing ``G`` in terms of ``f``, using the fact that ``h^{-1}`` exists, since ``h`` is bijective.

$$G(y) = \int f(x) 1_{x \leq h^{-1}(y)} \mathrm{d}x$$

The density function associated with the distribution function ``G`` is found by taking the derivative with respect to ``y``,

$$g(y) = \int f(x) 1_{x = h^{-1}(y)} \left| \frac{\partial}{\partial y} h^{-1}(y) \right| \mathrm{d}x.$$

Remembering the chain rule, the absolute value ensures the density function ``g`` is non-negative.  The indicator function ``1_{x = h^{-1}(y)}`` equals ``1`` when ``x = h^{-1}(y)``, so we can replace ``x`` with ``h^{-1}(y)`` to get

$$g(y)  = f(h^{-1}(y)) \left| \frac{\partial}{\partial y} h^{-1}(y) \right| \int 1_{x = h^{-1}(y)} dx.$$

The integral of the Dirac delta function is ``1``, so that the density function of the distribution function ``G`` is 

$$g(y) = f(h^{-1}(y)) \left| \frac{\partial}{\partial y} h^{-1}(y) \right|.$$

Geometrically, the chain rule here accounts for the fact that ``h`` (potentially) warps the space on which ``\mathbb{P}`` assigns probabilities.  The term ``\left| \frac{\partial}{\partial y} h^{-1}(y) \right|`` thus ensures that the new density function ``g`` is an appropriate density function over this new space mapped by ``h``.
"

# ╔═╡ 7c8cbb8e-d400-486d-b259-d9ecd1b571e9
md"## Product"

# ╔═╡ 23fc83b2-6604-4179-83c3-0ac1170fccb6
md"For two independent distributions ``\mathbb{P}_1, \mathbb{P}_2`` with density functions ``\pi_1, \pi_2``, the distribution of their product can be found as

$$F(z) = \int f(x) f(y) 1_{xy \leq z} dx dy.$$

The density function associated with the above cumulative distribution function is found by taking the derivative with respect to ``z``,

$$f(z) = \int f(x) f(y) 1_{xy = z} dx dy.$$

The indicator function 1_{xy = z} is satisfied when ``y = z / x``, so we can replace ``f(y)`` with ``f(z / x)`` to get

$$f(z) = \int f_X(x) f_Y(z/x) dx \int 1_{xy = z} dy.$$

The Dirac delta function has a number of property which allow us to simplify the expression for ``f(z)``.  The scaling property gives

$$1_{xy = z} = \delta(z - xy) = \frac{1}{|x|}\delta(z/x - y),$$

and the sifting property allows

$$\int_{\mathbb{R}} \delta(z - y) dy = 1.$$

Putting these together we find

$$f(z) = \int f_X(x) f_Y(z/x) dx \int 1_{xy = z} dy = \int f_X(x) f_Y(z/x) \frac{1}{|x|}dx.$$"

# ╔═╡ ebbb58e3-49fa-47e8-9257-ca344f6b3f80
md"## Sum"

# ╔═╡ f6f81c53-ca48-4b6d-8c12-72ceb8bac007
md"This same strategy works for adding two independent distributions.  For two independent distributions ``\mathbb{P}_1, \mathbb{P}_2`` with density functions ``\pi_1, \pi_2``, the distribution of their sum can be found as

$$F(z) = \int f(x) f(y) 1_{x + y \leq z} dx dy.$$

The density function associated with the above cumulative distribution function is found by taking the derivative with respect to ``z``,

$$f(z) = \int f(x) f(y) 1_{x + y = z} dx dy.$$

The indicator function 1_{x + y = z} is satisfied when ``y = z - x``, so we can replace ``f(y)`` with ``f(z - x)`` to get

$$f(z) = \int f_X(x) f_Y(z - x) dx \int 1_{x + y = z} dy.$$

By the scaling and sifting properties of the Dirac delta function, we find

$$f(z) = \int f_X(x) f_Y(z - x) dx,$$

which justifies the claim that the sum of two independent distributions is the [convolution](https://en.wikipedia.org/wiki/Convolution) of their density functions.
"

# ╔═╡ 3d1222f6-cedc-453e-856a-2e405526da99
md"## References

* [https://en.wikipedia.org/wiki/Product_distribution](https://en.wikipedia.org/wiki/Product_distribution)
* [https://en.wikipedia.org/wiki/Dirac_delta_function#Properties](https://en.wikipedia.org/wiki/Dirac_delta_function#Properties)
"

# ╔═╡ 3d4329c0-4aa1-40c9-848b-ace3d9fe6c5b
md"## Appendix"

# ╔═╡ 582601d1-016e-4dc4-9c1d-5c966a0ae5a7
md"#### Dirac delta function"

# ╔═╡ cc458129-bfcf-4ec9-8c83-df647da07b62
md"The Diract delta function is a peculiar little function. The scaling property of the Dirac delta function is

$$\delta(\alpha x) = \frac{\delta(x)}{|\alpha|}$$

The sifting property is

$$\int_{-\infty}^{\infty} f(t) \delta(t - T)dt = f(T).$$

The Diract delta function is even, 

$$\delta(-x) = \delta(x).$$

The integral of the Diract delta function is equal to ``1``,

$$\int \delta(x) dx = 1.$$
"

# ╔═╡ Cell order:
# ╠═675b7996-b2ab-11eb-378f-e5182b4b1e42
# ╠═ef98d806-5b7f-4d81-8f93-354a2c2ec9c2
# ╠═48b5b560-f2e7-4048-82cb-9fba1e666929
# ╠═133705ee-5679-4ead-ba3e-f4fdf7479b7a
# ╠═5eccf84b-338b-4f58-802f-f2836f7f0cc7
# ╠═7c8cbb8e-d400-486d-b259-d9ecd1b571e9
# ╠═23fc83b2-6604-4179-83c3-0ac1170fccb6
# ╠═ebbb58e3-49fa-47e8-9257-ca344f6b3f80
# ╠═f6f81c53-ca48-4b6d-8c12-72ceb8bac007
# ╠═3d1222f6-cedc-453e-856a-2e405526da99
# ╠═3d4329c0-4aa1-40c9-848b-ace3d9fe6c5b
# ╠═582601d1-016e-4dc4-9c1d-5c966a0ae5a7
# ╠═cc458129-bfcf-4ec9-8c83-df647da07b62
# ╠═d8fdab19-0c10-4696-b5df-cfd7ee9fac66
