### A Pluto.jl notebook ###
# v0.14.3

using Markdown
using InteractiveUtils

# ╔═╡ d9787218-49c2-4411-ac21-f4306445fc5b
using StatsPlots

# ╔═╡ ac3313aa-b096-45f4-be71-698d83e847b4
using LaTeXStrings

# ╔═╡ 3f1c58c7-4b1b-4b9a-9abc-a43d8624e724
using HypertextLiteral

# ╔═╡ a03e4500-a9d1-11eb-34c2-fd5b156bfa8c
md"# Expectation"

# ╔═╡ e28f76be-713c-4e97-a781-d865266e06cb
md"The most common way to represent probability, from a particular probability distribution, is as area under the distribution's density function.  A probability distribution's density function is a topic unto itself.  For futher details about these functions you should read the notebook Density Functions.

TODO how to link across notebooks? Need to consider different environments."

# ╔═╡ bff2993b-5c99-44d1-a0e3-4c1db6cf24c8
md"After about calculus 2, when you hear the phrase area under a function we immediately think integral and maybe a picture like this, and this is exactly what you should have in mind."

# ╔═╡ 4f38b947-fe25-4dc1-ba71-a9823670afde
begin
	f(x) = 0.0 < x < 1.0 ? x^2 : 0.0
	x = -1:0.01:2
	xfill = 0.5:0.01:0.75
	cols = get_color_palette(:auto, 17)
	plot(x, f.(x), label = false, c = cols[1], xlimits = (-1, 2),
		xlabel = L"x", ylabel = L"f(x)")
	plot!(xfill, xfill.^2, linecolor = false, fill = (0, cols[1]), label = false)
end

# ╔═╡ b7488907-6f98-48ad-b83e-925777675bea
md"We use this canonical image of area under a function as our starting point.  We will adapt this idea in a few specific ways so as to 

1. satisfy the Axioms of Probability, and 
2. expand the problem domain of probability distributions and thus statistics."

# ╔═╡ 6a8a8453-7fe4-43d4-8e7a-d88390cb57a5
md"To adapt our understanding of area under a function to the Axioms of Probability, we will require that these distribution-specific functions will need to have area under them equal to 1, and that these functions be non-negative; we don't want probabilities smaller than zero or greater than one.  This ensures that area under the distribution's density function makes an appropriate analogy to probability."

# ╔═╡ b6679398-7962-4f27-a3b3-ac05fb13b40c
md"Further, we need to expand our thinking about area under functions to deal with area under functions defined on countable (or finite) spaces.  The plot below represents area under a function at the points ``x \in \{6, 7, 8, 9\}``, where the function is only defined on the integers between ``0`` and ``10``."

# ╔═╡ cc5c354a-32e5-4fc7-bf66-3d62a33b7131
begin
	gaskeypad = (0 => 0.0, 1 => 0.0, 2 => 3/25, 3 => 1/25, 4 => 0.0, 5 => 5/25,
		6 => 2/25, 7 => 2/25, 8 => 1/25, 9 => 11/25)	
	y = 0:10
	yfill = 6:9
	p = plot(y, [last(gkp) for gkp in gaskeypad], t = :scatter, 
		xlabel = L"x", ylabel = L"g(x)", label = false)
	for yf in yfill
	 plot!(p, [yf, yf], [0.0, gaskeypad[yf+1][2]], t = :line, 
			c = cols[1], linewidth = 2, label = false)
	end
	p
end

# ╔═╡ ff4f758f-3665-44e9-b006-09bae8f3fbe1
md"Putting these requirements together we get that a distribution's density function, let's call it ``f``, satisfies ``f(x) \geq 0`` and area under the function be equal to ``1``.  For more details on density functions, see the notebook on [TODO link to] Density Functions.  To generalize area under the (distribution's density) function, for distributions defined on either countable (or finite) spaces or uncountable spaces, we turn to the operation expectation."

# ╔═╡ 7db423e3-4611-42cf-8c43-e63face3995d
md"Probability distributions are classified into two classes discrete and continuous.  **Discrete distributions** are probability distributions defined on a finite or countable sample space.  **Continous distributions** are probability distributions defined on an uncountable sample space.  **Expectation** generalizes area under a function to apply to either discrete or continuous distributions.  For more details see the notebook on [TODO add link] Expectation.  For now, we'll re-write Axiom of Probability 2. with an expectation.

