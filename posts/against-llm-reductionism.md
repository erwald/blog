---
layout: layouts/post.njk
title: Against LLM Reductionism
date: 2023-03-08
tags: post
---

# Against LLM Reductionism

![img]({{ '/img/datacenter.jpeg' | url }})

## Summary

- Large language models (henceforth, LLMs) are sometimes said to be "just" shallow pattern matchers, "just" massive look-up tables or "just" autocomplete engines. These comparisons amount to a form of (methodological) reductionism. While there's some truth to them, I think they smuggle in corollaries that are either false or at least not obviously true.
- For example, they seem to imply that what LLMs are doing amounts merely to rote memorisation and/or clever parlour tricks, and that they cannot generalise to out-of-distribution data. In fact, there's empirical evidence that suggests that LLMs can learn general algorithms and can contain and use representations of the world similar to those we use.
- They also seem to suggest that LLMs merely optimise for success on next-token prediction. It's true that LLMs are (mostly) trained on next-token prediction, and it's true that this profoundly shapes their output, but we don't know whether this is how they actually function. We also don't know what sorts of advanced capabilities can or cannot arise when you train on next-token prediction.
- So there's reason to be cautious when thinking about LLMs. In particular, I think, caution should be exercised (1) when making predictions about what LLMs will or will not in future be capable of and (2) when assuming that such-and-such a thing must or cannot possibly happen inside an LLM.

## Pattern Matchers, Look-up Tables, Stochastic Parrots

