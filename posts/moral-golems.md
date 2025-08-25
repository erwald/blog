---
layout: layouts/post.njk
title: Moral Golems
date: 2021-04-03
tags: post
lw_link: https://www.lesswrong.com/posts/josSvCNbYthxwi7cM/moral-golems
---

# Moral Golems

![Drawing by Viktoriia Shcherbak of huddling golem.]({{ '/img/hero/golem.png' | url }})

> Stop thinking of the project of ethics as "figure out which simple theory is True".
>
> Start instead thinking of ethics as a project of trying to piece together psychological models of this insanely complicated and messy thing, "human morality".
>
> Binding exceptionless commitments matter to understanding this complicated thing; folk concepts like courage and honesty and generosity matter; taboo tradeoffs and difficult attempts to quantify, aggregate, and weigh relative well-being matter.
>
> Stop picking a "side" and then losing all interest in the parts of human morality that aren't associated with your "side": these are all just parts of the stew, and we need to work hard to understand them and reconcile them just right, not sort ourselves into Team Virtue vs. Team Utility vs. Team Duty.[^1]
>
> – Rob Bensinger

Rob Bensinger [writes](https://www.lesswrong.com/posts/3Lyki5DCHnJgeNXww/what-i-d-change-about-different-philosophy-fields#ethics___value_theory) that the search for true moral systems is quixotic, that ethics is so complicated that we cannot hope to capture it in a neat, rule-based system and that our project ought instead to be to construct, starting from observations about what humans think, do and feel, a conglomerate of systems, or maybe an amalgam, that together capture these observations as well as possible, though necessarily imperfectly.

He writes this in a post about things he would like to change about contemporary philosophy, which seems a little off, in a way, because my impression is that philosophers have been mostly [anti-realist](https://plato.stanford.edu/entries/moral-realism/) during the past century. That is to say, they don't think moral claims (e.g. "it is wrong to murder") are things that can be true or false, or that moral claims don't even pretend to be such things. Though I suppose it is possible to be both anti-realist and non-syncretic. Anyway, Rob would probably say that it doesn't matter, because even if moral claims _can_ be true, there is no way for us to find out which of them _are_ true – morality is just too complicated. The point is that we should not get tunnel vision on seeking the one true moral system, because no moral system could possibly describe the complex nature of human morality.

This is similar to the sentiment expressed here by Bernard Williams:

> Now, I don't think, when we talk about utilitarianism, that we should be thinking of it as if we were discussing simply the timeless truth of some moral system, as if it were somehow written in the galaxy what the true moral system was and we were trying to find out what that truth is. I think what we're trying to do – what we're all trying to do, utilitarians included – is to arrive at the most sensible judgment of a public morality to suit the peculiar needs of a modern society.[^2]

I use **moral system** here to mean _a set of procedures and principles that, given a certain act in a certain situation, tells us whether that act is right or wrong_. Think the kind of system somebody has for picking racehorse winners, except applied to ethics.

## Golems

Richard McElreath, in his textbook on Bayesian statistics, likens statistical models to golems:

> A golem (GOH-lem) is a clay robot from Jewish folklore, constructed from dust and fire and water. It is brought to life by inscribing _emet_, Hebrew for "truth", on its brow. Animated by truth, but lacking free will, a golem always does exactly what it is told. This is lucky, because the golem is incredibly powerful, able to withstand and accomplish more than its creators could. However, its obedience also brings danger, as careless instructions or unexpected events can turn a golem against its makers. Its abundance of power is matched by its lack of wisdom.[^3]

Moral systems are a little bit like statistical models in that they are constructs that take some input, do some computation and produce some output. The input is the proposed action and the situation in which it happens; the output is the rightness or wrongness of that action.

The point is that the golem is dumb. It produces answers that are true only in its own small world. This small world is necessarily limited. It's limited by the assumptions baked into the model, by the data that is fed into it and so on.

The golem will always do what it's told. You can improve it, perhaps, by giving it more detailed instructions. But then you are tethering it to a specific environment. If you transport the golem to a different place, it will probably do worse with the more detailed instructions and better with the simpler instructions, in the same way that more complex statistical models can produce worse predictions when moved to a different context due to [overfitting](https://statisticsbyjim.com/regression/overfitting-regression-models/).

You see where I am going with this. I think moral systems can overfit, too, just like statistical models can. Say Eithne has philosophised herself a moral system. Now she comes across an interesting thought experiment. When she applies her moral system to the thought experiment (this is the new context), it produces an outlandish outcome which she cannot possibly accept. Maybe it fails, in the new situation, to judge wanton murder to be wrong. So she adjusts her moral system to account for the new data. It now produces sensible outcomes on both the new example and the old examples that she has tested it against. Neat! But Eithne has also made her system more complex. If she keeps doing that, it may become closely tied to the contexts she has considered and won't transfer well to new contexts.

In other words, there are simpler moral systems and there are more complex ones. The simple systems have the advantage of – like statistical golems – generalising better, though the complex ones may perhaps do better on the training data.

I take Rob Bensinger to suggest that Eithne ought to keep her moral system simple and that, rather than extend it, she ought to complement it with new, additional systems. She should not search for the one true moral system, she should seek many moral systems that each have _a truth_ in them. Of course these would need to be combined somehow, e.g. with a higher-order system that merges them or selects between them. That might work well because some moral systems may do better in certain contexts, so that, if she can successfully select between them, this conglomerate of systems can do well on specific tasks without being too closely tied to a specific context. This is [ensemble modelling](https://www.sciencedirect.com/topics/computer-science/ensemble-modeling), but with moral systems.

But there's a crucial difference between statistical models and moral systems. Statistical models are used to answer questions about the world as it is, descriptively. But moral systems are meant to answer what we _ought_ to do, normatively. The problem here is that we have no observational data when it comes to morality. Or do we?

## Intuition

When constructing and evaluating moral systems, we often use our intuitions about morality. Eithne, for example, adjusted her moral system because it told her that, in some certain situation, wanton murder was not wrong. But she _knew_ that wanton murder was wrong. How did she know it? Intuitively.

I've written before about reconciling intuitive morality with intellectual moral systems. The example I used was that of Leo Tolstoy organising famine relief work in Ryazan despite his philosophical opposition, derived from the moral teachings of Jesus of Nazareth, to private charity. One of my proposed solutions in the Tolstoy post was that we use intuition to adjust and recalibrate our moral system. I [wrote]({{ '/posts/tolstoy-in-ryazan/' | url }}):

> However, there may be another way for us to reconcile intuitive morality with a moral system. We can use intuitions as evidence to consider when forming beliefs about moral questions, just as we consider perceptions of the world when forming beliefs about the world. There seem to be white flecks of snow falling outside the window. One believes that it is snowing outside. It seems like a good thing to organise charitable activities for the starving muzhiks. One believes that it is a good thing to do so.
>
> Of course there are problems with intuition. It is sometimes wrong, distorted by biases, hamstrung by social tradition. But it's right more often than not, especially on many elemental moral questions like murder, theft, bearing false witness and so on. So one could assign it a certain weight and let it overrule one's moral system when an intuition is particularly strong. What this is is simply to recognise that one's moral system, like any moral system, has failure modes because it is a kind of abstraction. And intuition can both on the one hand act as a safeguard against such failure modes and on the other cause us to adjust – to recalibrate, so to put it – our moral system.

Could this lead to the kind of extreme complicating of a system with contingencies that would cause a system to lose its ability to generalise, in other words to overfit? I don't know. Maybe there is so little data involved here that there's no risk of it. Or maybe, instead of trying to extend and modify the simple moral systems, we ought to keep them simple and acknowledge that they will misfire in some edge cases. We could then identify some of these misses using our intuition.[^4]

All this is similar to the double-level theory that Christine Korsgaard proposes for dealing with evil in Kantian ethics.[^5] Kant famously wrote that one oughtn't ever to lie, even if it was exceedingly likely to save somebody's life.[^6] Korsgaard argues (with more subtlety than I'll do justice here) that these maxims are an ideal to live up to in ideal circumstances, but that, when faced with evil, and only when faced with evil, they can become a goal to seek instead.[^7] What she's doing, it seems to me, is presenting two moral systems with a meta-system for deciding which to apply in a given situation. That is like the rabbi animating two specialised golems along with a third golem to supervise and coordinate the two.

If anything matters at all, objectively, then our task must be to find a moral system that maps as closely as possible to what is objectively good. It seems probable that we haven't found such a moral system yet. Maybe such a system is not even possible to express in human language or to understand using the human intellect. If so, the project of ethics is not dissimilar from that of the social sciences, say, in that it tries to produce answers by modelling the essential characteristics of very complicated human structures.

[^1]: Bensinger, _[What I'd change about different philosophy fields](https://www.lesswrong.com/posts/3Lyki5DCHnJgeNXww/what-i-d-change-about-different-philosophy-fields)_.
[^2]: Williams, _[Utilitarianism](https://www.youtube.com/watch?v=H6fejg5A1bU)_.
[^3]: McElreath, _Statistical Rethinking: A Bayesian Course with Examples in R and Stan_.
[^4]:
    But ... if it's correct to sometimes override our moral system(s), or to combine them in some way, then how do we know that what we're doing is good at all? If a moral system is not correct in all situations, how can we trust its output in any one particular situation? Don't we need some solid fundament on which to stand? Otherwise we are like Baron Münchhausen, pulling ourselves out of the mud by our own hair.

    You might be convinced that Kantianism is the good and true moral system. If so, it should be surprising to be unsettled by some of its more controversial outcomes, like the impermissibility of lying to prevent murder. After all, while those outcomes may seem _intuitively_ bad, if (that form of) Kantianism is correct, then they are in fact good.

    This is the problem of [moral realism](https://plato.stanford.edu/entries/moral-realism/) that I referenced early on in this post.

[^5]: Korsgaard, _Creating the Kingdom of Ends_.
[^6]: ibid.
[^7]: ibid.
