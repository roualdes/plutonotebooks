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

# ╔═╡ 82eb253a-2378-4074-9dab-4cb3c7eea868
using PlutoUI

# ╔═╡ e3f5a522-6051-489e-9f72-89d9ecfc9b2c
using StatsPlots

# ╔═╡ 43988eeb-0680-4b3d-8091-1d01bda09edf
using Distributions

# ╔═╡ bf81ee3b-dd04-4983-9f2e-b52badad1da1
 using HypertextLiteral

# ╔═╡ 8261efb7-0e4f-4866-92cb-50b0d1052d5c
using LaTeXStrings

# ╔═╡ d8ed59fe-a83e-11eb-07f8-d7123a34a1c5
md"# Probability Distributions"

# ╔═╡ 4fd5c54c-4c43-454a-81dd-5ac7245feb85
TableOfContents()

# ╔═╡ 7afab741-537c-4fdf-850d-aa211b6b13c3
md"TODO see [https://betanalpha.github.io/assets/case_studies/probability_theory.html](https://betanalpha.github.io/assets/case_studies/probability_theory.html) for inspiration."

# ╔═╡ cf85ab67-9d99-4551-93b6-db3494a3bc73
md"## Introduction"

# ╔═╡ 46f5142e-369f-4c78-8d91-cd267933d8be
md"Probability is a conserved quantity distributed over a set ``S``.  A probability distribution is then a mathematical description of how much of this conserved quantity, named probability, is assigned to (most[^1]) subsets ``A`` of ``S``, ``A \subseteq S``.  The set ``S`` is called the **sample space**."

# ╔═╡ bbefd977-c075-4b0d-9376-64b4a0ad0d21
md"Probability distributions can be divided into two general classes.  Probability distributions defined on finite or countable sample spaces are called **discrete probability distributions**.  Probability distributions defined on uncountable sample spaces are called **continuous probability distributions**."

# ╔═╡ 77d6dfbc-703d-4752-97b9-a4f11cc89e78
md"We motivate probability distributions by giving some quick and simple examples of discrete probability distributions.  Hopefully, these examples will help you see what we mean when we say probability is distributed over a sample space."

# ╔═╡ 57d26450-bb69-46b2-93a8-bbee93c91436
md"**Example: Gas Station Keypads**.  Imagine you are at a gas station, about to enter the zip code associated with your credit card.  Have you ever noticed that the digits of the local zip codes are often more worn than the other digits?  In fact, the wear on the keypad describes a probability distribution over the sample space ``S = \{0, 1, 2, 3, 4, 5, 6, 7, 8, 9\}``.  Probability is higher for, or distributed more to, the numbers of the digits of the local zip codes, and is lower for, or distributed less to, the other numbers.  Further, we should expect repeated numbers within the local zip codes to have higher probability than less common numbers of the local zip codes."

# ╔═╡ 18f3e3ce-9fd2-4a55-bcb2-5224f4bb943c
md"**Example: Fair Die**.  A fair die is a more common choice for a first example.  The sample space ``S = \{1, 2, 3, 4, 5, 6\}`` and probability is evenly, or uniformly, distributed over the singletons (single element subsets) of ``S``."

# ╔═╡ 0dfb6258-4451-4d64-a704-9da3ec92ca07
md"**Example: Fair Coin**.  A fair coin with sides ``H`` for heads and ``T`` for tails is another common first example. A fair coin is another example of a uniform distribution of probability over its sample space ``S = \{H, T\}``.  A nice feature of this example is that the sample space is not numbers, thus highlighting the generality of probability distributions.  Probability distributions need not apply to sample spaces of only numbers.  The sample space ``S`` can really be almost any set."

# ╔═╡ 8aa81756-2bc5-462b-bbc2-84708fab3a70
md"The gas station keypad example above contrasts nicely against the next two examples.  The gas station keypad's distribution is a non-uniform distribution of probability (over singletons of the sample space), whereas the other two examples represent a uniform distribution (of probability over singletons of the sample space).  These three examples will thus help us generalize our concept of probability."

