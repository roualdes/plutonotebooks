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

# ╔═╡ f01568ca-a480-11eb-20c5-039d52fd7c70
begin
	using StatsPlots
	using PlutoUI
end

# ╔═╡ 72bc5d01-1a22-4837-af46-db56c02406e6
md"# Joint, Marginal, and Conditional Densities"

# ╔═╡ a010879a-571a-4098-8c7d-5880044c5e6b
md"Consider the **joint** density

$$f(x, y) = 4x^2y + 2y^5, \quad \text{ for } y \in [0, 1] \text{ and } x \in [0, 1].$$

We can visualize this as"

# ╔═╡ 008cc8d7-8a36-4643-a282-c68fb849da55
md"""The **marginal** density with respect to to $y$ is give by

$$f(y) = \frac{4}{3}y + 2y^5,$$

and the **conditional** density of $y$ given $x$ is

$$g(y|x) = \frac{4x^2y + 2y^5}{2x^2 + 1/3}.$$

Given some value of $x$, the conditional density $g(y|x)$ will change, but since the marginal density $f(y)$ has no dependence on $x$ it does not change as $x$ changes.  For the marginal density $f(y)$, we've already integrated over $x$ to remove the dependence on it.
"""

# ╔═╡ 4c36ebbe-8175-43f5-84f3-5a5aa046223e
md"Notice that at $x = 0.6$, $g(y|x) \approx f(y)$, and for all other values of $x$ the densities are clearly different."

# ╔═╡ 369567b4-b4a7-4eae-b5ea-43236f7375da
md"Adjust the value of $x$ with the slider below."

# ╔═╡ ac44d408-3ee0-4bce-aa68-92cb786934de
md"``x=`` $(@bind x Slider(0:0.1:1, default = 0.8, show_value = true))"

# ╔═╡ 47866c5f-b961-4db0-a5cd-0eb26ccf3359
md"To calculate the probabilities above, you need to perform integration, since these are continuous distributions:

$$\mathbb{P}[Y \in [0.2, 0.3] ] = \int_{[0.2, 0.3]} f(y) dy$$

and

$$\mathbb{P}[Y\in [0.2, 0.3] | X = x] = \int_{[0.2, 0.3]}  g(y|x) dy$$
"

# ╔═╡ a9b83b43-38f5-42ff-aa3c-b345ecf7fc3e
y = 0:0.05:1;

# ╔═╡ ed32a057-c61d-4dae-ad51-9b8a0b1ecd43
plot(y, y, (x, y) -> 4x^2 * y + 2y^5,
	xlabel = "x", ylabel = "y", zlabel = "f(x, y)",	t = :wireframe)

# ╔═╡ 393f86db-3259-45f9-84da-6205d5d2c928
f(y) = 4y/3 + 2y^5;

# ╔═╡ 60ab4f05-5819-4b48-9265-c531d4359153
g(y) = (4x^2 * y + 2y^5) / (2x^2 + 1/3);

# ╔═╡ 4398444f-1708-4755-8104-12e206b6640e
begin
	yfillmin = 0.2
	yfillmax = 0.3
	yfill = 0.2:0.05:0.3
end;

# ╔═╡ fc5259cb-1c3c-476f-868c-7ef244d9a7a7
begin
	F(y) = (2y^2 + y^6) / 3
	G(y) = (2x^2 * y^2 + y^6 / 3) / (2x^2 + 1/3)
end;

# ╔═╡ 2fc3983e-2b6c-42c6-8e44-b6178ad2e42b
begin
	vF = round(F(yfillmax) - F(yfillmin); digits = 3)
	vG = round(G(yfillmax) - G(yfillmin); digits = 3)
end;

# ╔═╡ 9e438242-5426-4dbc-af3f-c9f07b15b154
md"The probabilities ``\mathbb{P}[Y \in [0.2, 0.3] ] =`` $vF and ``\mathbb{P}[Y\in [0.2, 0.3] | X = x] =`` $vG are shown in the plot below.  The two shades of grey are meant to aid visualization."

# ╔═╡ c7a8192e-a2f9-4192-92e7-fbe316e946ac
begin
	plot(y, f.(y), label = "f(y)", color = :blue, ylabel = "Density", xlabel = "y")
	plot!(y, g.(y), label = "g(y|x = $(x))", color = :orange, legend = :topleft)
	if vF > vG
		plot!(yfill, f.(yfill), fill = (0, :grey90), label = "", seriescolor = :blue)
		plot!(yfill, g.(yfill), fill = (0, :grey70), label = "", seriescolor = :orange)
	else
		plot!(yfill, g.(yfill), fill = (0, :grey90), label = "", seriescolor = :orange)
		plot!(yfill, f.(yfill), fill = (0, :grey70), label = "", seriescolor = :blue)
	end
end

# ╔═╡ Cell order:
# ╟─72bc5d01-1a22-4837-af46-db56c02406e6
# ╟─a010879a-571a-4098-8c7d-5880044c5e6b
# ╟─ed32a057-c61d-4dae-ad51-9b8a0b1ecd43
# ╟─008cc8d7-8a36-4643-a282-c68fb849da55
# ╟─4c36ebbe-8175-43f5-84f3-5a5aa046223e
# ╟─9e438242-5426-4dbc-af3f-c9f07b15b154
# ╟─369567b4-b4a7-4eae-b5ea-43236f7375da
# ╟─ac44d408-3ee0-4bce-aa68-92cb786934de
# ╟─c7a8192e-a2f9-4192-92e7-fbe316e946ac
# ╟─47866c5f-b961-4db0-a5cd-0eb26ccf3359
# ╟─a9b83b43-38f5-42ff-aa3c-b345ecf7fc3e
# ╟─393f86db-3259-45f9-84da-6205d5d2c928
# ╟─60ab4f05-5819-4b48-9265-c531d4359153
# ╟─4398444f-1708-4755-8104-12e206b6640e
# ╟─fc5259cb-1c3c-476f-868c-7ef244d9a7a7
# ╟─2fc3983e-2b6c-42c6-8e44-b6178ad2e42b
# ╟─f01568ca-a480-11eb-20c5-039d52fd7c70
