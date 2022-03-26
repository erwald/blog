---
layout: layouts/post.njk
title: Code Purity and Principles
date: 2021-03-31
tags: post
---

# Code Purity and Principles

Code, like rooms, can be dirty. Mary Douglas wrote that dirt – the real, physical sort – is "matter out of place".[^1] You have an image of how you want your room to look, and all the stuff that doesn't fit that image, everything that's unwanted – that's dirt. And when you have rid your room of dirt, when it conforms to your image of how it should look, then it is clean, or pure. In this sense, cleaning is a creative act.

When you program, and especially when you refactor, you also have an image (though maybe not a conscious one) of how you want your program or procedure to look, and all the lines of code that don't fit that image are _dirty_. For instance, say you read about the single-responsibility principle – that each class or module or function should be responsible for one thing only. You read about it, it makes sense to you: it looks great. Now what? Every time you see a function that does two things, or a class that does a dozen things, it looks _dirty_ to you. You want to change it so that it conforms to your image of clean code.

Douglas wrote that, in the human realm, a striving for purity has given rise to dietary rules, religious rituals, and social and sexual taboos.[^2] Many of those things seem strange to us now. But don’t we have equivalents in the world of programming? Well, yes, the parallel is pretty clear. We just call them "best practices", "habits" and "code smells" instead. But undergirding it all is the same striving for purity.

![Drawing by Viktoriia Shcherbak of woman with laptop.]({{ '/img/code_purity_1.jpeg' | url }})

Now, you may be thinking that this is all irrational. Ancient dietary rules, magical rituals and cultural taboos are all things of the past! Like proverbs, they are crude, contradictory and based on feelings. We shouldn't let the yuck factor rule our lives. The appeal to emotion is a logical fallacy!

But these things are not irrational if we follow Jonathan Baron's definition of rational thinking: "[it] is whatever kind of thinking best helps people achieve their goals".[^3] Mary Douglas interpreted these practices as existing not in order to stay healthy or prevent disease, but to maintain an order.[^4] In the same way, best practices, good habits and avoidance of code smells, although they may be irrational in individual situations, on the whole work to keep the house of code in order.

General principles are better than nothing. But the moment you understand the deep reason a principle exists, the need for the principle vanishes. For instance, we hear that hardcoding configuration values is bad. Instead, you should parametrise. If you stick to this rule, you'll do all right. But if you understand why the rule exists – here, for reasons of extendability, reusability and portability – you already know when you ought to avoid hardcoded values and you don't need to remember a rule that will misfire part of the time.

![Drawing by Viktoriia Shcherbak of scaffolding.]({{ '/img/code_purity_2.jpeg' | url }})

The principle of Chesterton's fence, generally stated, says that one shouldn't change something when one doesn't know how it came to be that way.[^5] Or, as the popular saying goes, _you've got to learn the rules before you can break them_. We can look at our best practices in that way. They have evolved over time and distil much of our best understanding about coding into a concise set of maxims. And as with any generalisation, they will miss the mark under some particular conditions. But for the most part they help us achieve our goals.[^6]

Arthur Schopenhauer described pedantry as what happens when people "lack confidence in their own understanding" and, instead of thinking for themselves, with an eye to the particular, "start out from universal concepts, rules and maxims and seek to hold themselves exactingly to these".[^7] Principles are like masons' scaffolding. We use them to learn, but when we have learned we have no need of them anymore, because the solid structure is there.

[^1]: Douglas, _Purity and Danger: An Analysis of Concepts of Pollution and Taboo_.
[^2]: ibid.
[^3]: Baron, _Thinking and Deciding_.
[^4]: Douglas, _Purity and Danger: An Analysis of Concepts of Pollution and Taboo_.
[^5]: Chesterton, _The Collected Works of G.K. Chesterton_.
[^6]: [DePonySum brings up](https://deponysum.com/2020/01/05/chestertons-fence-and-thinking-using-sayings/) one problem with Chesterton's fence. It sees change as something exogenous. So current best practices is something that _just is over here_, and somebody wanting to change them _is coming from outside_. Whereas, in practice, these conventions are constantly evolving and it is only thanks to constant change and variation that they have improved and do continue to improve.
[^7]: Schopenhauer, _The World as Will and Representation_.