# ╔═╡ 227003ce-5470-4f04-93a5-6cbe84a2358d
md"A probability distribution is any function that assigns a number, referred to as probability, to (most[^1]) subsets of a sample space and also satisfies the axioms of probability, provided below.  It is common to think of probability as only a number, but in fact it is a function that assigns probability to subsets of ``S``, and we also often refer to the number this functions returns as a probability.  After presenting the Axioms of Probability, we will generalize probability from finite sample spaces to countable and uncountable spaces.  Then we will discuss some more complicated examples of probability distributions, to help ensure that we come away with a general concept of probability that can be more easily applied to new situations.  This notebook then concludes by highlighting the distinction between probability distributions and their density function representations."

# ╔═╡ febc72ae-2ef6-484a-bc90-5844eeedae76
md"## Probability, a Set Function"

# ╔═╡ 2b0c948d-2eb1-461a-8999-0802b7e9e819
md"A probability distribution is a function that applies to subsets of the sample space ``S``.  Hence it is a set function.  For an arbitrary subset ``A`` of ``S``, ``A \subseteq S``, we write

$$\mathbb{P}[A] = p$$

for some ``p \in [0, 1]``. The specific value of ``p`` is determined by the specific distribution being used.

* If ``\mathbb{P}`` represents a fair coin and ``A = \{H\}``, then we tend to believe ``\mathbb{P}[A] = \mathbb{P}[\{H\}] = 0.5``.
* If ``\mathbb{P}`` represents a fair die and ``A = \{1, 2\}``, then we would have ``\mathbb{P}[\{1, 2\}] = 2/6``.
* If ``\mathbb{P}`` represents a gas station keypad in Chico, CA, where the five local zip codes are ``(95926, 95928, 95929, 95973, 95976)``, then we might expect to see wear on local gas station keypads that, relatively closely, aligns with the probabilities ``\mathbb{P}[\{9\}] = 11/25`` and ``\mathbb{P}[\{5\}] = 5/25``, and ``\mathbb{P}[\{2\}] = 3 / 25``."

# ╔═╡ 6ddca240-5797-4564-adf3-0c788c8d5a80
md"## A Note on Notation"

# ╔═╡ d7da0c9d-8f19-49d0-b093-1d0816b6c8ed
md"Statisticians have a bad habit of reusing the same name, namely the letter P which I write in bold as ``\mathbb{P}``, for different functions. In fact, we'll see this same issue again in the notebook on density functions, where all density functions will be named ``f``."

# ╔═╡ 0774a8f8-e6d1-44dc-b186-d481b713ba00
md"There are an uncountable number of probability distributions.  It is common in the world of statistics to reference each one with ``\mathbb{P}``.  One hopes that the specific probability distribution under discussion is clear from the context.  One also imagines that navigating such distinctions is more difficult when first learning this material, so keep this in mind as you read on."

# ╔═╡ 33743bd0-0d79-4999-b93b-4d27d448b408
md"## Axioms of Probability"

# ╔═╡ 410b2fff-0ed5-4ff4-82c1-bc3409ffd0af
md"The three axioms of probability are

1. ``\mathbb{P}[A] \geq 0`` for (most[^1]) ``A \subseteq S``,
2. ``\mathbb{P}[S] = 1``, and
3. ``\mathbb{P}[\cup_n A_n] = \sum_{n} \mathbb{P}[A_n]`` where ``A_i \cap A_j = \emptyset`` and ``i \not= j``.
"

# ╔═╡ 1ad18652-cebf-4dfe-aa01-19834ba4b14a
md"The first axiom says that probability is bounded below by zero.  This should make intuitive sense, since we reasonably believe that probability can not be negative.  The second axiom suggests that probability is bounded above by ``1``, but technically says that the probability assigned to the entire sample space is ``1``.  Since any given probability distribution only assigns probability to subsets of the sample space ``S``, of which ``S`` is the biggest valid subset, we can not distribute more than 100% of our conserved quantity, known as probability.  The third axiom says that probability is assigned to a union of disjoint sets as the sum of the components of the union."

