### A Pluto.jl notebook ###
# v0.14.1

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

# ╔═╡ da4b6f2a-923e-11eb-3f34-cd40c2f87cd5
begin
	using Distributions
	using PlutoUI
	using Statistics
	using StatsPlots
end;

# ╔═╡ c032f824-923e-11eb-2e29-29847cbf1063
md"# A Central Limit Theorem"

# ╔═╡ 0f1865b4-93e3-11eb-38a1-a11e4048d827
TableOfContents()

# ╔═╡ 1c8c2488-93e3-11eb-1864-a7f2a7454e1b
md"## Words"

# ╔═╡ 1a896920-9307-11eb-3a80-63564275f568
md"The Central Limit Theorem discussed here describes the distribution of the random variable, the sample mean.  We don't usually think about a sample mean as a random variable, but that's the first major hurdle to understanding any Central Limit Theorem, functions of random variables are random variables.  Any statistic can be thought of as a random variable."

# ╔═╡ 80a3f330-9308-11eb-0ca5-77b0627d968f
md"Since statistics are random variables, they often follow some distribution.  Most times, we don't know the distribution associated with a statistic.  When the statistic is the mean, then this Central Limit Theorem tells us that the distribution of the sample mean is approximately Normal."

# ╔═╡ b64df9c2-9308-11eb-27f5-3d230dc92312
md"According to this Central Limit Theorem, **the distribution of the sample mean is approximately Normal**.  Therefore the density function of the sample mean describes which values any random mean is most likely to take on."

# ╔═╡ debdea5e-9308-11eb-29f7-71208f83e317
md"Note that we will have to massage the math behind this Central Limit Theorem to better visualize what is going on."

# ╔═╡ 4e184eaa-9307-11eb-1af5-4b2fdc6bbc6b
md"We usually think about one dataset being randomly sampled from a distribution.  Here, we'll consider a sample mean as coming from a distribution.  To help us imagine this abstraction, consider you and $$R - 1$$ of your friends each going out to collect your own random sample from the same process.  By the time each of you collects your own sample of size $$N$$ and then calculates your own mean (from your own data), there will be $$R$$ means."

# ╔═╡ 3e9630c6-9309-11eb-3cf5-73b109c4b412
md"This Central Limit Theorem says that the shape of these $$R$$ means will be approximately Normal, and more over that the width of this Normal distribution depends on $$N$$ (and the variance of the theoretical distribution from which you and your friends sampled from) and the approximation will improve as $$R$$ goes off to infinity."

# ╔═╡ 75dab232-9309-11eb-0f2a-ed982699b343
md"This last bit is where the math and our vizualization below differ.  Mathematically, the approximation and the width of the distribution of the sample mean both only depend on the sample size $$N$$.  The mathematical theory says that as $$N \to \infty$$, then the Normal approximation improves and the width of the distribution will decrease with the square root of the sample size $$N$$."

# ╔═╡ dc33209e-9309-11eb-099b-0f6bc414032a
md"To see visualize this process, pick a distribution below that is supposed to represent the distribution you and your $$R-1$$ friends are sampling from.  Then adjust the sample size and the number of friends $$R$$ you have to see the effect of the sampling distribution of the sample mean.  **Notice that this Central Limit Theorem is indifferent to the shape of the theoretical distribution; whatever shape it has, the sampling distribution is still approximately Normal.**"

# ╔═╡ 36c19130-93e3-11eb-0e54-f7c547f3b438
md"## Pictures"

# ╔═╡ 22658db8-923f-11eb-21ed-0bd2f08bf338
md"""Pick a distribution
$(@bind distribution Select([
	"Gamma" => "Gamma", 
	"Normal" => "Normal",
	"Uniform" => "Uniform"]))
"""

# ╔═╡ f2d7090a-9301-11eb-06c8-0fa5fc97ce84
md"""
 $$N$$ = $(@bind N Slider(1:301, default = 27, show_value = true)) $$\quad$$
 $$R$$ = $(@bind R Slider(1:1001, default = 101, show_value = true))
"""

# ╔═╡ f69147d2-930a-11eb-3757-07178c0dadc8
md"## Math"

