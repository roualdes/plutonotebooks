### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ d8fdab19-0c10-4696-b5df-cfd7ee9fac66
using PlutoUI

# ╔═╡ 8bede73d-97bf-420b-b664-509a16c0c32b
using Distributions

# ╔═╡ 9f0c25b0-1b53-415e-92d4-4b1b3bf7f650
using StatsPlots

# ╔═╡ dafd1e7b-a4ba-4854-bcd3-3b266dc58a4a
using LaTeXStrings

# ╔═╡ 56488ebe-0d85-455e-a276-764e3b208795
using HypertextLiteral

# ╔═╡ 675b7996-b2ab-11eb-378f-e5182b4b1e42
md"# Manipulations? of Distributions"

# ╔═╡ ef98d806-5b7f-4d81-8f93-354a2c2ec9c2
TableOfContents()

# ╔═╡ 48b5b560-f2e7-4048-82cb-9fba1e666929
md"TODO This notebook is not titled well.  With some calculus-2 tools, we can fairly easily deal with algebraic manipulations of two distributions and also (bijective) functions of distributions.  No need for random variables at all.  Need (cumulative) distribution functions, Fundamental Theorem of Calculus, and the Dirac delta function.  Distribution functions should be it's own notebook, with links to this notebook and to somthing about [Riemann-Stieltjes integrals](https://en.wikipedia.org/wiki/Riemann%E2%80%93Stieltjes_integral); it's these two topics that make distribution functions worthy."

# ╔═╡ 133705ee-5679-4ead-ba3e-f4fdf7479b7a
md"## Function of a single distribution"

# ╔═╡ e6451454-5383-44e2-8fe2-0d13c81de491
md"Consider a distribution ``\mathbb{P}`` with distribution function ``F`` and density function ``f = F'``.  A bijective and increasing function ``h`` transforms ``F`` into a new distribution function ``G`` and thus creates a new distribution.  The distribution function ``G`` can be derived as follows.

By definition,

$$F(x) = \int f(s) 1_{(-\infty, x)}(s) \mathrm{d}s.$$

Take ``y = h(x)``, so that ``F`` transforms into ``G`` via the inverse ``h^{-1}``,

$$G(y) = F(h^{-1}(y)) = \int f(s) 1_{(-\infty, h^{-1}(y))}(s) \mathrm{d}s.$$
"

# ╔═╡ 2d0bf95b-46d9-46d3-b60c-dfc9c9528c46
md"If ``h`` were instead decreasing, then the inverse ``h^{-1}`` would incur a sign flip to give
…inverse h^{-1} would incur a sign flip….
	the formula does not have a -1 appearing, maybe a better term to describe the orientation reversal of the indicator


$$G(y) = F(h^{-1}(y)) = \int f(s) 1_{(h^{-1}(y), \infty)}(s) \mathrm{d}s.$$"

# ╔═╡ 5eccf84b-338b-4f58-802f-f2836f7f0cc7
md"The density function ``g`` associated with the distribution function ``G`` is found by taking the derivative with respect to ``y`` (and ignoring the possibly tricky interchange of integration and differentiation),

$$g(y) = \int f(s) 1_{\{h^{-1}(y)\}}(s) \left| \frac{\mathrm{d}h^{-1}}{\mathrm{d} y}(y) \right| \mathrm{d}s.$$

The absolute value covers both cases where ``h`` is either increasing or decreasing.  The indicator function ``1_{\{h^{-1}(y)\}}`` equals ``1`` when ``s = h^{-1}(y)``, so we replace ``s`` with ``h^{-1}(y)`` to get

$$g(y) = f(h^{-1}(y)) \left| \frac{\mathrm{d}h^{-1}}{\mathrm{d} y}(y) \right| \int 1_{\{h^{-1}(y)\}}(s) \mathrm{d}s.$$

Here we can treat the indicator function defined on a particular point as the Dirac delta function.  The integral of the Dirac delta function is ``1``, so that the density function of the distribution function ``G`` is

$$g(y) = f(h^{-1}(y)) \left| \frac{\mathrm{d}}{\mathrm{d} y} h^{-1}(y) \right|.$$