# ╔═╡ 427adede-fe09-4c59-b8ca-df898c4a7924
md"The third axiom of probability is often easier to interpret visually.  The entire box, let's call it ``A``, below is written as a union of disjoint sets ``A_n`` for ``n \in \{1, 2, 3, 4\}``,

$$A = A_1 \cup A_2 \cup A_3 \cup A_4 \cup A_5 = \cup_{n \in \{1, 2, 3, 4, 5\}} A_n.$$"

# ╔═╡ 8358fab7-4b42-45ec-bcdf-661747dde8f7
plot(0:5, t = :vline, xlimit = (0, 5),
	annotations = [
		(0.5, 1.5, L"A_1"),
		(1.5, 1.5, L"A_2"),
		(2.5, 1.5, L"A_3"),
		(3.5, 1.5, L"A_4"),
		(4.5, 1.5, L"A_5")],
	grid = false, ticks = false, label = false,
	framestyle = :box)

# ╔═╡ 9612e871-4b10-4cff-9215-4da903d33d06
md"Since the ``A_n`` are disjoint, we can apply the third axiom of probability to find the probability of ``A``,

$$\mathbb{P}[A] = \mathbb{P}[\cup_{n \in \{1, 2, 3, 4, 5\}} A_n] = \mathbb{P}[A_1] + \mathbb{P}[A_2] + \mathbb{P}[A_3] + \mathbb{P}[A_4] + \mathbb{P}[A_5] = \sum_{n \in \{1, 2, 3, 4, 5\}} \mathbb{P}[A_n].$$"

# ╔═╡ a2b415f6-5724-4423-8ddf-41f8b659d9d0
md"## Discrete and Continuous Distributions"

# ╔═╡ 255d6811-0393-4385-befc-ada60a2d47ff
md"A probability distribution ``\mathbb{P}`` defined on ``S`` is **continuous** if ``\mathbb{P}[\{x\}] = 0`` for all ``x \in S``.  In these notebooks a distribution will generally be continuous when ``S`` is uncountable.  On the other hand, we will call a distribution **discrete** when it is defined on a countable (or finite) sample space.  We will largely ignore distributions that have both continuous and discrete components."

# ╔═╡ a1b61767-02c5-4678-8cde-3b86cc30bbd7
md"## Examples"

# ╔═╡ b284dddb-2da3-4e93-9ecb-b6592dcab087
md"Many common probability distributions are grouped into named families.  Although, not all distributions are so classified.  For instance, the gas station keypad example above is an example of an unnamed probability distribution.  On the other hand, the fair die example above is an example of a Uniform distribution over a finite sample space, also known as a discrete Uniform distribution.  Named families of distributions are indexed by a (or many) values called **parameter(s)**.  Within a family of probability distributions, a new distribution is formed for each new value of the parameter(s)."

# ╔═╡ fcfc666e-758a-48e5-8b53-99e749b6231b
md"**Family of Uniform Distributions**.  The (discrete) Uniform (probability) distribution is a probability distribution that assigns equal weight to each element of its finite sample space ``S``.  So for ``A \subseteq S``, probability is assigned by counting the number of elements in ``A`` relative to the number of elements in ``S``,

$$\mathbb{P}[A] = \frac{|A|}{|S|}.$$
 
It is common to take ``S = \{a, \ldots, b\}`` for consecutive integers ``a < b``.  In this case, ``|S| = b - a + 1``."

# ╔═╡ 183dfc28-19c6-4d3e-812f-9cb48c9a6774
md"The Uniform distribution can be applied to any space of finite elements, but it is common to then enumerate these elements with the integers ``1, 2, 3, \ldots, N.``  So even if the sample space ``S`` does not consist of only integers, it is common to consider the sample space to be integers, where each element of the space of interest maps one-to-one into the integers up to the number of elements ``N``.  When the sample space consists of consecutive integers ``S = \{a, \ldots, b\}``, we insist ``a < b`` and write this distribution as ``\text{Uniform}(a, b)``."

# ╔═╡ 1ba39836-ad38-49c1-a942-52cec59e651d
md"Notice the Uniform distribution on the integers ``a`` to ``b``, namely ``U(a, b)``, actually specifies an entire family of distributions, where ``a`` and ``b`` are the parameters.  In applied statistics, there are two ways to use this distribution as a model.