# ╔═╡ 7b0e370a-930a-11eb-2e33-0bed472a2026
html"<div id=\"math\"></div>"

# ╔═╡ 1f93e9d0-930b-11eb-2220-332796c4523e
md"Assume you and your $$R-1$$ friends are randomly sampling from distribution $$F$$ with mean $$\mu$$ and variance $$\sigma^2$$.  In a simple version of the Central Limit Theorem of sample means, we require $$\sigma^2 < \infty$$ and the original data to be independent and identically distributed, $$X_1, \ldots, X_N \sim_{iid} F$$."

# ╔═╡ ff9123be-93e3-11eb-3fc5-076772232b87
md"Denote the sample mean as $$\hat{\mu} = N^{-1} \sum_{n = 1}^N X_N$$.  Then by this Central Limit Theorem we have that 

$\frac{\hat{\mu} - \mu}{\sigma / \sqrt{N}} \sim N(0, 1)$

as $$N \rightarrow \infty$$."

# ╔═╡ bb1c25f4-9301-11eb-26ce-158f5bb94eae
D = 
if distribution == "Gamma"
    Gamma(1, 10)
elseif distribution == "Normal"
	Normal(0, 10)
elseif distribution == "Uniform"
	Uniform(1, 6)
end;

# ╔═╡ aa79d4ac-923f-11eb-111d-3dceaf63f63d
begin 
	p = plot(D, label = "", linewidth = 2, title = "Theoretical distribution: $(distribution)")
	plot!(p, [mean(D)], [0], t = :scatter, color = :black, label = "mean", markersize = 15, markershape = :utriangle)
end

# ╔═╡ a44bae34-9302-11eb-3367-cb12648d16be
samplemeans = [mean(rand(D, N)) for _ in 1:R]

# ╔═╡ 1966e0fe-9302-11eb-3ec2-0515c69711a1
begin
	h = histogram(samplemeans, legend = false, 
		title = "Sampling distribution \n R = $(R) sample means \n each with N = $(N) observations")
	plot!(h, [mean(D)], [0], t = :scatter, color = :black, label = "mean", markersize = 15, markershape = :utriangle)
end

# ╔═╡ 86fde510-9300-11eb-2dd9-c1dc68850b33
onedataset = rand(D, N)

# ╔═╡ Cell order:
# ╟─c032f824-923e-11eb-2e29-29847cbf1063
# ╟─0f1865b4-93e3-11eb-38a1-a11e4048d827
# ╟─1c8c2488-93e3-11eb-1864-a7f2a7454e1b
# ╟─1a896920-9307-11eb-3a80-63564275f568
# ╟─80a3f330-9308-11eb-0ca5-77b0627d968f
# ╟─b64df9c2-9308-11eb-27f5-3d230dc92312
# ╟─debdea5e-9308-11eb-29f7-71208f83e317
# ╟─4e184eaa-9307-11eb-1af5-4b2fdc6bbc6b
# ╟─3e9630c6-9309-11eb-3cf5-73b109c4b412
# ╟─75dab232-9309-11eb-0f2a-ed982699b343
# ╟─dc33209e-9309-11eb-099b-0f6bc414032a
# ╟─36c19130-93e3-11eb-0e54-f7c547f3b438
# ╟─22658db8-923f-11eb-21ed-0bd2f08bf338
# ╟─aa79d4ac-923f-11eb-111d-3dceaf63f63d
# ╟─f2d7090a-9301-11eb-06c8-0fa5fc97ce84
# ╟─1966e0fe-9302-11eb-3ec2-0515c69711a1
# ╟─a44bae34-9302-11eb-3367-cb12648d16be
# ╟─86fde510-9300-11eb-2dd9-c1dc68850b33
# ╟─f69147d2-930a-11eb-3757-07178c0dadc8
# ╟─7b0e370a-930a-11eb-2e33-0bed472a2026
# ╟─1f93e9d0-930b-11eb-2220-332796c4523e
# ╟─ff9123be-93e3-11eb-3fc5-076772232b87
# ╟─bb1c25f4-9301-11eb-26ce-158f5bb94eae
# ╟─da4b6f2a-923e-11eb-3f34-cd40c2f87cd5