$$1 = \mathbb{P}[S] = \mathbb{E}[\mathbb{1}_S]  = \left\{
        \begin{array}{ll}
            \sum_{S} \mathbb{1}_S(x) f(x) & \quad \mathbb{P} \text{ is discrete} \\
            \int_{S} \mathbb{1}_S(x) f(x) & \quad \mathbb{P} \text{ is continuous} \\
        \end{array}
    \right.$$"

# ╔═╡ edd74e8f-bab7-48b7-8d2a-e45738cbbcc7
md"Consider the density function ``f(x)`` from above. Notice that the function is defined to be ``0`` outside of the interval ``[0, 1]``.  We might write this density function's definition as

$$f(x) = x^2 * \mathbb{1}_{[0, 1]}(x).$$

With this definition we can verify the Axioms of Probability.

1. Non-negative probability is assigned to any set ``A \subseteq [0, 1].``

$$\mathbb{P}[A] = \mathbb{E}[\mathbb{1}_A] = \int_{S} \mathbb{1}_A(x) f(x) dx \geq 0$$

2. Probability ``1`` is assigned to the entire sample space.

$$\mathbb{P}[S] = \mathbb{E}[\mathbb{1}_S] = \int_{S} \mathbb{1}_S(x) f(x) dx = 1.$$

3. The probability of a disjoint union of sets is equal to the sum of the probabilities of each of the union's components.

    This follows since sums and intergals, and thus expectation, is a linear operation."

# ╔═╡ 0195924a-c864-4ddd-aea4-ad488dc83c60
md"Alternatively, consider the density function ``g(x)`` from above.  There's not simple way to write this function, even a piece-wise function would be messy.  Often in cases like this, a table is used."

# ╔═╡ 8d31e578-2f4d-4b29-8a20-f99e8eaaaa77
md"The Axioms of Probability are again satisfied.

1. Non-negative probability is assigned to any set ``A \subseteq [0, 1].``

$$\mathbb{P}[A] = \mathbb{E}[\mathbb{1}_A] = \sum_{S} \mathbb{1}_A(x) f(x) \geq 0$$

2. Probability ``1`` is assigned to the entire sample space.

$$\mathbb{P}[S] = \mathbb{E}[\mathbb{1}_S] = \sum_{S} \mathbb{1}_S(x) f(x) = 1.$$

3. The probability of a disjoint union of sets is equal to the sum of the probabilities of each of the union's components.

    This follows since sums and intergals, and thus expectation, is a linear operation.
"

# ╔═╡ 783ff23a-d807-413b-aa2f-e576a950cbaa
render_table(gkp) = @htl("""
	<table><caption><h4>Gas Keypad Distribution</h4></caption>
	<tbody>
	<tr><td>Digit$(map(gaskeypad) do gkp @htl("<td>$(string(first(gkp)))") end)
	<tr><td>Density$(map(gaskeypad) do gkp @htl("<td>$(string(last(gkp)))") end)</tbody></table>""")

# ╔═╡ 6f20a697-490d-4cfa-9047-900591dbbca8
render_table(gaskeypad)

# ╔═╡ 5d3b0792-80cc-43b5-821d-93e726261d07


# ╔═╡ Cell order:
# ╠═a03e4500-a9d1-11eb-34c2-fd5b156bfa8c
# ╠═e28f76be-713c-4e97-a781-d865266e06cb
# ╠═bff2993b-5c99-44d1-a0e3-4c1db6cf24c8
# ╠═4f38b947-fe25-4dc1-ba71-a9823670afde
# ╠═b7488907-6f98-48ad-b83e-925777675bea
# ╠═6a8a8453-7fe4-43d4-8e7a-d88390cb57a5
# ╠═b6679398-7962-4f27-a3b3-ac05fb13b40c
# ╠═cc5c354a-32e5-4fc7-bf66-3d62a33b7131
# ╠═ff4f758f-3665-44e9-b006-09bae8f3fbe1
# ╠═7db423e3-4611-42cf-8c43-e63face3995d
# ╠═edd74e8f-bab7-48b7-8d2a-e45738cbbcc7
# ╠═0195924a-c864-4ddd-aea4-ad488dc83c60
# ╠═8d31e578-2f4d-4b29-8a20-f99e8eaaaa77
# ╠═6f20a697-490d-4cfa-9047-900591dbbca8
# ╠═783ff23a-d807-413b-aa2f-e576a950cbaa
# ╠═5d3b0792-80cc-43b5-821d-93e726261d07
# ╠═d9787218-49c2-4411-ac21-f4306445fc5b
# ╠═ac3313aa-b096-45f4-be71-698d83e847b4
# ╠═3f1c58c7-4b1b-4b9a-9abc-a43d8624e724