1. Assume the parameters ``a, b`` are known and use this distribution to calculate probabilities.

    A fair die puts ``a = 1`` and ``b = 6``.  By modeling a fair die as a (discrete) Uniform distribution, ``U(1, 6)``, we could calculate ``\mathbb{P}[\{2, 5, 4, 6\}] = |\{2, 5, 4, 6\}| / |\{1, 2, 3, 4, 5, 6\}| = 4/6``.


2. Assume the parameters ``a, b`` are uknown and estimate them from data.

    With dataset ``\{1, 5, 3, 4\}``, we might estimate ``\hat{a} = 1`` and ``\hat{b} = 5``.  Even if these data came from four rolls of a fair die, where we know ``b = 6``, the esimates ``\hat{a} = 1`` and ``\hat{b} = 5`` are not unreasonable given the data we have."

# ╔═╡ 31dff072-a50a-47a7-9bfe-7b70b269b2ae
md"**Practice**.  Ensure the Uniform distribution ``\text{Uniform}(1, 6)``, representing a fair die, obeys the Axioms of Probability."

# ╔═╡ 45c1e1ef-2213-409b-a82b-13840fb2cf57
md"**Practice**.  Ensure the family of Uniform distributions ``\text{Uniform}(a, b)``, where ``a, b \in \mathbb{Z}``, obeys the Axioms of Probability."

# ╔═╡ 89c1ef25-8e71-4315-9f9d-f39a90b239c6
md"Note that a coin could be modeled with a Uniform distribution over ``\{T, H\} \rightarrow \{0, 1\}``, but this would assume the coin is fair.  If there were any doubt about the fairness of the coin, then the Bernoulli distribution would be the more common choice of model, as it naturally allows for the possibility of an unfair coin."

# ╔═╡ 720f17c6-e696-4815-a1d7-9e90b968a65c
md"**Family of Bernoulli Distributions**.  The Bernoulli distribution allocates probability amongst two elements, where ``S = \{0, 1\}``.  It is standard practice to take

$$\mathbb{P}[\{1\}] = p$$

for ``p \in [0, 1]``, which, by the Axioms of Probability, forces ``\mathbb{P}[\{0\}] = 1 - p``."

# ╔═╡ 1535416b-ee7e-4bd8-bbe7-05eebbf6c86f
md"The Bernoulli distribution can be applied to any space of two elements, where one element is considered the element of interest, often (and often inappropriately so) named success.  It is common to label the element of interest as ``1`` and the elementof lesser interest (the failure) as ``0``.  So even if the sample space ``S`` does not directly consist of ``\{0, 1\}``, it is common to consider the sample space to be ``\{0, 1\}`` anyway.  We denote the Bernoulli distribution denote as ``\text{Bernoulli}(p)``."

# ╔═╡ 8fa2ddf4-9cb8-40e2-9061-8bce9db9801e
md"Notice the Bernoulli distribution with probability of ``1`` set to ``p``, namely ``\text{Bernoulli(p)``, actually specifies an entire family of distributions, where ``p`` is the parameter.  In applied statistics, there are two ways to use this distribution as a model.

1. Assume the parameter ``p`` is known and use this distribution to calculate probabilities.

    A fair coin can be modeled as a ``\text{Bernoulli}(p)`` distribution, where heads is denoted by ``1``.  The probability of observing three heads in three flips is ``p^3``, which would be ``1/8`` if the coin were fair (``p = 1/2``).


2. Assume the parameter ``p`` is uknown and estimate it from data.

    With dataset \{1, 0, 1\}, we might estimate ``\hat{p} = 2 / 3``.  Even if these data came from e fair coin, the estimate ``\hat{p} = 2/3`` is not unreasonable given the data."

# ╔═╡ 74824d11-744d-40f5-909d-866d9af72c20
md"**Practice**.  Ensure the family of Bernoulli distributions ``\text{Bernoulli}(p)``, where ``p \in [0, 1]``, obeys the Axioms of Probability."

