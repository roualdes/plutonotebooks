### A Pluto.jl notebook ###
# v0.14.3

using Markdown
using InteractiveUtils

# ╔═╡ 82eb253a-2378-4074-9dab-4cb3c7eea868
using PlutoUI

# ╔═╡ d8ed59fe-a83e-11eb-07f8-d7123a34a1c5
md"# Probability Distributions"

# ╔═╡ 4fd5c54c-4c43-454a-81dd-5ac7245feb85
TableOfContents(; depth = 2)

# ╔═╡ cf85ab67-9d99-4551-93b6-db3494a3bc73
md"## Introduction"

# ╔═╡ 46f5142e-369f-4c78-8d91-cd267933d8be
md"Probability is a conserved quantity distributed over a space ``S``.  A probability distribution is then a mathematical description of how much of this conserved quantity, named probability, is applied to arbitrary subsets ``A`` of ``S``, ``A \subseteq S``.  The set ``S`` is called the **sample space**."

# ╔═╡ a203c3f9-b811-45a9-84f0-d39b808209ea
md"### Example: Keypads"

# ╔═╡ 57d26450-bb69-46b2-93a8-bbee93c91436
md"Imagine you are at a gas station, about to enter the zip code associated with your credit card.  Have you ever noticed that the digits of the local area code are often more worn than the other digits?  In fact, the wear on the keypad describes a probability distribution over the sample space ``S = \{0, 1, 2, 3, 4, 5, 6, 7, 8, 9\}``.  Probability is higher for, or distributed more to, the numbers of the digits of the local area code."

# ╔═╡ a0d95aa7-9bcd-4da4-84ed-b0879a8ff42a
md"### Example: Fair Dice"

# ╔═╡ 18f3e3ce-9fd2-4a55-bcb2-5224f4bb943c
md"A standard (fair) die is a more common choice for a first example.  The sample space ``S = \{1, 2, 3, 4, 5, 6\}`` and probability is evenly, or uniformly, distributed over the singletons (single element subsets) of ``S``."

# ╔═╡ c27997b9-365f-4572-aa7a-283b33d3d5b1
md"### Example: Fair Coin"

# ╔═╡ 0dfb6258-4451-4d64-a704-9da3ec92ca07
md"A fair coin with sides ``H`` for heads and ``T`` for tails is another common first example choice. A fair coin is another example of a uniform distribution of probability over its sample space ``S = \{H, T\}``.  A nice feature of this example is that the sample space is not numbers, thus highlighting the generality of probability distributions.  Probability distributions need not apply to sample spaces of only numbers."

# ╔═╡ 227003ce-5470-4f04-93a5-6cbe84a2358d
md"A probability distribution is any function that applies to (most) subsets of a sample space and also satisfies the axioms of probability below.  It's common to think of probability as a number, but in fact it is a function that assigns numbers, also called probability, to subsets of ``S``.  After discussing the Axioms of Probability, we'll come back to some more complicated specific examples."

# ╔═╡ 33743bd0-0d79-4999-b93b-4d27d448b408
md"## Axioms of Probability"

# ╔═╡ 410b2fff-0ed5-4ff4-82c1-bc3409ffd0af
md"The three Axioms of Probability are

1. ``\mathbb{P}[A] \geq 0`` for <del>any</del> ``A \subseteq S``,
2. ``\mathbb{P}[S] = 1``, and
3. ``\mathbb{P}[\cup A_n] = \sum_{n} \mathbb{P}[A_n]`` where ``A_i \cap A_j = \emptyset``.

"

# ╔═╡ 1ad18652-cebf-4dfe-aa01-19834ba4b14a
md"The first axiom says that probability is bounded below by zero.  This should make intuitive sense, since we reasonably believe that probability can not be negative.  The second axiom suggests that probability is bounded above by 1, but technically says that probability of the entire sample space is 1.  Since any given probability distribution only assigns probability to subsets of the sample space ``S``, of which ``S`` is a valid subset, we can not distribute more than 100% of our conserved quantity, known as probability."

# ╔═╡ 6ddca240-5797-4564-adf3-0c788c8d5a80
md"## A Note on Notation"

# ╔═╡ d7da0c9d-8f19-49d0-b093-1d0816b6c8ed
md"Statisticians have a bad habit of reusing the same name, namely the letter P which I write in bold as ``\mathbb{P}``, for different functions. In fact, we'll see this same issue again in the notebook on density functions."

# ╔═╡ 0774a8f8-e6d1-44dc-b186-d481b713ba00
md"There are an uncountable number of probability distributions.  It is common in the world of statistics to reference each one with ``\mathbb{P}``.  One hopes that the specific probability distribution of interest is clear from the context, but one also imagines that navigating such distinctions is more difficult when first learning this material."

# ╔═╡ d2bca69d-353f-48d9-bde0-677892b3fa24
md"## Examples"

# ╔═╡ b284dddb-2da3-4e93-9ecb-b6592dcab087
md"Many common probability distributions are grouped into families.  However, authors often fail to mention the family component of probability distributions at all.  It is hard to blame such authors for neglecting this naunce.  As you'll see here, typing/saying the Binomial family of probability distributions quickly becomes exhausting.  As such, I too will likely fail to mention the family aspect in all but this paragraph.  Further, I'll probably even refer to probability distributions as, simply, distributions.  The examples provided here focuses on two families of probability distributions, namely the Binomial family of probability distributions and the Gamma family of probability distributions."

# ╔═╡ 7f773008-ac15-44bf-a276-15ea69c7e4b1
md"### Binomial Distribution"

# ╔═╡ e76c82e9-711c-4450-89fe-d795344d2cdb
md"### Gamma Distribution"

# ╔═╡ Cell order:
# ╠═d8ed59fe-a83e-11eb-07f8-d7123a34a1c5
# ╠═4fd5c54c-4c43-454a-81dd-5ac7245feb85
# ╠═cf85ab67-9d99-4551-93b6-db3494a3bc73
# ╠═46f5142e-369f-4c78-8d91-cd267933d8be
# ╠═a203c3f9-b811-45a9-84f0-d39b808209ea
# ╠═57d26450-bb69-46b2-93a8-bbee93c91436
# ╠═a0d95aa7-9bcd-4da4-84ed-b0879a8ff42a
# ╠═18f3e3ce-9fd2-4a55-bcb2-5224f4bb943c
# ╠═c27997b9-365f-4572-aa7a-283b33d3d5b1
# ╠═0dfb6258-4451-4d64-a704-9da3ec92ca07
# ╠═227003ce-5470-4f04-93a5-6cbe84a2358d
# ╠═33743bd0-0d79-4999-b93b-4d27d448b408
# ╠═410b2fff-0ed5-4ff4-82c1-bc3409ffd0af
# ╠═1ad18652-cebf-4dfe-aa01-19834ba4b14a
# ╠═6ddca240-5797-4564-adf3-0c788c8d5a80
# ╠═d7da0c9d-8f19-49d0-b093-1d0816b6c8ed
# ╠═0774a8f8-e6d1-44dc-b186-d481b713ba00
# ╠═d2bca69d-353f-48d9-bde0-677892b3fa24
# ╠═b284dddb-2da3-4e93-9ecb-b6592dcab087
# ╠═7f773008-ac15-44bf-a276-15ea69c7e4b1
# ╠═e76c82e9-711c-4450-89fe-d795344d2cdb
# ╠═82eb253a-2378-4074-9dab-4cb3c7eea868
