### A Pluto.jl notebook ###
# v0.12.21

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

# ╔═╡ 5163d91e-7e01-11eb-3d85-1bde1b52bcc2
using Distributions

# ╔═╡ 4cac0536-7e01-11eb-0f19-29257e61fef3
using StatsPlots

# ╔═╡ 9bcb7778-7e01-11eb-38f5-0d934dfa6201
x = [0:0.01:1;]

# ╔═╡ 5605125a-7e01-11eb-13a6-596920930e6a
begin
	α = @bind a html"<input type='range' min='0.1' max='10' step='0.1' value='5'>"
	β = @bind b html"<input type='range' min='0.1' max='10' step='0.1' value='5'>"
	md"""**distribution parameters:**
	$$\alpha$$: $α
	$$\beta$$: $β
	"""
end

# ╔═╡ 0132d818-7e02-11eb-1a70-bdb0bbcefa7a
md"""
 $$\alpha$$ = $a

 $$\beta$$ = $b
"""

# ╔═╡ 8cb866a0-7e02-11eb-1fdb-eff565b95d5f
begin
	apb = a + b
	m = a / (apb)
	v = a * b / apb * apb * (apb + 1)
	md"""
	Mean: $$\frac{\alpha}{\alpha + \beta}$$ = $m
	
	Variance: $$\frac{\alpha\beta}{(\alpha + \beta)^2 * (\alpha + \beta +1)}$$ = $v
	"""
end

# ╔═╡ 8fa79d8c-7e01-11eb-19a7-d33fcde6ff4c
B = Beta(a, b)

# ╔═╡ 995a9474-7e01-11eb-348b-cb8a8233b489
plot(x, pdf.(B, x), 
	label = "Beta($a, $b)", linewidth = 2)

# ╔═╡ Cell order:
# ╟─9bcb7778-7e01-11eb-38f5-0d934dfa6201
# ╟─5605125a-7e01-11eb-13a6-596920930e6a
# ╟─0132d818-7e02-11eb-1a70-bdb0bbcefa7a
# ╟─8cb866a0-7e02-11eb-1fdb-eff565b95d5f
# ╠═8fa79d8c-7e01-11eb-19a7-d33fcde6ff4c
# ╟─995a9474-7e01-11eb-348b-cb8a8233b489
# ╟─5163d91e-7e01-11eb-3d85-1bde1b52bcc2
# ╟─4cac0536-7e01-11eb-0f19-29257e61fef3