# ╔═╡ 38f19a20-e002-41b5-976c-22c6af542e89
md"A point of clarity is in order.  Statistics authors often fail to mention the family component of probability distributions at all.  It is hard to blame such authors for neglecting this naunce.  As you'll see here, typing/saying, for instance, the Bernoulli family of probability distributions quickly becomes exhausting.  As such, I too will likely fail to mention the family aspect in all but these paragraphs.  Further, I'll probably even refer to probability distributions as, simply, distributions."

# ╔═╡ e76c82e9-711c-4450-89fe-d795344d2cdb
md"### Probability Distributions via Density Functions"

# ╔═╡ b82d50f9-6212-44cc-af87-f2420c5f1a4d
md"There is often confusion that arises in introductory statistics courses with regard to the distinction between probability distributions and (probability) density functions.  Mathematically, probability distributions, in certain cases, give rise to density functions.  However, many authors / statisticians will identify a density function and call it a distribution.  While technically not true, this is often convenient since making the distinction clear does not always warrant the time spent clarifying the point.  Below, we attempt to highlight the differences."

# ╔═╡ 272ce517-d9ec-4afe-b5c1-90d6c4c89899
md"In general, probability is defined to be area under a probability distribution's  density function.  See the notebook on [TODO add link to] Density Functions for more details on density functions.  For now, we will assume that a density function of a probability distribution is the function that enables the assignment of probability to subsets of the sample space."

# ╔═╡ bde58343-0124-402d-9fef-fa3ee702d660
md"In general, probability distributions dictate the assignment of probability to (most[^1]) subsets of the sample space, ``A \subseteq S`` by calculating area under their density function.  

**(Generalized) Probability**.  Let ``f`` be the density function for probability distribution ``\mathbb{P}``, and let ``A \subseteq S``.  If ``S`` is finite or countable, then

$$\mathbb{P}[{A}] = \sum_{x \in S} 1_A(x) f(x),$$

and if ``S`` is uncountable, then

$$\mathbb{P}[A] = \int_{S} 1_A(x) f(x) dx.$$"

# ╔═╡ f10cecb7-cb04-43ee-8db0-f623d99115c1
md"A plot helps us see that all the probability distributions above conform to the area under a density function idea.  Consider the fair die example from above, namely the Uniform distribution defined on ``S = \{1, 2, 3, 4, 5, 6\}``, where ``\mathbb{P}[A] = |A| / |S|`` for ``A \subseteq S``.  The density function of this probability distribution is displayed below, with the area under the density function for ``A = \{2, 3, 4\}`` drawn in blue."

# ╔═╡ 26cdcadc-f212-4cd2-a159-c85fc1a6574f
md"In order to calculate the probability of ``A = \{2, 3, 4\}``, we sum up the density function for this distribution

$$f(x) = 1/|S| = 1/6 \quad x \in S$$

across the elements of ``A``,

$$\mathbb{P}[\{2, 3, 4\}] = \sum_{x \in \{2, 3, 4\}} 1/6 = 3/6.$$
"

# ╔═╡ 59a5416a-2c5f-49fd-9ad6-c2bec0005669
md"Notice this formulate exactly recovers the probability assigned to the set ``A = \{2, 3, 4\}`` as if we used the definition of the probabiliy function from the Uniform distribution ``\text{Uniform}(1, 6)``,

$$\mathbb{P}[\{2, 3, 4\}] = \frac{|\{2, 3, 4\}|}{|\{1, 2, 3, 4, 5, 6\}|} = 3/6.$$"

# ╔═╡ 34590131-c5fe-4fc4-85a8-eb9dc02f0214
md"Much of the confusion between probability distributions and density functions arises from the fact that discrete probability distributions are equivalent to their density function representation when evaluated on singletons.  Imagine the set ``A \subseteq S`` to have one element, where we let the element be any single element of ``S``, like we normally think of the variable ``x``,  but let's call this element ``a`` so we don't get lost in ``x``s.  Let ``A = \{a\}``, then

$$\mathbb{P}[A] = \mathbb{P}[\{a\}] = \sum_{x \in A} f(x) = f(a).$$

