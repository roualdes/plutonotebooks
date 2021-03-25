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

# ╔═╡ f7e8e8ce-7dfc-11eb-0677-cb442926e519
using Distributions

# ╔═╡ e9b0055a-7dfc-11eb-2270-e30e833cee00
using StatsPlots

# ╔═╡ ef30e082-7dfd-11eb-3116-b590d75e8735
begin
	k = @bind K html"<input type='range' min='1.0' max='20.0' step='1.0' value='10'>"
	P = @bind p html"<input type='range' min='0.0' max='1.0' step='0.01' value='0.5'>"
	md"""**distribution parameters:**
	$$K$$: $k
	$$p$$: $P
	"""
end

# ╔═╡ 7f8de914-7dfd-11eb-100b-a33c8cfbd43d
x = [0:1:K;]

# ╔═╡ b887bd70-7e03-11eb-2ed9-4127c977a6d7
md"""
 $$K$$ = $K

 $$p$$ = $p
"""

# ╔═╡ c7a6a7aa-7dfe-11eb-1110-f313180ab599
begin
	m = K * p
	v = m * (1 - p)
	md"""
	Mean: $$K * p$$ = $m
	
	Variance: $$K * p * (1-p)$$ = $v
	"""
end

# ╔═╡ 821bd6d6-7dfe-11eb-1e6a-c5e52652461b
B = Binomial(K, p)

# ╔═╡ 7d111506-7dff-11eb-1b4d-f5b37e333a55
plot(x, pdf.(B, x), 
	t = "scatter", label = "Binomial($K, $p)",
	ylims = (0, maximum(pdf.(B, x)) + 0.1))

# ╔═╡ Cell order:
# ╠═7f8de914-7dfd-11eb-100b-a33c8cfbd43d
# ╟─ef30e082-7dfd-11eb-3116-b590d75e8735
# ╟─b887bd70-7e03-11eb-2ed9-4127c977a6d7
# ╟─c7a6a7aa-7dfe-11eb-1110-f313180ab599
# ╠═821bd6d6-7dfe-11eb-1e6a-c5e52652461b
# ╟─7d111506-7dff-11eb-1b4d-f5b37e333a55
# ╟─f7e8e8ce-7dfc-11eb-0677-cb442926e519
# ╟─e9b0055a-7dfc-11eb-2270-e30e833cee00
