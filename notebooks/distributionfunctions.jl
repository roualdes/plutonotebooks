### A Pluto.jl notebook ###
# v0.14.4

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 25708f4a-d8cf-4173-b91f-b26d376c6e63
using PlutoUI

# ╔═╡ 0b361845-67f2-4a04-abfd-3cce4b90702b
using Distributions

# ╔═╡ 40342b64-c8aa-4f5c-b6bf-3351bb7f42de
using StatsPlots

# ╔═╡ 022ffafb-06b2-4b4c-aeb7-25f2eaf7b0e4
using LaTeXStrings

# ╔═╡ 9deede7c-bb1a-11eb-08ae-f5290ff98dbf
md"# Distribution Functions"

# ╔═╡ 0adc90b3-c131-40d2-99eb-a0a0f8e54482
TableOfContents()

# ╔═╡ 48ac3572-5764-452c-8f8d-a4997c2da2ff
md"The (cumulative) distribution function associated with a probability distribution ``\mathbb{P}`` is the function ``F: \mathbb{R} \to [0, 1]`` defined by

$$F(x) = \mathbb{P}[(-\infty, x)]$$

for ``x \in \mathbb{R}``."

# ╔═╡ 050a5496-ec9f-4a02-be94-cbb53bbc1316
md"Although not all probability distributions admit density functions, these notebooks will take for granted the existence of a distribution's density function.  When the distribution ``\mathbb{P}`` is discrete, then the distribution function is defined in terms of the density function as

$$F(x) = \mathbb{P}[(-\infty, x)] = \sum_{s \in \mathbb{N}} 1_{(-\infty, x)}(s) f(s) .$$


When the distribution ``\mathbb{P}`` is continuous, then the distribution function is defined in terms of the density function as

$$F(x) = \mathbb{P}[(-\infty, x)] = \int_{\mathbb{R}} 1_{(-\infty, x)}(s) f(s) \mathrm{d}s.$$


The benefit of the above definition given only in terms of the distribution ``\mathbb{P}`` is that it equally applies to both discrete and continuous distributions.
"

# ╔═╡ c76115da-cac5-4dab-8f22-a1040ecbac02
md"It can help to visualize the definition of a distribution function for continuous distribution.  For a continuous distribution, the distribution function takes on the value equal to the area under the density function up to the point ``x``."

# ╔═╡ f0df1280-71d1-4e0b-b46c-7c73bd7e663f
md"Consider the ``\textrm{Exponential}(\theta)`` distribution.  The density function of the Exponential distribution is

$$f(x|\theta) = \frac{1}{\theta}e^{-x / \theta}1_{(0, \infty)}(x).$$

The sliders below help you recall how the Exponential density function changes as ``\theta`` changes and also allow you to interact with the distribution function as the argument ``x`` varies along the support of the Exponential distribution."

# ╔═╡ ccf41aeb-853d-4392-b429-605cba06931e
begin
	θ = @bind theta html"<input type='range' min='0.1' max='2.0' step='0.1' value='1.0'>"
	xs = @bind x html"<input type='range' min='0.0' max='10.0' step='0.1' value='1.0'>"
	md"""Exponential distribution parameter ``\theta``: $θ
	
	Argument to distribution function ``x``: $xs
	"""
end

# ╔═╡ 1ea1daa3-99ea-4a41-876a-e19c7ef6bce7
begin
	cols = get_color_palette(:auto, 17)
	E = Exponential(theta)
	m = 1 / theta
	mxs = m + 5 * m
	s = 0:0.01:mxs
	sfill = 0:0.01:x
	ppdf = plot(s, pdf.(E, s), 
		xlabel = L"s", ylabel = L"f(s)", 
		title = "Density function, θ = $theta", label = "",
		xlimits = (-0.1, mxs))
	plot!(ppdf, [-0.1, 0], [0, 0], 
		t = :line, color = cols[1], label = false)
	plot!(ppdf, sfill, pdf.(E, sfill), fill = (0, cols[1]), 
		color = cols[1], label = "")
	plot!(ppdf, [x, x], [0, pdf(E, x)], 
		t = :line, color = :black, linestyle = :dash, label = L"x = %$(x)")
end

# ╔═╡ e68e93b9-d415-452c-b026-4b92916bc08e
md"Alternatively, and more commonly, we can plot the distribution function itself."

# ╔═╡ 033e61a2-b09f-4bf4-89c6-a05c503fa54a
begin
	z = -2:0.01:mxs
	pcdf = plot(z, cdf.(E, z), 
		xlabel = L"s", ylabel = L"F(s)",
		title = "Distribution function, θ = $theta", label = "",
		xlimits = (-0.1, mxs))
	q = round(cdf(E, x); digits = 2)
	plot!(pcdf, [x, x], [0, q],
			t = :line, c = :black, linestyle = :dash, label = L"x = %$(x)")
	plot!(pcdf, [-2, x], [q, q],
			t = :line, c = :black, label = L"F(x) = %$(q)",
			legend = :bottomright)
end

# ╔═╡ 40d21132-6695-47ae-a6b3-334c32f063b5


# ╔═╡ Cell order:
# ╠═9deede7c-bb1a-11eb-08ae-f5290ff98dbf
# ╠═0adc90b3-c131-40d2-99eb-a0a0f8e54482
# ╠═48ac3572-5764-452c-8f8d-a4997c2da2ff
# ╠═050a5496-ec9f-4a02-be94-cbb53bbc1316
# ╠═c76115da-cac5-4dab-8f22-a1040ecbac02
# ╟─1ea1daa3-99ea-4a41-876a-e19c7ef6bce7
# ╟─f0df1280-71d1-4e0b-b46c-7c73bd7e663f
# ╟─ccf41aeb-853d-4392-b429-605cba06931e
# ╟─e68e93b9-d415-452c-b026-4b92916bc08e
# ╠═033e61a2-b09f-4bf4-89c6-a05c503fa54a
# ╠═40d21132-6695-47ae-a6b3-334c32f063b5
# ╠═25708f4a-d8cf-4173-b91f-b26d376c6e63
# ╠═0b361845-67f2-4a04-abfd-3cce4b90702b
# ╠═40342b64-c8aa-4f5c-b6bf-3351bb7f42de
# ╠═022ffafb-06b2-4b4c-aeb7-25f2eaf7b0e4