We could have just as easily called the single element of ``A`` the letter ``x`` and written

$$\mathbb{P}[\{x\}] = f(x),$$

which highlights the source of the confusion, since for continuous distributions ``\mathbb{P}[\{x\}] = 0`` for all ``x \in S``. Alas, distribution functions are only equivalent to density functions for probability assignments of singletons for discrete probability distributions."

# ╔═╡ 4d186f7a-216c-4402-ba0e-9a6f4a43aa42
md"Consider the gas station keypad example from above.  The density function for this distribution is shown in the plot below."

# ╔═╡ 203f0879-875e-4a25-a7df-3c54f72ff41f
begin
	cols = get_color_palette(:auto, 17)
	gaskeypad = (0 => 0.0, 1 => 0.0, 2 => 3/25, 3 => 1/25, 4 => 0.0, 5 => 5/25,
		6 => 2/25, 7 => 2/25, 8 => 1/25, 9 => 11/25)
	y = 0:10
	yfill = 6:9
	p2 = plot(y, [last(gkp) for gkp in gaskeypad], t = :scatter,
		xlabel = L"x", ylabel = L"f(x)", label = false)
	for yf in yfill
	 plot!(p2, [yf, yf], [0.0, gaskeypad[yf+1][2]], t = :line,
			c = cols[1], linewidth = 2, label = false)
	end
	p2
end

# ╔═╡ 483c1814-c485-4ac2-8940-8c0b3b68de59
begin
	x = 1:6
	xfill = 2:4
	p = plot(x, repeat([1/6], 6), t = :scatter,
		ylimits = (0, 0.25),
		xlabel = L"x", ylabel = "Density", label = false)
	for xf in xfill
		plot!(p, [xf, xf], [0, 1/6],
			t = :line, c = cols[1], label = false)
	end
	p
end

# ╔═╡ a9ee7b15-ea90-4cc6-adfa-3c2453885656
md"The gas station keypad distribution is a case of an unnamed, non-uniform discrete probability distribution over a finite sample space, ``S = \{0, 1, 2, 3, 4, 5, 6, 7, 8, 9\}``.  In cases like this, it is common to represent the density function as a table of values the density function takes on for each value ``x \in S``."

# ╔═╡ 0d54a0a2-004f-4100-b14b-326c2e431602
md"To find the probability of the set ``A = \{6, 7, 8, 9\}``, we sum the density function ``f`` across all values of ``x \in A`` as

$$\mathbb{P}[\{6, 7, 8, 9\}] = \sum_{x \in \{6, 7, 8, 9\}} f(x) = 0.08 + 0.08 + 0.04 + 0.44 = 0.64$$"

# ╔═╡ fcf2db97-e9ae-4038-b1cc-d002ee77c4bc
md"To really emphasize the distinction between a probability distribution and its density function, consider the Exponential distribution below.  The Exponential distribution is a continuous distribution."

# ╔═╡ 6098cb1f-0e25-45b9-90a3-080fb5499521
begin
	λ = @bind lambda html"<input type='range' min='0.1' max='5.0' step='0.1' value='1'>"
	md"""**Exponential distribution parameter**
	``\lambda``: $λ
	"""
end

# ╔═╡ 6600d975-4f77-4a77-8b4a-15ae078bdd65
# TODO clean up 1 / rate vs rate issue for Exponential distribution; which definition, Distribution.jl or Stan?

# ╔═╡ 250d013a-bc7c-4eb0-a1c4-7e6e13da3cda
begin
	E = Exponential(lambda)
	mxs = lambda + 5 * lambda
	z = 0:0.01:mxs
	zfill = 0.25:0.01:1
	pexp =	plot(z, pdf.(E, z), label = false)
	plot!(pexp, zfill, pdf.(E, zfill), fill = (0, cols[1]), 
		label = false, color = cols[1],
		title = "Density function, λ = $lambda",
		xlabel = L"x", ylabel = L"f(x \; | \lambda)")
end

# ╔═╡ 41d3af1d-2b0b-4cd4-9477-86254c34da3c
md"The Exponential distribution, with parameter ``\lambda``, has density function

