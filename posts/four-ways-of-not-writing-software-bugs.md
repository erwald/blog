---
layout: layouts/post.njk
title: Four Ways of Not Writing Software Bugs
date: 2021-02-06
tags: post
---

# Four Ways of Not Writing Software Bugs

> They know the water best who have waded through it.[^1]
>
> – Proverb

If a Heaven did exist, it would not be a place where we have everything made for us; rather, it would be a place where everything we make is without defects.[^2] Now, I know a lot about software bugs. I've written most of them. Sometimes nobody notices; at other times they cause serious and embarrassing incidents. They bloom like flowers in a meadow. They take root in every garden. But they aren't wild: everybody knows who planted them. And, if you will allow my stretching the simile to its furthest limits, they make our vibrant industry look like a flower shop.

An old joke goes that the chief executive of a large tech company gives a speech in which he asserts that, had cars been developed like software, they would cost a hundredth of what they do now and run twice as far on a litre. "Yes", an automotive exec replies later, "and they would crash once a week and when you call for service, they'd tell you to reinstall the engine."

Software is great: it does amazing things. But software is also bad: it's bloated and full of bugs. It may not be as buggy as it was twenty years ago, and clearly it was never buggy enough for people not to use it, but it's bad enough even so. You can easily confirm this yourself by searching a news aggregator for "software bug" or "software glitch" and finding, as I now find from the past week alone, articles about [150,000 arrest records disappearing in the UK](https://www.computing.co.uk/news/4025865/software-errors-wipes-thousands-arrest-records-police-databases), [56,000 defective cars being recalled](https://www.reuters.com/article/volkswagen-software/volkswagen-recalls-56000-golf-models-for-software-update-idUSL8N2JN2HL), [interruptions in the Indian vaccination drive](https://indianexpress.com/article/cities/mumbai/maharashtra-covid-19-vaccine-drive-tribal-rural-areas-challanges-7149270/) and so on.

Or to borrow someone else's words:

> I think it’s highly embarrassing for this profession that “program crashes/hangs/malfunctions” is such a common occurrence that 5 billion non-developers are not only acutely aware of it, but consider it an unsurprising state of things.
>
> It’s as if large parts of humankind were familiar with civil engineering jargon because collapsing bridges were a daily occurrence.[^3]

What, then, to do? In general, you can get better at not writing bugs (1) by practicing writing code, (2) by changing the conditions that make them more likely and (3) by figuring out which sorts of behaviours can prevent them. Here I want to discuss that last one: how should we write code so as to reduce the risk of introducing bugs? That means I won't discuss tooling, learning, project management or anything of that sort: I will limit my discussion to the activity of programming and will consider this in the context of software that is running in production systems, serving thousands or more users and for which defects can have serious adverse consequences.

## Consider Not Writing the Code in the First Place

Wayne Gretzky said that you miss 100% of the shots you don't take. I say that you have 0% chance of introducing bugs in code you don't write.

If your software is not written yet, you will obviously need to write code. Or change may be necessary: you may be in a business where competition drives you to always come up with new ways of adding value, or maybe your software needs to adapt to changing external conditions. These are all good reasons to write code, but they are not all the reasons that we write code. [There's no reason to think that software needs to change forever.](https://drewdevault.com/2021/01/04/A-culture-of-stability-and-reliability.html) Many features are negotiable.

Two types of code changes are relevant here, I think. The first is a change needed to implement new features. The second is refactoring, that is changing code in order to better structure it without modifying its behaviour.

A code change that implements a new feature is additive and therefore makes the software more complex. It is harder to avoid writing bugs in complex software. It is also harder to diagnose and fix bugs in complex software. Therefore, additive code changes involve both a direct risk and an indirect risk of introducing new bugs. That should make us think twice as hard before introducing new features, but in fact it is usually taken for granted that new features are good for software. Rid yourself of that assumption. You or somebody else should, before implementing a new feature, ask yourselves the question: how much marginal value does this feature provide for the user?

Refactoring is praised everywhere. And I'm not here to say it isn't important; it is our finest weapon in the perpetual war against entropy. But every time you refactor something, there is a risk that you introduce a new bug.[^4] The risk can be reduced with robust testing, as we shall see below. But it will never go away completely.

You need to balance the need for refactoring against the need for reliability and stability. Ask yourself questions like, how long will the software be maintained? how important is reliability and stability to it? how much do you expect the intended change will improve the code? and so on. Think critically. We often start refactoring code not because it is in a particularly bad condition but because _we can and know how to do it_. But that is a mistake. We are making ourselves slaves to [the politician's syllogism](https://en.wikipedia.org/wiki/Politician%27s_syllogism), which, adapted somewhat, says: we must refactor things; I can refactor this thing; therefore, I must refactor this thing.

## If You Do Have to Make a Change, Make It As Small As Possible

The second maxim is a corollary of the first. It begins with the observation that, in practice, it can be tempting to make some changes that are not directly related to whatever it is you are doing at the time. For example, maybe you are fixing a bug but notice that the component or function you're looking at is very long and could, so you reason, be split up into several smaller, composable functions. That's an admirable aim. But it increases the risk of introducing a new bug, at least in the short term. If it happens, consider not making that additional change, or, if you do decide to go through with it, making the change separately from the fix. That is better because small, monadic changes are easier to test and easier to review.

I make an exception here for whenever you can actually meaningfully reduce complexity, such as by removing branches from a conditional expression. Another exception would be to refactor code as an initial step prior to making functional changes to a component, but that should be done in the spirit of the following maxim.

## If You Want to Refactor Something, Make Sure It’s Covered by Automated Tests

Imagine that you are a spy. You are breaking into somebody's apartment in order to find and take copies of some or other document. Being a good spy, it is important to you that that the owner of the apartment doesn't notice that you've been there. So before rummaging around, you take photos of every room in order that, once you have found and copied the document, you can restore the apartment to its original condition. The photos you have taken are an external check on whether you are leaving the room in the same condition that you found it in. It doesn't guarantee that nothing is out of place. But it increases the probability that there is no discernible change.

Refactoring something means changing its implementation internally without changing its behaviour externally. You can create an external check similar to the spy's photos when refactoring by making sure that the thing you are refactoring is covered by automated tests.[^5] That way you can be more confident that the changes you make are not affecting the behaviour. You could almost make them without thinking at all, which brings me to the final maxim ...

## When You Make a Change, Make Sure You Understand What You're Doing

Before personal desktops were able to compile code, it had to be compiled on mainframes which often had to be booked in advance.[^6] That meant that programmers had to check their code carefully before compiling it, so as not to risk, should the program fail to compile, having to wait again in order to redo it. These days, we get near-instant feedback, not only from our compilers but also from running and testing our code. This feedback loop has been shortened further by advances like hot reloading. This is great because it helps us to iterate quickly and work in a state of flow. But it also allows us to code without really thinking hard about what we are doing.

Exactly that happens to me now and again, usually when I'm lacking mental energy. Maybe I'm not considering all the possible inputs that a function can receive, or maybe I'm not thinking about all the possible branches in a conditional expression. I am confident that the thing I'm doing right now is correct. But I don't know whether it is messing something up elsewhere.

When this happens, there is a kind of hill to climb, a hill from which everything is visible in a clearer light. I know this, but still I don't always find it in myself to go there. This is pure weakness of the will. The hard thing is to notice it. Having noticed it, you can either put the task aside to do when you have more energy, or summon up the strength to do the thing properly.

It may help you to imagine that you are going to deploy your change to be tested by a grizzled old no-nonsense manual tester. If there's a bug in your code, this tester is going to find it. Manual testing is like the tort system: as when a person is injured by a product they can sue the manufacturer, causing manufacturers to worry about their products' safety, so the manual tester can file a report when they discover a bug, causing you to worry about your code's correctness. But you can worry without the punitive threat, too.

## Conclusion

What normally happens to bugs is that they are fixed and forgotten. When we discover them, we are interested in fixing them, not in understanding the reasons why they happened; and even if we are so interested, we only rarely remember the conditions of their origin anyway. But it doesn't have to be like that. The way out of this is obvious. To avoid error, we must study error.

Never let a good incident go to waste. Each bug is an invitation to learn. And so is every near-miss. You learn by analysing what went wrong, for instance through a root cause analysis. This is sometimes called a [post-mortem](https://www.pagerduty.com/resources/learn/incident-postmortem/). It needs to be a non-punitive, blame-free procedure. It needs to be in a sense forward-looking, not backward-looking. Having found the deeper problem, you improve the system by putting into place changes that prevent that problem from occurring again. Practice this and you will be rewarded twice over: first in learning how serious bugs happen, then in improving the system you're working on. Because they know the water best who have waded through it.

[^1]: Grayling, A. (2011). _The good book : a humanist Bible_. New York: Walker & Co.
[^2]: I adapted this joke from [Theodosius Dobzhansky](https://en.wikipedia.org/wiki/Theodosius_Dobzhansky#Final_illness_and_the_%22Light_of_Evolution%22).
[^3]: See [this comment](https://lobste.rs/s/fzvd1v/former_uber_engineer_s_disaster_story#c_sy3xu2) by a user named soc on a Lobsters post about software struggles in Uber.
[^4]: Ferreira, I., Fernandes, E., Cedrim, D., Uchôa, A., Bibiano, A. C., Garcia, A., Correia, J. L., Santos, F., Nunes, G., Barbosa, C., Fonseca, B., & de Mello, R. (2018, May 27). _The buggy side of code refactoring_. Proceedings of the 40th International Conference on Software Engineering: Companion Proceeedings. ICSE ’18: 40th International Conference on Software Engineering.
[^5]: If you are diligent about testing, the thing you are refactoring is likely to already be covered by automated tests. If not, you will need to write them. But if you're refactoring a thing, it's likely to be working correctly already. So if you write automated tests for it and those tests pass, you can be fairly confident that the tests make sense. I suspect one reason that people find it hard to consistently practice test-driven development is that it is often easier to write tests for fully implemented functions and components than for skeletal interfaces.
[^6]: Well, so I gather, anyway. I can't claim to have been around for that.
