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

# ╔═╡ 1fb420cb-57f1-4315-a434-7fa7ff9466fb
using StatsPlots

# ╔═╡ 2d6a3b22-9c23-477f-8983-85ca95dee9b3
using Distributions

# ╔═╡ b5f25c61-128c-44a4-80a4-dfb99679f616
using LaTeXStrings

# ╔═╡ aa2188ce-1c9a-4726-86ec-a10cc0955b18
using PlutoUI

# ╔═╡ 76d13d5b-2938-4a98-86c4-b67a1e0e75ba
begin
	using CSV
	using DataFrames
	using HTTP
	using Optim
end

# ╔═╡ 91418b2a-be49-11eb-0f68-274eae7e9bca
md"# Density Functions"

# ╔═╡ fc2e6395-1ad4-45a1-9906-f30adf17ac2c
md"Density functions describe patterns in which we might expect to see random quantities.  Such random quantities could be data, or variables of another density function, where the latter describes patterns of random data."

# ╔═╡ d293c41f-3aeb-48a7-b3db-b573ad185f74
md"Consider the density function below, which models the days between rain events at the Winnipeg International Airport in Canada.  Assumining this density function accurately represents the truth, the area under the density function and within the interval ``A = (0, 1)`` represents the probability that we expect to see the next rain event within ``1`` day.  Further, we might say there is a ``0.14``% chance of seeing the next rain event within ``2`` to ``3`` days.  More generally, area under this density function defines the probabilities we expect to see the next rain event within some interval."

# ╔═╡ 982bd9e2-de14-468a-9246-12b4a7b3686f
md"Use the sliders below to change the intervals ``(a, b)`` by choosing the values for ``a`` and ``b``, and similarly for the interval ``(c, d)``.  The probabilities associated with these intervals is displayed in the legend of the plot below."

# ╔═╡ 845d08b9-72ea-427d-ac1e-22eeacd9c48b
begin
	sa = @bind a html"<input type='range' min='0' max='1.0' step='0.1' value='0.0'>"
	sb = @bind b html"<input type='range' min='1.0' max='5.0' step='0.1' value='1.0'>"
	sc = @bind c html"<input type='range' min='2.0' max='3.0' step='0.1' value='2.0'>"
	sd = @bind d html"<input type='range' min='3.0' max='5.0' step='0.1' value='3.0'>"
	md"""``a``: $sa ``b``: $sb
	
	``c``: $sc ``d``: $sd
	"""
end

# ╔═╡ 8efecd9e-443b-4240-b315-ab061a41708c
begin
	url = "https://vincentarelbundock.github.io/Rdatasets/csv/DAAG/droughts.csv"
	df = DataFrame(CSV.File(HTTP.get(url).body))
end;

# ╔═╡ dae6b652-8a89-43d3-897f-3cc20a66494f
llexp(θ, x) = length(x) * log(θ[1]) + sum(x) / θ[1]

# ╔═╡ 64903365-a29b-4020-be4d-1940097f4047
begin
	o = optimize(θ -> llexp(θ, df[:, "length"]), 
		[1e-5], [Inf], [0.5],  Fminbox(GradientDescent()))
	θ = Optim.minimizer(o)
end;

# ╔═╡ f68786e3-3775-4063-9ef3-ca7ccc487d10
begin
	cols = get_color_palette(:auto, 17)
	E = Exponential(θ[1])
	mxs = 6
	z = 0:0.01:mxs
	pexp =	plot(z, pdf.(E, z), label = false)
	zfill = a:0.01:b
	pA = round(cdf(E, b) - cdf(E, a); digits = 2)
	plot!(pexp, zfill, pdf.(E, zfill), fill = (0, cols[1]), 
		label = L"\mathbb{P}[(%$a, %$b)] = %$pA", color = cols[1],
		title = "Density function",
		xlabel = L"x", ylabel = L"f(x)", alpha = 0.75)
	Bfill = c:0.01:d
	pB = round(cdf(E, d) - cdf(E, c); digits = 2)
	plot!(pexp, Bfill, pdf.(E, Bfill), fill = (0, cols[2]), 
		label = L"\mathbb{P}[(%$c, %$d)] = %$pB", color = cols[2],
		title = "Density function",
		xlabel = L"x", ylabel = L"f(x)", alpha = 0.75)
end

# ╔═╡ Cell order:
# ╠═91418b2a-be49-11eb-0f68-274eae7e9bca
# ╠═fc2e6395-1ad4-45a1-9906-f30adf17ac2c
# ╠═d293c41f-3aeb-48a7-b3db-b573ad185f74
# ╠═982bd9e2-de14-468a-9246-12b4a7b3686f
# ╠═845d08b9-72ea-427d-ac1e-22eeacd9c48b
# ╠═f68786e3-3775-4063-9ef3-ca7ccc487d10
# ╠═1fb420cb-57f1-4315-a434-7fa7ff9466fb
# ╠═2d6a3b22-9c23-477f-8983-85ca95dee9b3
# ╠═b5f25c61-128c-44a4-80a4-dfb99679f616
# ╠═aa2188ce-1c9a-4726-86ec-a10cc0955b18
# ╠═76d13d5b-2938-4a98-86c4-b67a1e0e75ba
# ╠═8efecd9e-443b-4240-b315-ab061a41708c
# ╠═dae6b652-8a89-43d3-897f-3cc20a66494f
# ╠═64903365-a29b-4020-be4d-1940097f4047