$$f(x | \lambda) = \lambda e^{-\lambda x} 1_{(0, \infty)}(x).$$

The probability of the interval ``A = [0.25, 1.0]`` is defined as the area under the density function within the set ``A``. Notice that the density function shows up within the integrand, while the probability distribution is on the left hand side of the following equation

$$\mathbb{P}[(0.25, 1.0)] = \int 1_{(0.25, 1.0)}(s) \cdot 5 e^{-5s}1_{(0, \infty)}(s) \mathrm{d}s.$$

Remember that for continuous distributions ``\mathbb{P}[\{x\}] = 0`` for all ``x \in S``, so that ``\mathbb{P}[\{0.25\}] = 0`` and ``\mathbb{P}[\{1.0\}] = 0.``  This implies ``\mathbb{P}[(0.25, 1.0)] = \mathbb{P}[[0.25, 1.0]].``"

# ╔═╡ 663bd725-53d1-4213-be62-574e13be34bf
md"## Some Properties"

# ╔═╡ 991134ef-7ec7-46c7-ab07-e3eb5d7aea91
md"TODO add useful properties"

# ╔═╡ 34a459bf-7859-433a-861c-58c31611baa7
md"For any set ``A \subseteq S``

$$\mathbb{P}[A] = 1 - \mathbb{P}[A^c].$$"

# ╔═╡ 37b44412-519f-45e2-bd08-c171fdfbf204
md"The empty set ``\emptyset = \{ \}`` always has zero probability,

$$\mathbb{P}[\emptyset] = 0.$$"

# ╔═╡ 07a816ec-d1bb-4720-b381-a493643e747d
md"## Footnotes"

# ╔═╡ 72b053b8-9327-4128-931e-95b3e9305571
md"
[^1]: Technically probability can only be assigned to measurable sets.  Unfortunately, I will probably not mention this technicality at all times when I should.  TODO see reference instead.
"

# ╔═╡ 0d89f93b-3a3a-4c1b-8e63-552ed41c6d4c
render_density(gkp, title) = @htl("""
	<table><tbody><table><caption><h4>$title</h4></caption>
	<tr><td>x $(map(gaskeypad) do gkp @htl("<td>$(string(first(gkp)))") end)
	<tr><td>f(x) $(map(gaskeypad) do gkp @htl("<td>$(string(last(gkp)))") end)</tbody></table>""")

# ╔═╡ 3ad2e477-ba5b-4676-b8d3-c99fa50b91d5
render_density(gaskeypad, "Gas Station Keypad Density Function")