Geometrically, the chain rule accounts for the fact that ``h`` (potentially) warps the space on which ``\mathbb{P}`` assigns probabilities.  The term ``\left| \frac{\mathrm{d}h^{-1}}{\mathrm{d} y} (y) \right|`` ensures that the new density function ``g`` is an appropriate density function over this new space mapped by ``h``.
"

# ╔═╡ ab2544bb-29cc-49ce-8be0-45d9c187a6b9
md"**Practice** Consider the ``\text{Uniform}(0, 1)`` distribution and the function ``h(x) = -\log{(x)}``.  The density function of this Uniform distribution is ``f(x) = 1_{(0, 1)}(x)``.  The inverse of ``h`` is ``h^{-1}(y) = e^{-y}`` and has derivative ``\frac{\mathrm{d}h^{-1}}{\mathrm{d} y} (y) = -e^{-y}``.  Putting these pieces together we find

$$g(y) = f(h^{-1}(y)) \left| \frac{\mathrm{d}h^{-1}}{\mathrm{d} y} (y) \right| = 1_{(0, 1)}(e^{-y}) |-e^{-y}|.$$

The indicator function equals ``1`` when ``0 \leq e^{-y} \leq 1``.  Manipulating the inequalities gives ``0 \leq y \leq \infty``.  Simplifying,

$$g(y) = e^{-y} 1_{(0, \infty)}(y),$$

which is the density function of the ``\text{Exponential}(\lambda = 1)`` distribution."

# ╔═╡ 6d2f3686-1f33-4d5b-9a27-3fdad186b4c6
md"**Practice** Consider the function ``h(x) = -\log{(x)} / \lambda``.  What is the new density function ``g(y)`` defined by the transformation ``h`` applied to the ``\mathrm{Uniform}(0, 1)`` distribution?"

# ╔═╡ 7c8cbb8e-d400-486d-b259-d9ecd1b571e9
md"## Product"

# ╔═╡ c5e0e915-d424-4b01-b0c3-bc5f2d85afd0
md"For two independent distributions ``\mathbb{P}_x, \mathbb{P}_y`` with density functions ``f(x), f(y)``, the distribution function of their product can be found as

$$F(z) = \int \int f(x) f(y) 1_{(-\infty,  z)}(xy) \mathrm{d}x \mathrm{d}y.$$"

# ╔═╡ 23fc83b2-6604-4179-83c3-0ac1170fccb6
md"The density function associated with the above distribution function is found by taking the derivative of ``F(z)`` with respect to ``z``,

$$F'(z) = f(z) = \frac{\mathrm{d}}{\mathrm{d}z} \int \int f(x) f(y) 1_{(-\infty,  z)}(xy) \mathrm{d}x \mathrm{d}y.$$

We again ignore the possibly tricky business of interchanging differntiaton with integration to get

$$f(z) = \int \int f(x) f(y) \frac{\mathrm{d}}{\mathrm{d}z}  1_{(-\infty,  z)}(xy) \mathrm{d}x \mathrm{d}y.$$

