### A Pluto.jl notebook ###
# v0.14.4

using Markdown
using InteractiveUtils

# ╔═╡ 675b7996-b2ab-11eb-378f-e5182b4b1e42
md"# Algebra of Distributions"

# ╔═╡ a69f8d69-035c-44b6-b55d-450e1822c408
md"See Wikipedia's page on [https://en.wikipedia.org/wiki/Product_distribution#Proof_[3]](Product Distribution) for more details on the following example."

# ╔═╡ 23fc83b2-6604-4179-83c3-0ac1170fccb6
md"For two independent distributions with density functions ``f_x(x), f_y(y)``, the distribution of their product can be found as

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

# ╔═╡ f6f81c53-ca48-4b6d-8c12-72ceb8bac007
md"TODO I'm interested in seeing what random variables bring to the table here.  Could we do a similar proof as that above without the use of random variables?"

# ╔═╡ cc458129-bfcf-4ec9-8c83-df647da07b62
md"TODO Put Wikipedia referenced Dirac delta function properties in an Appendix, and then refer to this section in the notes above.

The scaling property of of the [Dirac delta function](https://en.wikipedia.org/wiki/Dirac_delta_function#Properties)

$$\delta(\alpha x) = \frac{\delta(x)}{|\alpha|}$$

The sifting property is

$$\int_{-\infty}^{\infty} f(t) \delta(t - T)dt = f(T).$$

The Diract delta function is even, 

$$\delta(-x) = \delta(x).$$
"

# ╔═╡ Cell order:
# ╠═675b7996-b2ab-11eb-378f-e5182b4b1e42
# ╠═a69f8d69-035c-44b6-b55d-450e1822c408
# ╠═23fc83b2-6604-4179-83c3-0ac1170fccb6
# ╠═f6f81c53-ca48-4b6d-8c12-72ceb8bac007
# ╠═cc458129-bfcf-4ec9-8c83-df647da07b62