# ╔═╡ Cell order:
# ╠═d8ed59fe-a83e-11eb-07f8-d7123a34a1c5
# ╠═4fd5c54c-4c43-454a-81dd-5ac7245feb85
# ╠═7afab741-537c-4fdf-850d-aa211b6b13c3
# ╠═cf85ab67-9d99-4551-93b6-db3494a3bc73
# ╠═46f5142e-369f-4c78-8d91-cd267933d8be
# ╠═bbefd977-c075-4b0d-9376-64b4a0ad0d21
# ╠═77d6dfbc-703d-4752-97b9-a4f11cc89e78
# ╠═57d26450-bb69-46b2-93a8-bbee93c91436
# ╠═18f3e3ce-9fd2-4a55-bcb2-5224f4bb943c
# ╠═0dfb6258-4451-4d64-a704-9da3ec92ca07
# ╠═8aa81756-2bc5-462b-bbc2-84708fab3a70
# ╠═227003ce-5470-4f04-93a5-6cbe84a2358d
# ╠═febc72ae-2ef6-484a-bc90-5844eeedae76
# ╠═2b0c948d-2eb1-461a-8999-0802b7e9e819
# ╠═6ddca240-5797-4564-adf3-0c788c8d5a80
# ╠═d7da0c9d-8f19-49d0-b093-1d0816b6c8ed
# ╠═0774a8f8-e6d1-44dc-b186-d481b713ba00
# ╠═33743bd0-0d79-4999-b93b-4d27d448b408
# ╠═410b2fff-0ed5-4ff4-82c1-bc3409ffd0af
# ╠═1ad18652-cebf-4dfe-aa01-19834ba4b14a
# ╠═427adede-fe09-4c59-b8ca-df898c4a7924
# ╠═8358fab7-4b42-45ec-bcdf-661747dde8f7
# ╠═9612e871-4b10-4cff-9215-4da903d33d06
# ╠═a2b415f6-5724-4423-8ddf-41f8b659d9d0
# ╠═255d6811-0393-4385-befc-ada60a2d47ff
# ╠═a1b61767-02c5-4678-8cde-3b86cc30bbd7
# ╠═b284dddb-2da3-4e93-9ecb-b6592dcab087
# ╠═fcfc666e-758a-48e5-8b53-99e749b6231b
# ╠═183dfc28-19c6-4d3e-812f-9cb48c9a6774
# ╠═1ba39836-ad38-49c1-a942-52cec59e651d
# ╠═31dff072-a50a-47a7-9bfe-7b70b269b2ae
# ╠═45c1e1ef-2213-409b-a82b-13840fb2cf57
# ╠═89c1ef25-8e71-4315-9f9d-f39a90b239c6
# ╠═720f17c6-e696-4815-a1d7-9e90b968a65c
# ╠═1535416b-ee7e-4bd8-bbe7-05eebbf6c86f
# ╠═8fa2ddf4-9cb8-40e2-9061-8bce9db9801e
# ╠═74824d11-744d-40f5-909d-866d9af72c20
# ╠═38f19a20-e002-41b5-976c-22c6af542e89
# ╠═e76c82e9-711c-4450-89fe-d795344d2cdb
# ╠═b82d50f9-6212-44cc-af87-f2420c5f1a4d
# ╠═272ce517-d9ec-4afe-b5c1-90d6c4c89899
# ╠═bde58343-0124-402d-9fef-fa3ee702d660
# ╠═f10cecb7-cb04-43ee-8db0-f623d99115c1
# ╠═483c1814-c485-4ac2-8940-8c0b3b68de59
# ╠═26cdcadc-f212-4cd2-a159-c85fc1a6574f
# ╠═59a5416a-2c5f-49fd-9ad6-c2bec0005669
# ╠═34590131-c5fe-4fc4-85a8-eb9dc02f0214
# ╠═4d186f7a-216c-4402-ba0e-9a6f4a43aa42
# ╠═203f0879-875e-4a25-a7df-3c54f72ff41f
# ╠═a9ee7b15-ea90-4cc6-adfa-3c2453885656
# ╠═3ad2e477-ba5b-4676-b8d3-c99fa50b91d5
# ╠═0d54a0a2-004f-4100-b14b-326c2e431602
# ╠═fcf2db97-e9ae-4038-b1cc-d002ee77c4bc
# ╠═6098cb1f-0e25-45b9-90a3-080fb5499521
# ╠═6600d975-4f77-4a77-8b4a-15ae078bdd65
# ╠═250d013a-bc7c-4eb0-a1c4-7e6e13da3cda
# ╠═41d3af1d-2b0b-4cd4-9477-86254c34da3c
# ╠═663bd725-53d1-4213-be62-574e13be34bf
# ╠═991134ef-7ec7-46c7-ab07-e3eb5d7aea91
# ╠═34a459bf-7859-433a-861c-58c31611baa7
# ╠═37b44412-519f-45e2-bd08-c171fdfbf204
# ╠═07a816ec-d1bb-4720-b381-a493643e747d
# ╠═72b053b8-9327-4128-931e-95b3e9305571
# ╠═0d89f93b-3a3a-4c1b-8e63-552ed41c6d4c
# ╠═82eb253a-2378-4074-9dab-4cb3c7eea868
# ╠═e3f5a522-6051-489e-9f72-89d9ecfc9b2c
# ╠═43988eeb-0680-4b3d-8091-1d01bda09edf
# ╠═bf81ee3b-dd04-4983-9f2e-b52badad1da1
# ╠═8261efb7-0e4f-4866-92cb-50b0d1052d5c