Since the derivative of the indicator function ``1_{(-\infty,  z)}(xy)`` is infinite when ``z = xy`` and ``0`` otherwise, we put in place of the derivative of the indicator function the Dirac delta function (see the [Appendix](#Appendix))


$$f(z) = \int \int f(x) f(y) \delta(z - xy) \mathrm{d}x \mathrm{d}y.$$

The Dirac delta function ``\delta(z - xy)`` \"equals\" ``+\infty`` when ``z = xy`` ( ``y = z / x``) and ``0`` otherwise.  Replace ``f(y)`` with ``f_y(z / x)``, where the subscript ``y`` reminds us that this is the density function of the distribution ``\mathbb{P}_y``, to get

$$f(z) = \int f(x) f_y(z/x) \int \delta(z - xy) \; \mathrm{d}x \mathrm{d}y.$$"

# ╔═╡ 3fc3f877-5c16-4cf9-bb32-05fe53287eac
md"The Dirac delta function has a number of properties (see the [Appendix](#Appendix)) which allow us to simplify the expression for ``f(z)``."

# ╔═╡ 042be5df-5b96-4485-8d1e-3ccbe5d46fc6
md"The scaling property of the Dirac delta function is

$$\delta(z - xy) = \frac{1}{|x|}\delta(z/x - y).$$

The sifting property dictates

$$\int_{\mathbb{R}} \delta(s - y) \mathrm{d}y = 1.$$

Putting these together we find

$$\int \delta(z - xy) \mathrm{d}y  = \frac{1}{|x|}.$$"

# ╔═╡ 3aaf7632-b1b2-4432-afee-95de2de87e0b
md"Based on the properties of the Dirac delta function, the density function associated with the product of two distributions is

$$f(z) = \int f(x) f_y(z/x) \frac{1}{|x|}\mathrm{d}x.$$"

# ╔═╡ 1513b366-0fd0-49f9-8e8d-1ba8db6eb710
md"**Example** Notice that ``f(z)`` above is inherently different than simply multiplying two density functions together.  The product of two independent density functions defines a new density function, from which one could define the so called joint distribution, a distribution of two variables.  On the other hand, the product of two probability distributions, as described above, defines a new distribution of just one variable.  Let's consider an example."

# ╔═╡ 34ea06c8-0bd1-4cf8-8d4c-f321d20d37d6
md"Let ``\mathbb{P}_x = \text{Uniform}(1, 2)`` and ``\mathbb{P}_y = \text{Uniform}(1, 3).`` The product distribution defined by ``\mathbb{P} = \mathbb{P}_x * \mathbb{P}_y`` has density function

$$f(z) = \int f(x) f_y(z/x) \frac{1}{|x|}dx.$$

Since the density function of a ``\text{Uniform}(a, b)`` distribution is defined by

$$f(s) = \frac{1}{b- a}1_{(a, b)}(s),$$

we can write

$$f(z) = \int_{\mathbb{R}} 1_{(1,2)}(x) \cdot 0.5 \cdot 1_{(1,3)}(z/x) \frac{1}{|x|} \mathrm{d}x.$$

Recognizing that the indicator functions ``1_{(1,3)}(z/x)`` is equal to ``1`` when ``z/3 \leq x \leq z``, allows us to collapse the two indicator functions above into one indicator function in terms of ``x``.

$$f(z) = 0.5 \int_{\mathbb{R}} 1_{(\max(1, z/3), \min(2, z))}(x) \frac{1}{|x|} \mathrm{d}x = 0.5 \cdot [\log{(\min(2, z))} - \log{(\max(1, z/3))}].$$

To find the support for the density function ``f(z)``, consider again the two indicator functions ``1_{(1,2)}(x)`` and ``1_{(1,3)}(z/x)``.  The latter implies ``x \leq z \leq 3x``.  Since the former says that ``1 \leq x \leq 2``, it must be the case that ``1 \leq z \leq 6``.  So the final density function is

$$f(z) = 0.5 \cdot \log{\left( \frac{\min(2, z)}{\max(1, z/3)} \right)} 1_{(1, 6)}(z).$$
"

# ╔═╡ 039dd547-06b7-4e2a-b167-ba3ff2ca7bf2
md"A computer simulation of this product distribution is almost easier.  This gives us at least empirical evidence that our calculations were done correctly.  Define the two distributions as follows."

# ╔═╡ 975dcf5d-1272-494e-a73a-4f0188f8ec3b
begin
	Ux = Uniform(1, 3)
	Uy = Uniform(1, 2)
end

# ╔═╡ 2d6b8875-0c05-485a-a612-52db615ae94a
md"That the approximation (blue) and the true (red) density function overlap so closely indicates that our calculations are correct."

# ╔═╡ 02adf16b-7be6-40ef-bdc7-0639d96413c6
f(z) = 0.5 * (log(min(2, z) / max(1, z/3)))

# ╔═╡ 564f2097-6fb4-4fdc-b34d-3a9c28d295e9
md"On the other hand, the joint density function

$$f(x, y) = f(x) f(y) = 1_{(1,2)}(x) \cdot 0.5 \cdot 1_{(1,3)}(y)$$

defines a Uniform distribution in two dimensions, namely ``x`` and ``y``.  This density function is a flat surface with height ``0.5`` when ``1 \leq x \leq 2`` and ``1 \leq y \leq 3`` and ``0`` otherwise."

# ╔═╡ a1b2618b-516f-48cc-abaf-3b632b146960
f(x,y) = 0.5 * (1 < x < 2) * (1 < y < 3)

# ╔═╡ 06ded93b-df48-4f83-8321-09d0cba68a56
begin
	N = 100000
	z = rand(Ux, N) .* rand(Uy, N)
	p = density(z, linewidth = 2, label = "Approximate")
	z = 1:0.1:6
	plot!(p, z, f.(z), linewidth = 2, label = "True",
		xlabel = L"z", ylabel = L"f(z)")
end

# ╔═╡ 21700967-7c89-4699-ba0a-b409215c7675
begin
	x = 0:0.1:3
	y = 0:0.1:4
	wireframe(x, y, f, alpha = 0.0,
		xlabel = L"x", ylabel = L"y", zlabel = L"f(x, y)")
end

# ╔═╡ f6f81c53-ca48-4b6d-8c12-72ceb8bac007
md"This same strategy works for adding two independent distributions.  For two independent distributions ``\mathbb{P}_x, \mathbb{P}_y`` with density functions ``f(x), f(y)``, the distribution of their sum can be found as

$$F(z) = \int f(x) f(y) 1_{x + y \leq z} \mathrm{d}x \mathrm{d}y.$$

The density function associated with the above cumulative distribution function is found by taking the derivative with respect to ``z``,

$$f(z) = \int f(x) f(y) 1_{x + y = z} \mathrm{d}x \mathrm{d}y.$$

The indicator function 1_{x + y = z} is satisfied when ``y = z - x``, so we can replace ``f(y)`` with ``f(z - x)`` to get

$$f(z) = \int f(x) f_y(z - x) dx \int 1_{x + y = z} \mathrm{d}y.$$

By the scaling and sifting properties of the Dirac delta function, we find

$$f(z) = \int f(x) f_y(z - x) \mathrm{d}x,$$

which justifies the claim that the sum of two independent distributions is the [convolution](https://en.wikipedia.org/wiki/Convolution) of their density functions.
"

# ╔═╡ ab89c8a2-7706-4b97-bf9e-5d4a9f0b1878
md"**Practice** Try simulating the density function for the sum of two independent distributions.  Pick two distributions of your choice.  I recommend picking two distributions with matching support.  See [Distributions.jl documentation](https://juliastats.org/Distributions.jl/stable/univariate/#Continuous-Distributions) for a list of available distributions."

# ╔═╡ ff28cc23-4cc8-4e56-a7ed-c4a688f05f2c
md"**Practice** Try deriving a similar equation for the density function defined by the difference of two independent distributions.  Then approximate the density function through simulation to ensure your maths worked out correctly."

# ╔═╡ 3d1222f6-cedc-453e-856a-2e405526da99
md"* [Product distributoin](https://en.wikipedia.org/wiki/Product_distribution). *Wikipedia*. Retrieved May 17, 2021.
* [Dirac delta function](https://en.wikipedia.org/wiki/Dirac_delta_function). *Wikipedia*.  Retrieved May 17, 2021"

# ╔═╡ 582601d1-016e-4dc4-9c1d-5c966a0ae5a7
md"#### Dirac delta function, a definition and properties"

# ╔═╡ cc458129-bfcf-4ec9-8c83-df647da07b62
md"The [Dirac delta function](https://en.wikipedia.org/wiki/Dirac_delta_function) is a peculiar little \"function.\" Think of the Dirac delta function as a function named ``\delta`` which satisfies the following two properties

$$\delta(x) = \begin{cases}
      +\infty & x = 0 \\
      0 & x \not= 0 \\
\end{cases}$$

and

$$\int_{\mathbb{R}} \delta(x) \mathrm{d}x = 1.$$

The scaling property of the Dirac delta function is

$$\delta(\alpha x) = \frac{\delta(x)}{|\alpha|}$$

The sifting property is

$$\int_{-\infty}^{\infty} f(t) \delta(t - T) \mathrm{d}t = f(T).$$

The Dirac delta function is even,

$$\delta(-x) = \delta(x).$$

The integral of the Dirac delta function is equal to ``1``,

$$\int \delta(x) \mathrm{d}x = 1.$$
"

# ╔═╡ 932efc67-d2be-49ae-8c70-dac9f676e709
section(t) = @htl("""<h2 id="$t">$t</h2>""")

# ╔═╡ ebbb58e3-49fa-47e8-9257-ca344f6b3f80
section("Sum") # TODO derivative wrong, needs Delta function; and double integrals

# ╔═╡ 44377533-3fb5-4216-aeff-b9f8e629b3f3
section("References")

# ╔═╡ 3d4329c0-4aa1-40c9-848b-ace3d9fe6c5b
section("Appendix")

# ╔═╡ Cell order:
# ╠═675b7996-b2ab-11eb-378f-e5182b4b1e42
# ╠═ef98d806-5b7f-4d81-8f93-354a2c2ec9c2
# ╠═48b5b560-f2e7-4048-82cb-9fba1e666929
# ╠═133705ee-5679-4ead-ba3e-f4fdf7479b7a
# ╠═e6451454-5383-44e2-8fe2-0d13c81de491
# ╠═2d0bf95b-46d9-46d3-b60c-dfc9c9528c46
# ╠═5eccf84b-338b-4f58-802f-f2836f7f0cc7
# ╠═ab2544bb-29cc-49ce-8be0-45d9c187a6b9
# ╠═6d2f3686-1f33-4d5b-9a27-3fdad186b4c6
# ╠═7c8cbb8e-d400-486d-b259-d9ecd1b571e9
# ╠═c5e0e915-d424-4b01-b0c3-bc5f2d85afd0
# ╠═23fc83b2-6604-4179-83c3-0ac1170fccb6
# ╠═3fc3f877-5c16-4cf9-bb32-05fe53287eac
# ╠═042be5df-5b96-4485-8d1e-3ccbe5d46fc6
# ╠═3aaf7632-b1b2-4432-afee-95de2de87e0b
# ╠═1513b366-0fd0-49f9-8e8d-1ba8db6eb710
# ╠═34ea06c8-0bd1-4cf8-8d4c-f321d20d37d6
# ╠═039dd547-06b7-4e2a-b167-ba3ff2ca7bf2
# ╠═975dcf5d-1272-494e-a73a-4f0188f8ec3b
# ╠═2d6b8875-0c05-485a-a612-52db615ae94a
# ╠═06ded93b-df48-4f83-8321-09d0cba68a56
# ╠═02adf16b-7be6-40ef-bdc7-0639d96413c6
# ╠═564f2097-6fb4-4fdc-b34d-3a9c28d295e9
# ╠═a1b2618b-516f-48cc-abaf-3b632b146960
# ╠═21700967-7c89-4699-ba0a-b409215c7675
# ╠═ebbb58e3-49fa-47e8-9257-ca344f6b3f80
# ╠═f6f81c53-ca48-4b6d-8c12-72ceb8bac007
# ╠═ab89c8a2-7706-4b97-bf9e-5d4a9f0b1878
# ╠═ff28cc23-4cc8-4e56-a7ed-c4a688f05f2c
# ╠═44377533-3fb5-4216-aeff-b9f8e629b3f3
# ╠═3d1222f6-cedc-453e-856a-2e405526da99
# ╠═3d4329c0-4aa1-40c9-848b-ace3d9fe6c5b
# ╠═582601d1-016e-4dc4-9c1d-5c966a0ae5a7
# ╠═cc458129-bfcf-4ec9-8c83-df647da07b62
# ╠═d8fdab19-0c10-4696-b5df-cfd7ee9fac66
# ╠═8bede73d-97bf-420b-b664-509a16c0c32b
# ╠═9f0c25b0-1b53-415e-92d4-4b1b3bf7f650
# ╠═dafd1e7b-a4ba-4854-bcd3-3b266dc58a4a
# ╠═56488ebe-0d85-455e-a276-764e3b208795
# ╠═932efc67-d2be-49ae-8c70-dac9f676e709
