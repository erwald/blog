---
layout: layouts/post.njk
title: Four Ways of Not Writing Software Bugs
date: 2021-02-06
tags: post
---

# Four Ways of Not Writing Software Bugs

## Summary

I present four ways of avoiding bugs:

1. Not writing the code in the first place.
2. When changing a program's behaviour, making the smallest modification needed to effect that change.
3. When refactoring, making sure there are automated tests covering the affected code.
4. When making a change, actually deeply thinking things through.

## Introduction

If a Heaven did exist, it would not be a place where we have everything made for us; rather, it would be a place where everything we make is without defects.[^2] I've known a lot about software bugs, having written most of them. Sometimes no one has noticed, and at other times they have caused serious and embarrassing disruptions. They've bloomed like flowers in rolling meadows. They've taken root in every garden. But they are not wild: everybody knows who planted them. And (excuse my stretching the simile to its furthest limits) they make our vibrant industry look like a flower shop.

An old joke goes that the chief executive of a large tech company gives a speech in which he asserts that, had cars been developed like software, they would cost a hundredth of what they do now and run twice as far on a litre. "Yes", an automotive exec replies later, "and they would crash once a week and when you call for service, they'd tell you to reinstall the engine."

Software is great: it does amazing things. But software is also bad: it's bloated and full of bugs. It may not be as buggy as it was twenty years ago, and clearly it was never buggy enough for people not to use it, but it's bad enough even so. You can easily confirm this yourself by searching a news aggregator for "software bug" or "software glitch" and finding, as I now find from the past week alone, articles about [150K arrest records disappearing in the UK](https://www.computing.co.uk/news/4025865/software-errors-wipes-thousands-arrest-records-police-databases), [56K defective cars being recalled](https://www.reuters.com/article/volkswagen-software/volkswagen-recalls-56000-golf-models-for-software-update-idUSL8N2JN2HL), [interruptions in the Indian vaccination drive](https://indianexpress.com/article/cities/mumbai/maharashtra-covid-19-vaccine-drive-tribal-rural-areas-challanges-7149270/) and so on.

Or to borrow someone else's words:

> I think it’s highly embarrassing for this profession that “program crashes/hangs/malfunctions” is such a common occurrence that 5 billion non-developers are not only acutely aware of it, but consider it an unsurprising state of things.
>
> It’s as if large parts of humankind were familiar with civil engineering jargon because collapsing bridges were a daily occurrence.[^3]

What, then, to do? In general, you can get better at not writing bugs (a) by practising writing code, (b) by changing the conditions that make them more likely and/or (c\) by figuring out which sorts of behaviours can prevent them. Here I want to discuss (c\): how should we write code so as to reduce the risk of introducing bugs? That means I won't discuss tooling, learning, project management or anything of that sort: I will limit my discussion to the activity of programming and will consider this in the context of software that is running in production systems, serving >1K users and for which defects can have serious adverse consequences.

## 1. Consider Not Writing the Code in the First Place

Wayne Gretzky said that you miss 100% of the shots you don't take. I say that you have 0% chance of introducing bugs in code you don't write.

If your software is not written yet, you will obviously need to write code. Or change may be necessary: you may be in a business where competition drives you to always come up with new ways of adding value, or maybe your software needs to adapt to changing external conditions. These are all good reasons to write code, but they are not all the reasons that we write code. [There's no reason to think that software needs to change forever.](https://drewdevault.com/2021/01/04/A-culture-of-stability-and-reliability.html) Many features are negotiable.

Two types of code changes are relevant here, I think. The first is a change needed to implement new features. The second is refactoring, that is changing code in order to better structure it without modifying its behaviour.

A code change that implements a new feature is additive and therefore makes the software more complex. It is harder to avoid writing bugs in complex software. It is also harder to diagnose and fix bugs in complex software. Therefore, additive code changes involve both a direct risk and an indirect risk of introducing new bugs. That should make us think twice as hard before introducing new features, but in fact it is usually taken for granted that new features are good for software. Rid yourself of that assumption. You or somebody else should, before implementing a new feature, ask yourselves the question: how much marginal value does this feature provide for the user?

Refactoring is praised everywhere. I don't claim that it isn't important; it's our finest weapon in the unending war against entropy. But every time we refactor a piece of code, we risk introducing bugs.[^4] The risk can be reduced with robust testing, as we'll see below. But it will never go away completely.

So we need to balance the need for refactoring against the need for reliability and stability. We must ask ourselves questions like:

- How long will the code be maintained?
- How important is reliability and stability to the system?
- How much will the intended change improve the code?

One must think critically. We often start refactoring code not because it is in a particularly bad state but simply because _we can and know how to do it_. That is a mistake. When we do, we shackle ourselves to [the politician's syllogism](https://en.wikipedia.org/wiki/Politician%27s_syllogism), which (adapted somewhat) says: we must refactor things; I can refactor this thing; therefore, I must refactor this thing.

## 2. If You Do Have to Make a Change, Make It As Small As Possible

The second maxim is a corollary of the first. It begins with the observation that, in practice, it can be tempting to make some changes that are not directly related to whatever it is we are doing at the time. For example, say we are fixing a bug but notice that the component or function we're looking at is very long and could -- so we reason -- be split up into several smaller, composable functions. That's an admirable aim. But it increases the risk of introducing new bugs, at least in the short term. When we notice such things, we should consider not making that additional change, or, if we do decide to go through with it, making the change separately from the fix. (That is better because small, monadic changes are easier to test and easier to review.)

I make an exception here for whenever we can actually meaningfully reduce complexity, such as by removing branches from a conditional expression. Another exception would be to refactor code as an initial step prior to making functional changes to a component, but that should be done in the spirit of the following maxim.

## 3. If You Want to Refactor Something, Make Sure It’s Covered by Automated Tests

Imagine that you are a spy. You are breaking into somebody's apartment in order to find and take copies of such-and-such a document. Being a good spy, it is important to you that the owner of the apartment doesn't notice that you've been there. So before rummaging around, you take photographs of every room in order that, once you have found and copied the document, you can restore the apartment to its original condition. The photographs you have taken are an external check on whether you are leaving the room in the same condition that you found it in. It doesn't guarantee that nothing is out of place. But it increases the probability that there's no discernible change.

Refactoring something means changing its implementation internally without changing its behaviour externally. You can create an external check similar to the spy's photos when refactoring by making sure that the thing you are refactoring is covered by automated tests.[^5] That way you can be more confident that the changes you make are not affecting the behaviour. You could almost make them without thinking at all, which brings me to the final maxim ...

## 4. When You Make a Change, Make Sure You Understand What You're Doing

Before personal desktops were able to compile code, it had to be compiled on mainframes which often had to be booked in advance.[^6] That meant that programmers had to check their code carefully before compiling it, so as not to risk, should the program fail to compile, having to wait again in order to redo it. These days, we get near-instant feedback, not only from our compilers but also from running and testing our code. This feedback loop has been shortened further by advances like hot reloading. This is great because it helps us to iterate quickly and work in a state of flow. But it also allows us to program without really thinking hard about what we are doing.

Exactly that happens to me now and again, usually when I'm lacking mental energy. Maybe I'm not considering all the possible inputs that a function can receive, or maybe I'm not thinking about all the possible branches in a conditional expression. I am confident that the thing I'm doing right now is correct. But I don't know whether it is messing something up elsewhere.

When this happens, there is a kind of hill to climb, a hill from which everything is visible in a clearer light. I know this, but still I don't always find it in myself to go there. This is pure weakness of the will. The hard thing is to notice it. Having noticed it, you can either put the task aside to do when you have more energy, or summon up the strength to do the thing properly.

It may help you to imagine that you are going to deploy your change to be tested by a grizzled old no-nonsense manual tester. If there's a bug in your code, this tester is going to find it. Manual testing is like the tort system: as when a person is injured by a product they can sue the manufacturer, causing manufacturers to worry about their products' safety, so the manual tester can file a report when they discover a bug, causing you to worry about your code's correctness. But you can worry without the punitive threat, too.

## Learning from Errors

> They know the water best who have waded through it.[^1]

What normally happens to bugs is that they are fixed and forgotten. When we discover them, we are interested in fixing them, not in understanding the reasons why they happened; and even if we are so interested, we only rarely remember the conditions of their origin anyway. But it doesn't have to be like that. The way out of this is obvious. To avoid error, we must study error.

Never let a good incident go to waste. Each defect is an invitation to learn. And so is every near miss. You learn by analysing what went wrong, for instance through a [root cause analysis](https://en.wikipedia.org/wiki/Root_cause_analysis). An analysis of a product, project or incident after completion is sometimes called a [post-mortem](https://www.pagerduty.com/resources/learn/incident-postmortem/). Such analyses need to be non-punitive, blame-free procedures. They need to be in a sense forward-looking, not backward-looking, despite the name. Having found the deeper problem, you improve the system by putting into place changes that prevent that problem from occurring again. Practise this and you will be rewarded twice over: first in learning how serious bugs happen, then in improving the system you're working on.

[^1]: Grayling, A. (2011). _The Good Book: A Humanist Bible_. New York: Walker & Co.
[^2]: I adapted this joke from [Theodosius Dobzhansky](https://en.wikipedia.org/wiki/Theodosius_Dobzhansky#Final_illness_and_the_%22Light_of_Evolution%22).
[^3]: See [this comment](https://lobste.rs/s/fzvd1v/former_uber_engineer_s_disaster_story#c_sy3xu2) by a user named soc on a Lobsters post about software struggles in Uber.
[^4]: Ferreira, I., Fernandes, E., Cedrim, D., Uchôa, A., Bibiano, A. C., Garcia, A., Correia, J. L., Santos, F., Nunes, G., Barbosa, C., Fonseca, B., & de Mello, R. (2018, May 27). _The buggy side of code refactoring_. Proceedings of the 40th International Conference on Software Engineering: Companion Proceedings. ICSE ’18: 40th International Conference on Software Engineering.
[^5]: If you are diligent about testing, the thing you are refactoring is likely to already be covered by automated tests. If not, you will need to write them. But if you're refactoring a thing, it's hopefully working correctly already. So if you write automated tests for it and those tests pass, you can be _fairly_ confident that the tests make sense. I suspect one reason that people find it hard to consistently practise test-driven development is that it is often easier to write tests for fully implemented functions and components than for skeletal interfaces.
[^6]: Well, so I gather, anyway. I can't claim to have been around for that.