My understanding of what goes on inside machine learning (henceforth, ML) models, and LLMs in particular, is still in many ways rudimentary, but it seems clear enough that, however tempting that is to imagine, it's little like what goes on in the minds of humans; it's weirder than that, more alien, more eldritch. As LLMs have been [scaled up](https://gwern.net/scaling-hypothesis), and more compute and data have been poured into models with more parameters, they have undergone qualitative shifts, and are now capable of a range of tasks their predecessors couldn't even grasp, let alone fail at, even as they have retained essentially the same architecture and training process.[^1] How do you square their awesome, if erratic, brilliance with the awareness that their inner workings are so ordinary?

One route would be to directly deny the brilliance. [Gary Marcus](https://garymarcus.substack.com/) does this, pointing out, and relishing in, the myriad ways that LLMs misfire. Their main limits are, he says, that they are unreliable and untruthful. (See the footnote for my thoughts on that.[^2])

That's one route, but it's not the one I want to discuss here. The route I want to discuss here is _to dispel the magic_, so to speak: to argue that what goes on inside LLMs is "shallow", and that LLMs lack "understanding". This often takes the form of asserting that LLMs are just doing pattern matching[^4], or just rephrasing material from the web[^5], amounting to mere stochastic parrots[^6], or just retrieving things from a massive look-up table. Gary Marcus [describes](https://garymarcus.substack.com/p/what-does-it-mean-when-an-ai-fails) the underlying problem as one of "a lack of cognitive models of the world":

> The improvements, such as they are, come primarily because the newer models have larger and larger sets of data about how human beings use word sequences, and bigger word sequences are certainly helpful for pattern matching machines. But they still don't convey genuine comprehension, and so they are still very easy [...] to break.

Well -- in a certain light and for the sake of fairness -- this view is not entirely wrong:

- LLMs are, in a sense, pattern matching. They likely have a great deal of attention heads and neurons and whatever that detect certain patterns in the input, which then help determine the model's output.
- LLMs are, in a sense, merely rephrasing material from the web. All, or nearly all, of the data that they're trained on originates in the internet, and their outputs are profoundly shaped by this fact.
- LLMs are, in a sense, massive look-up tables. They directly map inputs to outputs, and often seem to rely on memorisation.

The motivation behind these expressions is, I think, manifold, but one of the underlying drives seems to be the notion that AI systems currently are less capable than they seem, and/or that they will in future be less capable than we predict.[^7] In particular, if LLMs are only learning shallow patterns, their ability to generalise to out-of-distribution data will suffer. The present post is about exactly that: what these expressions express _about AI capabilities_, now and in future (and not questions about whether LLMs are conscious or aware, say, important though those questions may be[^8]). In particular, I'm going to argue, and this is perhaps a good time to point out that I am _not_ an expert on ML, that all these descriptors -- pattern matching, look-up tables, stochastic parrots -- are not good descriptors of LLMs, and that you probably shouldn't be using them.

## Those Aren't Good Descriptors

These concerns -- that LLMs are pattern matchers and so on -- might prompt one to say: "Yeah, and so what?" That's what Scott Alexander, discussing GPT-2 in what feels like ages ago, but was actually in 2018, expressed when he [wrote](https://slatestarcodex.com/2019/02/19/gpt-2-as-step-toward-general-intelligence/):

> A machine learning researcher writes me in response to [yesterday's post](https://slatestarcodex.com/2019/02/18/do-neural-nets-dream-of-electric-hobbits/), saying: "I still think GPT-2 is a brute-force statistical pattern matcher which blends up the internet and gives you back a slightly unappetizing slurry of it when asked."
>
> I resisted the urge to answer "Yeah, well, your _mom_ is a brute-force statistical pattern matcher which blends up the internet and gives you back a slightly unappetizing slurry of it when asked." But I think it would have been true.

To say that humans, too, are merely sophisticated pattern matchers is, it strikes me, to highlight the real problem here, which is that people often seem to mean different things when they say a thing is or isn't "just" pattern matching, "just" stitching together phrases from the internet or "just" searching things in a look-up table. That driver of misunderstanding rears its head in every arena; the solution, as ever, is to [taboo your words](https://www.lesswrong.com/posts/WBdvyyHLdxZSAMmoz/taboo-your-words). These assertions, in particular, I think, give the reader a false impression, leading them to believe things like:

- LLMs aren't actually getting better at out-of-distribution tasks, they're only learning ever more elaborate "parlour tricks".
- LLMs have nothing interesting or sophisticated going on inside them.
- LLMs rely purely on rote memorisation, never inferring abstract rules, models of the world or causal mechanisms.
- LLMs are mere autocomplete engines, and/or merely optimise for accurate next-token prediction.
- LLMs cannot produce anything unique.
- LLMs cannot create and/or execute plans.[^9]

In my judgement, some of these are false, at least for some LLMs, and others I'm unsure about, but either way I don't think, given what we know about LLMs at the present stage, that anyone is justified in believing with any certainty that any of them is true.

### LLMs Can Learn General Algorithms

First take the implications that LLMs are only doing clever parlour tricks, only relying on rote memorisation and/or only learning shallow patterns. These things are often true, but, I think, not always true:

- There's evidence that LLMs can learn general analytic capabilities and use them to solve hard problems.
- There's evidence that small, non-language transformers trained on modular and binary addition can learn fully general algorithms.
- There's evidence of _phase changes_ in LLMs and similar models -- points where, with more compute, data or parameters, these models suddenly become capable of solving new tasks. This seems hard to explain if all LLMs do is rote memorisation etc.

#### General Analytic Capabilities

Lewkowycz et al. (2022) fine tunes a version of PaLM (an LLM created by Google) on technical content (for example, arXiv preprints), getting it to perform decently well (~50% success rate) on the [MATH dataset](https://github.com/hendrycks/math/). The problems are not trivial (right-hand panel):

![img]({{ '/img/math_dataset.png' | url }})

The authors take steps to find out whether the model achieved these results through mere rote memorisation. First they look at the 100 problems for which the model does the best and search through the training set for traces of them, but they find none. Then they modify problems (adjusting phrasing and/or numbers) to see whether the model will do worse, but it does not. Finally they compare the model's solutions to the ground-truth solutions provided in the dataset to see whether they are similarly phrased, but, except for questions with very short answers, they are not.

That, to me, suggests their model really does learn rules or algorithms that are generally useful in solving these types of problems. Still, they don't exactly crack open the model and locate the algorithms in the model's weights.

#### Fully General Algorithms

Nanda et al. (2023) trains a tiny (~200K parameters if my count is correct) [transformer](https://transformer-circuits.pub/2021/framework/index.html#transformer-overview) on modular addition (that is, addition where the result "wraps around" to start at 0 again if it would ever exceed the maximum number the model can handle, in this case 113) and finds that, after quickly reducing its in-distribution error (blue line) to near 0, the model is stuck with a high out-of-distribution error (red line) for a long while until suddenly that, too, diminishes to near 0:

![img]({{ '/img/nanda_grokking.png' | url }})

This phenomenon is called _grokking_ (Power et al. 2022), and the sudden improvement on out-of-distribution data is called a _phase change_. It's as if the model initially merely memorises the in-distribution answers, but eventually finds a fully general algorithm, allowing it to generalise ~perfectly to out-of-distribution data. And, in fact, it turns out that this model "uses discrete Fourier transforms and trigonometric identities to convert addition to rotation about a circle" (Nanda et al. 2023).[^10] This algorithm is pretty complicated; it proceeds in multiple steps spread out over successive layers, and is utterly different from how addition normally works in computers at a low level; it's frankly incredible to me that an ML model can find it through gradient descent, but there it is.[^11]

[This blog post](https://cprimozic.net/blog/reverse-engineering-a-small-neural-network/) tells a similar story: the author trains an extremely tiny (422 parameters) neural network to perform binary addition, peers inside and discovers a clever algorithm.

#### Phase Changes

The two addition experiments seem, since, though they weren't done on LLMs, they _were_ done on models with similar architectures, like strong evidence that LLMs _can in principle and practice_ find fully general algorithms. The evidence for actual algorithms found within LLMs is scantier, for LLMs are mind-bogglingly enormous. But there is some evidence of phase changes, either as a result of more training or of larger models, in LLMs.[^12] For example, the language model studied in Olsson et al. (2022) undergoes a phase change markedly improving its in-context learning:

![img]({{ '/img/olsson_phase_change.png' | url }})

And the BIG-bench dataset from Srivastava et al. (2022), comprising tasks designed to not show up in LLMs' training data, shows that, for some tasks, and in particular tasks that _don't_ seem to rely on knowledge/memorisation, like arithmetics, LLMs undergo model-size-scaling phase changes (middle panel):

![img]({{ '/img/big_bench_phase_change.png' | url }})

It's not clear to me what exactly happens in these cases:

- It could be that these language models discover (or in the case of increased parameter counts, become capable of) general algorithms in a way similar to the modular addition model in Nanda et al. (2023), though there are [important disanalogies](https://www.alignmentforum.org/posts/N6WM6hs7RQMKDhYjB/a-mechanistic-interpretability-analysis-of-grokking#Alignment_Relevance) between the modular addition model and LLMs.
- Another possible explanation, perhaps complimentary to the first, is that there is, for those tasks in particular, no _partial_ success -- if the model fails, it fails _completely_ -- the same way one can't partially succeed at peering over a wall; some tasks just seem to have a far smaller space of possible outcomes than other tasks, so the shift from failure to success happens rapidly.

And plausibly discovering and/or using general algorithms is much easier for arithmetic tasks than, say, creative writing. Still, it's hard for me to see how such phase changes could occur if LLMs relied purely on rote memorisation or shallow pattern matching.

### LLMs Can Contain and Use Models of the World

Here's that [passage](https://garymarcus.substack.com/p/what-does-it-mean-when-an-ai-fails) by Gary Marcus again:

> Now it is true that GPT-3 is genuinely better than GPT-2, and maybe [...] true that InstructGPT is genuinely better than GPT-3. I do think that for any given example, the probability of a correct answer has gone up. [...] But _I see no reason whatsoever to think that the underlying problem -- a lack of cognitive models of the world -- [has] been remedied_. The improvements, such as they are, come primarily because the newer models have larger and larger sets of data _about how human beings use word sequences_, and bigger word sequences are certainly helpful for pattern matching machines.

This is an empirical question, but, again, since LLMs are so insanely massive, and since they're trained on such a wide variety of texts, they are elusive targets for mechanistic interpretability research. Instead, reasonably, researchers tend to study smaller models. Is there evidence of representations of the world inside smaller language models? Why, yes there is.

Toshniwal et al. (2021) fine tunes a GPT-2-like LLM on chess game logs and finds circumstantial evidence that the model is representing the board state internally. That paper in turn inspired Li et al. (2022), which fine tunes a GPT variant on Othello game logs and locates inside the network a perfectly intuitive representation of the game's board state. Two observations are especially telling here: (1) the model is able to predict legal moves and (2), when you modify its internal representation of the board state during a game -- performing a kind of surgery, as it were -- you can see its next-move prediction change accordingly. (For an accessible but detailed write-up on this, see [this blog post](https://thegradient.pub/othello/) by the paper's lead author; [this LessWrong post](https://www.lesswrong.com/posts/Neh76ueECviJ6p75o/large-language-models-learn-to-represent-the-world), including comments, may be of interest, too.)

It's plainly not true that language models lack representations of the world. The question is to what extent they have and use such representations.

There are hints of world representations in LLMs, too. In particular, some papers have found evidence of representations of colour inside LLMs (Li, Nye, and Andreas 2021; Abdou et al. 2021; Patel and Pavlick 2022). So there are likely representations of the world in LLMs too, because why wouldn't there be? They're useful for parsimonious next-token prediction.

The real world, of course, is complicated and messy and cannot be ~perfectly modelled the way Othello or colour can be. But the real world _can_ be _imperfectly_ modelled, and that can go a long way. Human brains can easily model the game of chess, but not easily other people's behaviour. But that isn't fatal, because we can _kind of_ model other people's behaviour, and therefore _mostly_ make good predictions about what they'll do. I suspect that LLMs, too, will be able to _kind of_ model a lot of messy and complicated phenomena, and quite plausibly far better than we can, provided that those world models tend to be useful in next-token prediction.

### LLMs Aren't Next-Token Predictors, They Are Next-Token-Prediction Artefacts

Gary Marcus [says](https://archive.is/zyEP1#selection-2072.0-2072.1):

> Some things get better as we make these neural network models [bigger], and some don't. The reason that some don't, in particular reliability and truthfulness, is because these systems don't have those models of the world. They're just looking, basically, at autocomplete. They're just trying to autocomplete our sentences. And that's not the depth that we need to actually get to what people call AGI, or artificial general intelligence.

In Shanahan (2022), which, to be clear, is a first-rate paper, written by one who knows far more about AI than I, there's a similar, if subtler, sentiment:

> Suppose we give an LLM the prompt "The first person to walk on the Moon was ", and suppose it responds with "Neil Armstrong". What are we really asking here? In an important sense, we are not really asking who was the first person to walk on the Moon. What we are really asking the model is the following question: Given the statistical distribution of words in the vast public corpus of (English) text, what words are most likely to follow the sequence "The first person to walk on the Moon was "? A good reply to this question is "Neil Armstrong".

It's completely true that LLMs are trained on next-token (a token is a word, roughly speaking) prediction (although some, like ChatGPT, are then additionally trained using reinforcement learning with human feedback). It's also completely true that this fact profoundly influences the texts they generate. So I don't think it's unreasonable to call LLMs autocomplete engines or to emphasise next-token prediction. But I think it's subtly misleading:

- Though LLMs were _trained_ to optimise success on next-token prediction, that is not necessarily what they _do_. We don't know what it is they do. The training process _reinforces_ behaviours/heuristics in the model that tend to cause it to make better next-token predictions on in-distribution data. This does not mean that those behaviours/heuristics are fundamentally "about" optimising next-token prediction, especially when the model encounters out-of-distribution data.[^13]
- The usual example here is human evolution. Humans were shaped by a process that optimised for reproductive fitness. This gave us a bundle of drives such as family kinship, prestige and sexual pleasure -- drives that aren't fundamentally about optimising for reproduction, which becomes evident as we enter a new environment -- one with contraceptives, say.
- What's more, optimising for a task for which intelligence is useful encourages the optimised thing to become more intelligent. Sam Altman gave expression to this last week when he [wrote](https://twitter.com/sama/status/1631421715434831872), "Language models just being programmed to try to predict the next word is true, but it's not the dunk some people think it is. Animals, including us, are just programmed to try to survive and reproduce, and yet amazingly complex and beautiful stuff comes from it."
- The forms of intelligence that are useful in doing next-token prediction are different from those that are useful in human reproduction, but I think there's a considerable overlap, as (1) some fundamental abilities, for example using and applying concepts, just seem very broadly useful and (2) the data LLMs are trained on are written by humans, for humans and often _about_ humans and things that matter to us. (Jacob Steinhardt makes similar arguments [in this post on the Alignment Forum](https://www.alignmentforum.org/posts/aEjckcqHZZny9L2zy/emergent-deception-and-emergent-optimization).)

#### The Chimpanzee Next-Word Predictor Thought Experiment

Here's a thought experiment in that same vein. Imagine a hundred thousand chimpanzees. These chimpanzees spend their entire lives in sensory deprivation chambers, never meeting one another. When they reach adulthood, they're given a set of incomplete texts and asked to predict the next word for each of them. (Suppose that, for each incomplete text, they're given all possible words and must choose one.) These texts are things that humans wrote on the internet from 1991 to 2023. The 1% of chimpanzees that do best on the next-word prediction task get to reproduce -- their sperm/eggs are extracted and children are bred in artificial wombs. Then that entire generation is euthanised. (Yes, this is a terrifying dystopia.) Imagine this procedure goes on for 1T years (for reference, _H. sapiens_ and _P. troglodytes_ diverged about 4-13B years ago).

![img]({{ '/img/sensory_deprivation_tanks.jpeg' | url }})

The question is, what sort of creature would emerge on the other side of this optimisation process? What sort of (cognitive) capabilities would they have? What, if anything, would they know about humans in the year 2023?

Very speculatively, here's a story that seems plausible to me.

At first, the chimpanzees would hardly do better than chance.

Then a mutation causes some chimpanzees to tend to select words like "the" and "a" a lot; these alleles spread quickly through the gene pool.

Other mutations give chimpanzees more elaborate heuristics, such as the tendency to complete "from time to" with "time", or "the Eiffel Tower is in" with "Paris". Yet other mutations allow chimpanzees to recognise the syntax of human languages, and that different symbols stand in different relations to one another: they realise, for example, that "Jeff Bezos is Amazon's CEO" implies that "Amazon's CEO is" should be completed with "Jeff Bezos". Taken together, these heuristics start being _functionally_ indistinguishable from what we call knowledge, use of concepts, inference, deduction, etc. And all of these things are selected for, because they produce chimpanzees that are better able to do next-word prediction, and that is all that matters for their reproductive fitness.

(It's worth noting that chimpanzees are not LLMs, and that evolution is a different optimisation process than stochastic gradient descent. I'm confused which of the disanalogies are relevant here. Clearly I'm assuming that my chimpanzees can acquire knowledge, or something close to it, via genetic mutations. Chimpanzee brains probably don't work that way, but it makes the thought experiment more analogous to LLM training ...)

This goes on and on. Now, what sort of capabilities would this process tend towards? What sort of creature would emerge on the other end of it? What capabilities would help that creature predict next words on human-written texts?

Still more speculatively, I can think of a few things that would help it make such predictions:

- It may have (or at least _contain_) intimate knowledge (or something similar) of things humans write about on the 1991-2023 internet.
- It may have (...) intimate knowledge (...) of humans who write things on the 1991-2023 internet.
- It may possess a wide range of general reasoning skills.
- It may possess a host of specialised skills aimed at next-word prediction. For example, it may learn how (human) mathematics works, for that allows it to make more accurate predictions on texts that have to do with mathematics.
- It may have the ability and motivation to gain more such knowledge, and to improve its reasoning skills.
- It may have an innate motivation to make next-word predictions, and to make them correctly, and to not die or give up until it has made them.

You may further ask yourself whether, if you took such a creature and gave it a computer in the real world in the year 2024, it would be able to use its evolved (in-distribution) knowledge, or its hard-earned talents, in that new (out-of-distribution) environment. Perhaps itsability to verify things, being hampered by its only seeing the world through text, is fatal. Perhaps it would try to influence the world in order make successful next-token predictions (or whatever else it yearns for, if it yearns at all) easier and more plentiful. These are all, in my opinion, open questions. Put differently, I don't know whether LLMs, as currently built, will ever scale to general intelligence or whether they will be limited by the world (text) or way (next-token prediction) in which they're trained; maybe it takes multimodal systems for that, or something else, or maybe it will never be possible.

## Reasons for Caution

Either way, I think it pays off to exercise unusual caution when thinking about LLMs -- both when [forecasting LLM capabilities](https://forum.effectivealtruism.org/posts/tCkBsT6cAw6LEKAbm/scoring-forecasts-from-the-2016-expert-survey-on-progress-in) (time and again such predictions have turned out to be wrong) and when assuming that such-and-such a thing must or cannot possibly happen inside an LLM.

In Landgrebe and Smith (2021), for example, we find this passage:

> [A]ll stochastic models require a _stable environment_. The quality of their output depends on how well they reflect the real-world input-output relationship they are aiming to represent. [...] [E]ven where the relationship is stable, the model will quickly become invalid if the input-output relationship changes on either side even in some minor way. This is because the model does not generalise. Once fed with data as input that do not correspond to the distribution it was trained with, the model will fail.

But this is, at least in some cases, wrong. ML models, and language models in particular, can clearly generalise. We've seen that, for example, in the modular/binary addition models mentioned above. It's true, of course, that they don't always generalise perfectly. That is the engineering problem that ML researchers are working on. But _as stated_ this passage was wrong in 2021, and it's equally wrong now.

Sticking with the same paper, Landgrebe and Smith (2021) argues:

> [Deep neural networks] are also unable to perform the sorts of inferences that are required for contextual sentence interpretation. The problem is exemplified by the following simple example:
>
> "The cat caught the mouse because it was slow" vs.
> "The cat caught the mouse because it was quick."
>
> What is the "it" in each of these sentences? To resolve anaphora requires inference using world knowledge -- here: about persistence of object identity, catching, speed, roles of predator and prey, and so forth. Thus far, however, little effort has been invested into discovering how one might engineer such prior knowledge into [deep neural networks] (if indeed this is possible at all). The result is that, with the exception of game-like situations in which training material can be generated synthetically, esp. in reinforcement learning, [deep neural network] models built for all current applications are still very weak, as they can only learn from the extremely narrow correlations available in just that set of annotated training material on the basis of which they were created. Even putting many [deep neural network] models together in what are called "ensembles" does not overcome the problem.

That, on the other hand, _was_ true in 2021, but today:

> ME: What is the "it" in each of these two sentences?
>
> 1. "The cat caught the mouse because it was slow."
> 2. "The cat caught the mouse because it was fast."
>
> CHATGPT: In the first sentence, "it" refers to the mouse, which is slow and was therefore caught by the cat. In the second sentence, "it" refers to the cat, which is fast and was therefore able to catch the mouse.

(The text-davinci-003 version of GPT-3 still seems to fail at this task, but davinci-instruct-beta succeeds, so the improvement may come from the fine tuning on human examples done for davinci-instruct-beta and/or the reinforcement learning on human feedback done for the model ChatGPT uses, gpt-3.5-turbo. Notably, gpt-3.5-turbo still fails a subtly harder version of this test.[^14])

I, too, am vulnerable to overconfidence. When I first heard of Meng et al. (2022), in which the part of an LLM storing the "Eiffel Tower → Paris" association is modified to be "Eiffel Tower → Rome" instead, causing the model to output things like "The Eiffel Tower is right across from _St. Peter's Basilica in Rome, Italy_", I thought this was pretty conclusive evidence that LLMs do have and use something very like human concepts. But then I read [Jacques Thibodeau's post](https://www.alignmentforum.org/posts/QL7J9wmS6W2fWpofd/but-is-it-really-in-rome-an-investigation-of-the-rome-model), showing, among other things, that the edit (1) is not bidirectional (e.g., the LLM doesn't seem to identify the famous tower in Rome as the Eiffel Tower) and (2) doesn't seem responsive to prompts that don't explicitly mention the phrase "Eiffel Tower". The lesson here is that LLMs are strange, complex and unhuman.

## "If We Ever Succeed [...] It Must Be by Reducing Y to 'Just X'"

Back in 2020 (a lifetime ago!) Gwern [wrote](https://gwern.net/scaling-hypothesis#critiquing-the-critics),

> The temptation, that many do not resist so much as revel in, is to give in to a _déformation professionnelle_ and dismiss any model as "just" this or that ("just billions of IF statements" or "just a bunch of multiplications" or "just millions of memorized web pages"), missing the forest for the trees, as Moravec commented of chess engines:
>
> "The event was notable for many reasons, but one especially is of interest here. Several times during both matches, Kasparov reported signs of mind in the machine. At times in the second tournament, he worried there might be humans behind the scenes, feeding Deep Blue strategic insights! [...] In all other chess computers, he reports a mechanical predictability stemming from their undiscriminating but limited lookahead, and absence of long-term strategy. In Deep Blue, to his consternation, he saw instead an "alien intelligence".
>
> [...] Deep Blue's creators know its _quantitative_ superiority over other chess machines intimately, but lack the chess understanding to share Kasparov's deep appreciation of the difference in the quality of its play. I think this dichotomy will show up increasingly in coming years. Engineers who know the mechanism of advanced robots most intimately will be the last to admit they have real minds. From the inside, robots will indisputably be machines, acting according to mechanical principles, however elaborately layered. Only on the outside, where they can be appreciated as a whole, will the impression of intelligence emerge. A human brain, too, does not exhibit the intelligence under a neurobiologist's microscope that it does participating in a lively conversation."
>
> But of course, if we ever succeed in AI, or in reductionism in general, it _must be by reducing Y to "just X"_. Showing that some task requiring intelligence can be solved by a well-defined algorithm with no "intelligence" is precisely what success must look like! (Otherwise, the question has been thoroughly begged & the problem has only been pushed elsewhere; computer chips are made of transistors, not especially tiny homunculi.)

Next-word-predicting chimpanzees is a faulty metaphor. I readily grant that. In fact, every metaphor for LLMs that I've come across has been wrong and ridiculous: there are illustrative metaphors for LLMs, but no true ones. The best I can think of is also wrong, but at least carries the message that we don't know how these systems really work, namely, that _we are looking at great computational clouds_.

## References

<style>.csl-entry{text-indent: -2em; margin-left: 2em;}</style><div class="csl-bib-body">
  <div class="csl-entry">Abdou, Mostafa, Artur Kulmizev, Daniel Hershcovich, Stella Frank, Ellie Pavlick, and Anders Søgaard. 2021. “Can Language Models Encode Perceptual Structure without Grounding? a Case Study in Color.” arXiv. https://doi.org/10.48550/ARXIV.2109.06129</div>
  <div class="csl-entry">Elhage, Nelson, Neel Nanda, Catherine Olsson, Tom Henighan, Nicholas Joseph, Ben Mann, Amanda Askell, et al. 2021. “A Mathematical Framework for Transformer Circuits.” <i>Transformer Circuits Thread</i>.</div>
  <div class="csl-entry">Landgrebe, Jobst, and Barry Smith. 2021. “Making Ai Meaningful Again.” <i>Synthese</i> 198: 2061--81.</div>
  <div class="csl-entry">Lewkowycz, Aitor, Anders Andreassen, David Dohan, Ethan Dyer, Henryk Michalewski, Vinay Ramasesh, Ambrose Slone, et al. 2022. “Solving Quantitative Reasoning Problems with Language Models.” arXiv. https://doi.org/10.48550/ARXIV.2206.14858</div>
  <div class="csl-entry">Li, Belinda Z., Maxwell Nye, and Jacob Andreas. 2021. “Implicit Representations of Meaning in Neural Language Models.” arXiv. https://doi.org/10.48550/ARXIV.2106.00737</div>
  <div class="csl-entry">Li, Kenneth, Aspen K. Hopkins, David Bau, Fernanda Viégas, Hanspeter Pfister, and Martin Wattenberg. 2022. “Emergent World Representations: Exploring a Sequence Model Trained on a Synthetic Task.” arXiv. https://doi.org/10.48550/ARXIV.2210.13382</div>
  <div class="csl-entry">Meng, Kevin, David Bau, Alex Andonian, and Yonatan Belinkov. 2022. “Locating and Editing Factual Associations in Gpt.” arXiv. https://doi.org/10.48550/ARXIV.2202.05262</div>
  <div class="csl-entry">Nanda, Neel, Lawrence Chan, Tom Lieberum, Jess Smith, and Jacob Steinhardt. 2023. “Progress Measures for Grokking via Mechanistic Interpretability.” arXiv. https://doi.org/10.48550/ARXIV.2301.05217</div>
  <div class="csl-entry">Olsson, Catherine, Nelson Elhage, Neel Nanda, Nicholas Joseph, Nova DasSarma, Tom Henighan, Ben Mann, et al. 2022. “In-Context Learning and Induction Heads.” <i>Transformer Circuits Thread</i>.</div>
  <div class="csl-entry">Patel, Roma, and Ellie Pavlick. 2022. “Mapping Language Models to Grounded Conceptual Spaces.” In <i>International Conference on Learning Representations</i>. <a href="https://openreview.net/forum?id=gJcEM8sxHK">https://openreview.net/forum?id=gJcEM8sxHK</a>.</div>
  <div class="csl-entry">Power, Alethea, Yuri Burda, Harri Edwards, Igor Babuschkin, and Vedant Misra. 2022. “Grokking: Generalization beyond Overfitting on Small Algorithmic Datasets.” arXiv. https://doi.org/10.48550/ARXIV.2201.02177</div>
  <div class="csl-entry">Shanahan, Murray. 2022. “Talking About Large Language Models.” <i>Arxiv Preprint Arxiv:2212.03551</i>.</div>
  <div class="csl-entry">Srivastava, Aarohi, Abhinav Rastogi, Abhishek Rao, Abu Awal Md Shoeb, Abubakar Abid, Adam Fisch, Adam R. Brown, et al. 2022. “Beyond the Imitation Game: Quantifying and Extrapolating the Capabilities of Language Models.” arXiv. https://doi.org/10.48550/ARXIV.2206.04615</div>
  <div class="csl-entry">Toshniwal, Shubham, Sam Wiseman, Karen Livescu, and Kevin Gimpel. 2021. “Chess as a Testbed for Language Model State Tracking.” arXiv. https://doi.org/10.48550/ARXIV.2102.13249</div>
  <div class="csl-entry">Wei, Jason, Yi Tay, Rishi Bommasani, Colin Raffel, Barret Zoph, Sebastian Borgeaud, Dani Yogatama, et al. 2022. “Emergent Abilities of Large Language Models.” arXiv. https://doi.org/10.48550/ARXIV.2206.07682</div>
</div>

[^1]: See Wei et al. (2022) for some examples of emergent capabilities measured using sets of benchmark tasks, including arithmetic, word unscrambling, analogical reasoning and more.
[^2]: Though it's certainly true that LLMs are unreliable, I think Marcus's assessment of and predictions about their capabilities are mistaken. I reckon I think reliability is less of an issue than he does because (1) for many applications, reliability isn't necessary, (2) even when it is, you can sometimes work around LLMs' lack of reliability, for example by adding quality control processes to check their outputs, and (3) even though the frontier for AI capabilities is everlastingly faulty, LLMs _are_ getting more reliable at specific tasks[^3]: this is often forgotten as those particular capabilities, which used to be at the frontier, are now so obvious that they're taken for granted, and reminds me of a marathon runner keeping their eyes fixed a few paces ahead, not really sensing the distance they've travelled. As for truthfulness, I'm guessing, with lots of uncertainty, that LLMs will get better at this though, like humans, they won't become perfectly truthful any time soon, and that [will be a real problem](https://www.alignmentforum.org/posts/sdxZdGFtAwHGFGKhg/truthful-and-honest-ai).
[^3]: Example: Sorting randomly generated single-digit integer lists. Two years ago janus tested this on GPT-3, and found that, even with a 32-shot (!) prompt, GPT-3 managed to sort lists of 5 integers 10/50 times, and lists of 10 integers 0/50 times. (A 0-shot, Python-esque prompt did better at 38/50 and 2/50 respectively). I tested the same thing with ChatGPT just now and it got it right 5/5 times for 10-integer lists. (Example prompt: "Can you sort this list in ascending order? [0, 8, 6, 5, 1, 1, 1, 8, 3, 7]".) I then asked it to sort five 10-integer lists in one go, and it got 4/5 right! (NB: I'm pretty confident that this improvement didn't come with ChatGPT exactly, but rather with the newer versions of GPT-3 that ChatGPT is built on top of.)
[^4]: Gary Marcus [writes](https://garymarcus.substack.com/p/nonsense-on-stilts): "Neither LaMDA nor any of its cousins (GPT-3) are remotely intelligent. All they do is match patterns, draw from massive statistical databases of human language."
[^5]: Ted Chiang [writes](https://archive.is/OV88I): "The fact that ChatGPT rephrases material from the Web instead of quoting it word for word makes it seem like a student expressing ideas in her own words, rather than simply regurgitating what she's read; it creates the illusion that ChatGPT understands the material. In human students, rote memorization isn't an indicator of genuine learning, so ChatGPT's inability to produce exact quotes from Web pages is precisely what makes us think that it has learned something. When we're dealing with sequences of words, lossy compression looks smarter than lossless compression. [...] There's nothing magical or mystical about writing, but it involves more than placing an existing document on an unreliable photocopier and pressing the Print button. It's possible that, in the future, we will build an A.I. that is capable of writing good prose based on nothing but its own experience of the world. The day we achieve that will be momentous indeed -- but that day lies far beyond our prediction horizon. In the meantime, it's reasonable to ask, What use is there in having something that rephrases the Web?"
[^6]:
    Emily Bender [says](https://medium.com/@experiential.ai/written-recap-ieai-hosts-on-the-dangers-of-stochastic-parrots-with-emily-m-bender-9f0c597aabec): "[A Language Model] is a system for haphazardly stitching together linguistic forms from its vast training data, without any reference to context or meaning. That's where the term 'stochastic parrots' comes from. Parrots mimic sounds, but they don't understand what they mean. LMs may haphazardly output form, and they've gotten pretty good at making forms that look plausible. But it's still the human being, encountering synthetic text, who makes sense of it. The computer is merely making a pattern that the human then applies meaning to."

    Elsewhere she [says](https://twitter.com/emilymbender/status/1598161759562792960?s=20&t=_4DUnTbmpbANAIJNnXbEJQ): "Just so everyone is clear: ChatGPT is still just a language model: just a text synthesis machine/random BS generator. Its training has honed the form of that BA a bit further, including training to avoid things that _look like_ certain topics, but there's still no there there. [...] ChatGPT generates strings based on combinations of words from its training data. When it sometimes appears to say things that are correct and sensible when a human makes sense of them, that's only by chance."

    It may be unfair to group Bender's argument with descriptors like "shallow pattern matchers" and "massive look-up tables". Her view is not an unconsidered take, but a proper philosophical argument: principally, that LLMs (1) don't _ground_ the meaning of words in sensory experience of the world, and therefore exhibit no understanding, and (2) generate text without _intending_ anything.

    But Bender also seems to think that this has implications for what LLMs can do, and what they'll be able to do in future. So maybe it is fair to group them, after all. It quite possible to me that LLMs are limited by their lack of access to the non-textual world, similarly to how a human would be limited if they only learned about things through textbooks. It also seems plausible that LLMs cannot be scaled up to AGI -- that we'd need multimodal systems trained on diverse tasks, or some other regime, to reach AGI.

[^7]: Another, and parallel, drive is to push back against excessive anthropomorphising. But I think the reason people want to push back against anthropomorphising is often to prove that LLMs are less capable, or less impressive, than they seem. Another reason is to put an end to flawed reasoning, a laudable goal, but one undermined by the subsequent retreat to similarly flawed reasoning.
[^8]: Important, but not a good ground of dismissal. To [quote](https://dailynous.com/2023/03/02/multimodal-llms-are-here/) Justin Weinberg, "[Q]uite possibly the stupidest response to this technology is to say something along the lines of, 'it's not conscious/thinking/intelligent, so no big deal'."
[^9]:
    Can internal computation alone in principle produce strategically-aware planning systems? Obviously LLMs can generate texts that describe plans, but can they also "understand" them or act on them? I don't think so -- LLMs are passive, only doing things when they are prompted.

    That said, LLMs could do some sort of planning and plan-execution internally when generating outputs. Transformers, as vanilla neural networks, compute sequentially when doing inference.

    Elhage et al. (2021): "One of the main features of the high level architecture of a transformer is that each layer adds its results into what we call the 'residual stream'. [...] The residual stream has a deeply linear structure. Every layer performs an arbitrary linear transformation to 'read in' information from the residual stream at the start, and performs another arbitrary linear transformation before adding to 'write' its output back into the residual stream."

    So it seems possible for an LLM to produce a plan (appropriate to the input received) in its earlier layers, and execute that plan in its later layers. This surely makes them capable of (at least rudimentary forms of) planning, in principle. It's an open question whether something like this actually happens in LLMs today.

[^10]: The model is trained directly on addition, meaning that, while it shares the same architecture as LLMs, it's trained on a far more limited type of data, and for a far more specialised task, than LLMs. I see no reason why LLMs shouldn't be capable of learning general rules in the same way that this addition model is, though it would of course take far more time for an LLM to grok the general rules _of addition in particular_ since (1) addition is only a tiny part of the data set that LLMs are trained on, and (2) the general rules of addition competes for space in the model's weights with other general rules, and with shallowly memorised information.
[^11]:
    Why, you may ask, does the model strive for the more general algorithm, when _memorising_ the answers is enough to achieve a low loss on the training data? It doesn't, after all, see any of the test data during training, so it's unaware of how badly it does out-of-distribution. The answer is that modern ML models are _regularised_, meaning more or less that they are encouraged, in various ways, to learn more generalisable patterns. In Nanda et al. (2023), this is chiefly done by penalising the model for having large weights (this is called _weight decay_), which incentivises it to use smaller weights to achieve its goal of achieving low error, in effect punishing it for rote memorisation.

    My understanding is that, in this experiment at least, the model gradually picks up small general patterns that help it lower its weights, for example recognising that 2 + 7 is equivalent to 7 + 2. These patterns don't form an entire, independently working algorithm, and therefore don't help the model on out-of-distribution data, but they do help make the model more parsimonious. At some point, though, there are enough of these general patterns that the model can "put them together" into an independently working algorithm, such that it swiftly becomes able to (1) perform just as well out-of-distribution as in-distribution and (2) shed any (now unnecessary) memorised answers to the training data.

[^12]: Jacob Steinhardt collects further examples of ML phase changes in ["Future ML Systems Will Be Qualitatively Different"](https://bounded-regret.ghost.io/future-ml-systems-will-be-qualitatively-different/) and ["Emergent Deception and Emergent Optimization"](https://bounded-regret.ghost.io/emergent-deception-optimization/).
[^13]: As I was writing this post, I came across [Matthew Barnett's post](https://matthewbarnett.substack.com/p/a-reply-to-michael-huemer-on-ai) on a similar subject. He makes pretty much these same points.
[^14]: Here is ChatGPT partially failing another test along the same lines:

    "ME: What is the 'it' in each of these two sentences?

    1.  The cat fed the kitten because it was hungry.
    2.  The cat snarled at the kitten because it was angry.

    CHATGPT: In both sentences, 'it' refers to the cat. In the first sentence, the cat fed the kitten because the cat was hungry. In the second sentence, the cat snarled at the kitten because the cat was angry."

    Though if phrased differently, it sometimes (but not always) gets it right:

    "ME: What is the 'it' in each of these two sentences?

    1.  The cat fed the kitten because it was hungry.
    2.  The kitten was snarled at by the cat because it was angry.

    CHATGPT: In both sentences, 'it' refers to the subject of the clause that precedes it.

    1.  In the first sentence, 'it' refers to the kitten, which was hungry and therefore fed by the cat.
    2.  In the second sentence, 'it' refers to the cat, which was angry and therefore snarled at the kitten."

    So I'm happy to concede that ChatGPT doesn't grasp, or doesn't fully grasp, the meaning of these sentences. I reckon GPT-4 will pass this test, but we shall see.
