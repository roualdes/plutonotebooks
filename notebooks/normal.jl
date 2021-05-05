### A Pluto.jl notebook ###
# v0.14.3

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

# ╔═╡ c07e59de-7de1-11eb-31ba-9febfeacb93f
using Distributions

# ╔═╡ 73290c6a-7dd7-11eb-363c-1ff5a2aad1f5
using StatsPlots

# ╔═╡ f001ec14-8cbd-11eb-19a0-2123c7470848
md"# Family of Normal Distributions"

# ╔═╡ c4145b48-7de1-11eb-059d-870e7d3004c5
begin
	μ = @bind mu html"<input type='range' min='-10.0' max='10.0' step='0.1' value='0.0'>"
	σ = @bind sigma html"<input type='range' min='1' max='10.0' step='0.1' value='1.0'>"
	md"""**distribution parameters:**
	$$\mu$$: $μ
	$$\sigma$$: $σ
	"""
end

# ╔═╡ b0fa3884-7de1-11eb-11e1-7dcc4792c795
x = [mu - 5 * sigma:0.1:mu + 5 * sigma;]

# ╔═╡ 8ad224ba-7e03-11eb-3390-fd30f91b85b6
md"""
 $$\mu$$ = $mu

 $$\sigma$$ = $sigma
"""

# ╔═╡ 019515ce-7de3-11eb-39ac-f5a83fb11fb7
md"""
Mean: $$\mu$$ = $mu

Variance: $$\sigma^2$$ = $(sigma^2)
"""

# ╔═╡ b940194a-7de2-11eb-2f76-ad1abefdb11d
N = Normal(mu, sigma);

# ╔═╡ b15f8620-7de2-11eb-323f-2f98407f01f3
plot(x, pdf.(N, x), label = "Normal( $mu, $(sigma^2) )", 
	linewidth = 2, 	ylims = (0, 0.45 / sigma^0.5))

# ╔═╡ Cell order:
# ╟─f001ec14-8cbd-11eb-19a0-2123c7470848
# ╟─b0fa3884-7de1-11eb-11e1-7dcc4792c795
# ╟─c4145b48-7de1-11eb-059d-870e7d3004c5
# ╟─8ad224ba-7e03-11eb-3390-fd30f91b85b6
# ╟─019515ce-7de3-11eb-39ac-f5a83fb11fb7
# ╠═b940194a-7de2-11eb-2f76-ad1abefdb11d
# ╟─b15f8620-7de2-11eb-323f-2f98407f01f3
# ╟─c07e59de-7de1-11eb-31ba-9febfeacb93f
# ╟─73290c6a-7dd7-11eb-363c-1ff5a2aad1f5
