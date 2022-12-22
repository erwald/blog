---
layout: layouts/post.njk
title: Impact above Replacement
date: 2022-11-30
tags: post
---

# Impact above Replacement

![img]({{ '/img/twins.jpeg' | url }})

## Summary

There are at least four ways of thinking about [replaceability](https://forum.effectivealtruism.org/topics/replaceability):

1. **The naive view**, where your impact is the value you produced using some amount of resources.
2. **The single comparison view**, where your impact is the value you produced using some amount of resources, minus the value someone else would've produced using those resources had you not done so.
3. **The replacement view**, where your impact is the value you produced using some amount of resources, minus the value the "replacement-level person" of that reference group would've produced using those resources. The replacement-level person is the person who's only barely talented enough to enter a field.
4. **The God view**, where your impact is the total utility in the world where you do the thing, minus the total utility in the world where you don't do the thing. I assume for the purposes of this post that this is the normatively correct view, in order to have a benchmark.

Key takeaways:

- **The replacement view _may_ avoid some practical failure modes of the naive and single comparison views.**
  - I'm sure the naive and single comparison views are wrong, but I'm less sure whether that makes a large difference for people's decisions in practice. I assign 20% credence to the claim "the naive and single comparison views lead people to take avoidably and substantially wrong career decisions ≥10% of the time".
- **_Maybe_ we should consider adopting the replacement view.**
  - I’m pretty sure the replacement view is more accurate than the naive and single comparison views, but I’m less sure whether it’d improve people’s decisions in practice. I assign 15% credence to the claim "people aiming to do good with their careers would have noticeably more impact were they to use the replacement view".
  - That said, **there are complicated effects to account for that are beyond the scope of the replacement view**, e.g. supply and demand elasticities and lag times for changes to percolate through a system.
- The evidence in this post comes mainly from, in decreasing order of importance, (i) me reasoning about the problem, (ii) me doing some Monte Carlo simulations and (iii) somewhat analogous methods being used in sports.
  - The Monte Carlo simulations test how often views (1), (2) and (3) lead to the same career choice as view (4) under four idealised scenarios.
    - The naive and single comparison views do badly under some scenarios, but the replacement view does well under all scenarios.
    - The simulations make a lot of assumptions (see the Appendix for more) in order to more easily model the problem, and so should be taken with a grain of salt.

## What Replaceability Is

You want to do some good in the world. But to do good you need resources, and some of those will be in limited supply. If you use scarce resources, that means someone else won't. Now they can't do as much good as they could've. So how should you decide which scarce resources to use, or whether to use them at all?

Replaceability is a partial answer to this. Replaceability is usually taken to mean something like "the extent to which someone else would do what you'd do in a job if you don't take the job". I interpret it more generally, as "the extent to which other people would've produced similar value with a scarce resource had you not used it".[^1]

The paradigmatic example is choosing a career: if you're thinking of becoming a doctor to save hundreds of lives, you should perhaps keep in mind that [someone else might've saved those lives](https://80000hours.org/2012/09/how-many-lives-does-a-doctor-save-part-3-replacement-84/) had you chosen a different career. If so, the doctor profession is highly replaceable. But this is just one of many situations where replaceability may be a factor:

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">

<colgroup>
<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">Decision</th>
<th scope="col" class="org-left">Scarce resource</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-left">Choosing a job</td>
<td class="org-left">Salary, opportunities for direct impact and support from employer and colleagues</td>
</tr>

<tr>
<td class="org-left">Asking someone to be a mentor</td>
<td class="org-left">Mentor's time and energy</td>
</tr>

<tr>
<td class="org-left">Applying for a grant</td>
<td class="org-left">Grant, grantmaker's time and grantmaker's connections</td>
</tr>

<tr>
<td class="org-left">Marketing a resource to the community</td>
<td class="org-left">Prestige and community attention</td>
</tr>
</tbody>
</table>

## Four Views on Impact

We can look at impact in at least four different ways:

1. **The naive view.** Your impact is the value you produced directly and indirectly using some amount of resources.
   - This view, which I think is common outside effective altruism, is incorrect because it fails to consider the counterfactual.
2. **The single comparison view.** Your impact is the value you produced directly and indirectly using some amount of resources, minus the value someone else would've produced using those same resources had you not done so.
   - This view, which I think is common within effective altruism, is incorrect because it fails to consider trickle-down effects. That is, the person who replaces you would've been replaced by someone less able, who in turn would've been replaced by someone less able, and so on. Each of these steps may involve an additional loss of impact.
3. **The replacement view.** Your impact is the value you produced directly and indirectly using some amount of resources, minus the value the "replacement-level person" of that reference group would've produced using those same resources.
   - This is an effective altruist variant of what sabermetricians call [Wins Above Replacement](https://en.wikipedia.org/wiki/Wins_Above_Replacement), a stat that aims to measure how many more wins a baseball player contributes to a team than the replacement-level player. The replacement-level player is the substitute who would've been called up to join the team had the player being measured not participated.
   - The replacement view seems confused, at least as a parallel to sports, because in sports it's designed to compare people, not actions.
   - Benjamin Todd [proposes something similar](https://80000hours.org/articles/coordination/#problems-with-a-simple-single-player-approach-and-the-value-of-freed-up-resources): that your impact is the value you produce, minus the value someone else would've produced in your position, plus the value of any additionally freed-up resources. But it seems hard to me to estimate the value of those freed-up resources -- it feels like punting.
4. **The God view.** Your impact is the value produced by everyone (including you) in the world where you use some amount of resources, minus the value that would've been produced by everyone in the world where you didn't use those resources. (Because God is omniscient.)
   - This view is perhaps normatively correct but requires perfect information and computing power.

Benjamin Todd, [Paul Christiano](https://rationalaltruist.com/2013/01/22/replaceability/) and others have thought and written about replaceability, but I think it's fair to say no one has reached any definitive conclusion: it's a hard problem. Todd [recommends focusing on other, more robustly predictable factors](https://80000hours.org/podcast/episodes/ben-todd-on-what-effective-altruism-most-needs/#replaceability-005327), like [personal fit](https://80000hours.org/articles/personal-fit/) and [scale](https://forum.effectivealtruism.org/topics/importance) and [solvability](https://forum.effectivealtruism.org/topics/tractability), when choosing a career. In fact, there's been remarkably little discussion about replaceability in the past few years, I think partly because people have realised that replaceability differs less across career options than those other things (personal fit, etc.), and partly because people have tactically retreated from a difficult problem.

I _think_ this is somewhat unfortunate, as replaceability seems to me to be decision-relevant and somewhat tractable, even if not as important as the problems Todd and Christiano have moved on to.

## Why Does Replaceability Matter?

There are ~1M licensed physicians in the US alone, which is ~2 orders of magnitude more than the number of effective altruists globally. I'd expect there to be a difference of ≥1 order of magnitude in the number of people working on different problems within effective altruism too. If the number of people working in a field affects replaceability in a way that matters when estimating counterfactual impact, it seems important to know how it matters.

To imagine a rather extreme scenario, I think it's easy for someone who's choosing between two jobs, one in a field with lots of people and one that basically only they can do, to have heard of replaceability and think, "Though this thing that only I can do seems less important than this thing that many other people are doing, if I don't work on the thing that many people are doing, someone else nearly as good as me would take my place, so instead I should work on this thing that only I can do." But if something like the replacement view is a better representation of the truth than the single comparison view, this person may be making a grievous error!

Sports seems somewhat analogous here. Sports teams are also making decisions about how to allocate scarce resources (e.g. playing time), and they do so by explicitly considering replaceability. (It's easier for them; they have good measures of how teams and players perform.)

For example, suppose a hockey team is deciding whether to sign a star left winger or equally talented star right winger. Suppose currently its top left winger is near star calibre, whereas its top right winger is middling. Suppose its _worst_ left winger is so bad as to be a liability, whereas its worst right winger is pretty good. If the team only compared each potential addition to the player whose spot they'd take, they'd go with the star right winger (who's much better than the currently best right winger on the team, who's middling). But it may be better for the team to sign the star left winger (to get rid of the marginal left winger, who's a liability).[^2]

I think it's currently unclear how we are looking or should look at replaceability. My impression is that the single comparison view was circulated once long ago and that, ever since [its flaws became apparent](https://80000hours.org/2015/07/replaceability-isnt-as-important-as-you-might-think-or-weve-suggested/), there's been something of a vacuum. With what do people fill this vacuum? I have no idea. But we make decisions, so it must be something.

## Simulations

I've run Monte Carlo simulations with the aim of seeing how these views perform in four simple, idealised scenarios. The scenarios pit two fields (as in, spheres of activity) against each other. (For more on how the simulations were run, see the Appendix.) The percentages signify how often you'd choose Field A if you took a given view:

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">

<colgroup>
<col  class="org-right" />

<col  class="org-left" />

<col  class="org-left" />

<col  class="org-right" />

<col  class="org-right" />

<col  class="org-right" />

<col  class="org-right" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-right">#</th>
<th scope="col" class="org-left">Field A</th>
<th scope="col" class="org-left">Field B</th>
<th scope="col" class="org-right">Naive</th>
<th scope="col" class="org-right">Single Comparison</th>
<th scope="col" class="org-right">Replacement</th>
<th scope="col" class="org-right">God</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-right">1</td>
<td class="org-left">1K ppl (medium talent), 100 jobs</td>
<td class="org-left">1K ppl (medium talent), 100 jobs</td>
<td class="org-right">49.9%</td>
<td class="org-right">50.7%</td>
<td class="org-right">50.0%</td>
<td class="org-right">50.1%</td>
</tr>

<tr>
<td class="org-right">2</td>
<td class="org-left">1K ppl (high talent), 100 jobs</td>
<td class="org-left">1K ppl (medium talent), 100 jobs</td>
<td class="org-right">69.6%</td>
<td class="org-right">62.3%</td>
<td class="org-right">61.8%</td>
<td class="org-right">62.4%</td>
</tr>

<tr>
<td class="org-right">3</td>
<td class="org-left">1K ppl (medium talent), 100 jobs</td>
<td class="org-left">100 ppl (medium talent), 10 jobs</td>
<td class="org-right">50.7%</td>
<td class="org-right">26.0%</td>
<td class="org-right">53.4%</td>
<td class="org-right">49.4%</td>
</tr>

<tr>
<td class="org-right">4</td>
<td class="org-left">1K ppl (medium talent), 100 jobs</td>
<td class="org-left">200 ppl (medium talent), 100 jobs</td>
<td class="org-right">67.9%</td>
<td class="org-right">55.8%</td>
<td class="org-right">56.2%</td>
<td class="org-right">56.5%</td>
</tr>
</tbody>
</table>

I interpret the results thusly:

1. The fields are identical so the decision is a toss-up. Indeed, all four views choose Field A ~50% of the time.
2. Field A has more talented people than Field B so we should pick it more often. That's because you're drawn randomly from each field's talent pool, so you'll usually end up being more talented in Field A than in Field B.
   - Most views capture this pretty well (using the God view as our ground truth), ending up at 62%.
     - But the naive view is kind of off at 70%. It's too optimistic about higher-talent fields when jobs are scarce. I think that's because it ignores trickle-down effects. This doesn't matter when everyone has a job -- in that case, the naive view is nearly identical to the replacement view. But when jobs are scarce there's a difference between these, and the difference grows as the overall talent of the field grows.
3. People are equally talented in both fields, but Field B has 10% as many people and jobs as Field A.
   - This is also a toss-up. The naive (51%) and replacement (53%) views do well here with the God view (49%) as ground truth.
     - But the single comparison view does poorly (26%). It's too optimistic about fields with fewer people since the distance to the next most talented person will tend to be larger there. But this distance doesn't matter much if there's a trickle-down effect.
4. People are equally talented in both fields, but Field B has fewer people relative to its number of jobs (2x) than does Field A (10x).
   - This isn't a toss-up -- we should choose Field A 57% of the time. That's because we stipulated that you're always in a position to choose between the two fields, meaning, because there are fewer people for each job in Field B, a randomly chosen person who gets a job there is less talented than a randomly chosen person who gets a job in Field A (which is more competitive). So we'll tend to pick Field A more.
     - The single comparison (56%) and replacement (56%) views do well here.
       - But the naive view does poorly (68%). It's too pessimistic about fields where there's less competition in the labour market, though I'm not sure why.

Like any model, this one rests on a number of simplifying assumptions. None of these results are guaranteed to hold outside the model's world. Still ...

## The Replacement View Seems Useful, Maybe

Though I don't feel sure enough to actually make recommendations to people faced with career decisions, **I'm tentatively bullish on the replacement view**. Arguments for:

- **There may be serious failure modes for both the naive and single comparison views.**
  - If we trust the simulations, the naive view seems too bullish on fields with better candidates, and also too bearish on fields with less competition on the labour market. The single comparison view is too bullish on fields with fewer people and jobs (even if the people-to-jobs ratio is constant).
  - If we don't trust the simulations, there still seem to be intuitive issues like not considering counterfactuals at all (the naive view) and not considering trickle-down effects (the single comparison view).
  - I don't know of any practical alternatives to these views. I have come across considerations that seem important and have to do with replaceability, but no action-guiding frameworks or theories.
- **These same failure modes may not affect the replacement view.** The replacement view does well in the simulations, though I wouldn't put too much weight on that. It also just takes into account counterfactuals as well as trickle-down effects, which seems good.
- **It seems workable.** I think people often have a pretty good idea of what the replacement-level person in their field looks like, either from studying with people who wouldn't or who would only barely break into the field, or from working with them, or from seeing the things they produce. If one hasn't worked or studied in a field, one can still get a pretty good impression by talking with people in the field, or reading about it, or, again, seeing the things people in the field produce.

Arguments against:

- **It seems unworkable.** It's unclear which reference group to use when locating the replacement-level person. Say you're a wild animal welfare researcher. Is the correct reference group all wild animal welfare researchers? Is it all animal welfare researchers? Is it all impact-focused animal welfare researchers? Is it impact-focused people period? Or something else?
- **It seems conceptually confused.** I don't have a mathematical proof for the replacement view. It isn't, as far as I know, solidly grounded in economic or moral theory.
  - In sports, stats like Wins Above Replacement are used to compare the impact of people, not the impact of actions. (Choosing which player to sign is an action, but I'm not sure whether the assumptions hold if you look at it that way.) That makes me suspicious of simply transposing it over to career decisions.
- **Maybe thinking about replaceability is getting too in the weeds when we still haven't figured out more important considerations.** It seems likely to me that factors like how pressing a problem is, career capital and so on are substantially more important than replaceability. Maybe those factors swamp replaceability, such that it's basically not worth thinking about when you could instead be thinking about those other things?
- **Maybe replaceability is subsumed by personal fit.** If personal fit is the distance between a candidate and the average candidate, it's analogous to the replacement view, which is the distance between a candidate and the replacement-level candidate. These measures should correlate. I think the way they differ depends on how talent is distributed.
  - They both help you predict how much effort you add to a problem.[^3] (They don't say anything about scale or solvability.) So maybe we only need one of them.
    - However, when I ran the same simulations with a "personal fit view", it picked the wrong thing ≥30% of runs in scenario (2) and ≥17% of runs in scenario (4). Maybe the right framing is something like "we should start thinking of personal fit as not comparing ourselves to the average, but comparing ourselves to the replacement level"?
- My simulation code may be buggy.

Replaceability is also more complicated than this post makes it out to be. For example, in the real world:

- **It can take time for changes to percolate down**, unlike in sports where an empty position must be filled immediately. A company may not immediately find a replacement, if it does at all.
  - Perhaps the model could include a probability P that some person will take a job had one not taken it, as Benjamin Todd does [here](https://80000hours.org/articles/coordination/#problems-with-a-simple-single-player-approach-and-the-value-of-freed-up-resources). This probability would depend on how many candidates there are, how talented they are, how broadly openings are advertised and so on. These factors surely differ from field to field.
- **Employers don't always hire the best candidates.** However, I expect them to choose the better candidate more often than not, so maybe it's correct to say that they hire the best candidates in expectation.
- **People don't always know what they're a good fit for.** That means one may end up displacing someone into a career where they end up doing much _more_ good. But again, I expect people to have a pretty clear picture most of the time of how good they'd be at a thing.
- **Talent may not be lognormally distributed.** I'm pretty sure it follows a heavy-tailed distribution (that seems to be the case in [hockey](https://evolving-hockey.com/blog/wins-above-replacement-replacement-level-decisions-results-and-final-remarks-part-3/), [baseball](https://www.beyondtheboxscore.com/2012/5/23/3038977/wins-above-replacement-distribution-and-rarity-of-talent-2011), [programming](http://blog.webfoot.com/2008/11/03/programmer-productivity-update/) and [labour in the UK](https://www.ons.gov.uk/economy/economicoutputandproductivity/productivitymeasures/articles/labourproductivitymeasuresfromtheannualbusinesssurvey/2006to2015#results)[^4]), but it's not clear to me which one, and this may make a difference.
- **Choosing to use a scarce resource [may increase or decrease the supply of that resource](https://80000hours.org/podcast/episodes/ben-todd-on-what-effective-altruism-most-needs/#replaceability-005327)** (on top of the amount one used), and the degree to which this happens can vary from field to field. For example, if more people try to be doctors, hospitals can pay them lower salaries, meaning they have more money to spend (assuming the labour market for doctors has non-zero supply and demand elasticities).

The problem that replaceability is meant to address is a pretty rare one. There doesn't seem to be much research on it. There aren't that many situations where people (1) pursue the same goal[^5], (2) don't usually coordinate, (3) use shared scarce resources with substantial supply and demand and (4) are able to use those resources to varying degrees of efficiency. But effective altruists are in this rare situation.

## Appendix: Monte Carlo Simulations

Here is the procedure I used to simulate career choices based on the four replaceability views:

1. For two different fields, Field A and Field B, generate N people with different Talent Levels, and M jobs with different "Effort Multipliers".[^6] Assume these are [lognormally distributed](https://en.wikipedia.org/wiki/Log-normal_distribution).[^7]
   - Effort Multipliers represent the fact that some jobs allow a person to get more work done towards solving a problem than other jobs, e.g. by providing more opportunities or better support.
   - We can describe the effort added by a person working a job with the formula Effort = Talent Level × Effort Multiplier. So the total effort of people working on a problem (corresponding to the God view) is given by the sum of Talent Level × Effort Multiplier for all person-job pairs in both fields. (We assume people who don't get a job produce zero effort.)
2. For each field, assign the most talented people to the jobs with the highest Effort Multipliers, one at a time, until there are no more available jobs (or people).
3. Select a person at random from each field, excluding those people who didn't get a job.[^8] This is you and your talent at each thing. You're now going to decide which field to work in.
4. For each of the four views, calculate the value of choosing Field A, and the value of choosing Field B.
   - We get a person's naive effort in a field by multiplying their Talent Level in that field by the Effort Multiplier of the job they'd get, i.e. Your Effort = Your Talent Level × Your Effort Multiplier.
   - Your effort in each field according to the naive view is simply Your Effort.
   - Your effort in each field according to the single comparison view is Your Effort - The Person Who'd Replace You's Effort.
   - Your effort in each field according to the replacement view is Your Effort - The Replacement-Level Person's Effort. Remember, the replacement-level person is the person who'd barely get a job in the field.
5. Repeat steps (1) to (4) 10,000 times for each scenario.
6. Estimate P(choose Field A) for each of the views.

## References

<style>.csl-entry{text-indent: -2em; margin-left: 2em;}</style><div class="csl-bib-body">
  <div class="csl-entry">Page, Scott E. 2018. <i>The Model Thinker: What You Need to Know to Make Data Work for You</i>. Basic Books.</div>
  <div class="csl-entry">Pearl, Judea, Madelyn Glymour, and Nicholas P Jewell. 2016. <i>Causal Inference in Statistics: A Primer</i>. John Wiley & Sons.</div>
</div>

[^1]: Replaceability is different from counterfactuals. Pearl, Glymour, and Jewell (2016) describes a counterfactual as "an 'if' statement in which the 'if' portion is untrue or unrealized". This involves tallying up _all the ways_ a thing would've gone differently. Replaceability is a special kind of counterfactual reasoning, dealing only with the use (or non-use) of a scarce resource.
[^2]: True, ice time makes this a more subtle calculation. Signing the star left winger means the near-star-calibre left winger gets pushed down to the second line, meaning their (considerable) impact is reduced. But I think it serves as an example of these kinds of considerations mattering in practice.
[^3]:
    I frame it as "how much effort you add", not "how much impact you have", because impact also depends on other things, in particular the problem areas' relative [scale](https://forum.effectivealtruism.org/topics/importance) (defined, [after 80,000 Hours](https://80000hours.org/articles/problem-framework/#top), as Good Done ÷ % of Problem Solved) and [solvability](https://forum.effectivealtruism.org/topics/tractability) (% of Problem Solved ÷ % Increase in Effort). Focusing on effort alone is cleaner as we can bracket those other concepts. As far as this post is concerned, all problems have the same scale and solvability.

    NB. "Increase in Effort" is called by 80,000 Hours "Increase in Resources", but since I'm already using the word "resource" to refer to labour, time and money, I'm calling it "Increase in Effort" instead.

[^4]:
    Some posts, like [this one](https://80000hours.org/2019/08/how-replaceable-are-top-candidates-in-large-hiring-rounds/#some-possible-distributions-of-job-performance), point to income and researcher citation count as evidence of this (emphasis mine): "**If job performance is like income, or the number of citations people have on academic papers, it is more like a log normal distribution[.]** That is, most aspiring academics have few citations, while some have thousands, tens of thousands, or even hundreds of thousands. [...] We're very unsure about this question, and would like to see more research into it. Some evidence we've seen suggests that output is normally distributed even in 'complex' jobs, like being a doctor. However, for the most difficult and creative work, like academic research, we suspect that the variance is high in the tails. Even there, it's hard to be confident since **many measures of output (such as citation count) are likely to overstate differences in productivity**."

    As alluded to in the quoted passage, I think income and citation count aren't good evidence. Even if talent is normally distributed (i.e. follows a bell curve), salary and citations could well have heavy tails due to nonlinear effects later in the causal chain. The [Matthew effect](https://en.wikipedia.org/wiki/Matthew_effect) -- where having an advantage gets you further advantages -- applies here too, as well-cited papers are more likely to get further citations independently of quality, and richer people are more likely to get more money regardless of talent.

[^5]: Benjamin Todd calls this a ["shared aim community"](https://80000hours.org/articles/coordination/#shared-aim-communities-and-trade-plus).
[^6]: This model implicitly takes neglectedness and personal fit into account -- neglectedness (and importance) is captured by a job's impact level, and personal fit is captured by a person's talent level.
[^7]:
    Page (2018) writes: "In some cases, we may know the mean of the distribution and also know that all values must be positive. Given those constraints, the maximal entropy distribution must have a long tail, and as we spread the distribution across more values, we must balance high values with many low-value outcomes."

    I don't know the means of these talent distributions, but it does seem likely to me that (a) that talent can't be negative and (b) the distance between the average talent and zero talent is smaller than the distance between the average talent and the greatest talent. That seems like a pretty good justification for a heavy-tailed distribution.

[^8]: Note that this means that, if the number of people exceeds the number of jobs, you'll tend to have an above average talent level. If there are 10x as many people as jobs, for example, you're randomly selected from the 90th percentile.
