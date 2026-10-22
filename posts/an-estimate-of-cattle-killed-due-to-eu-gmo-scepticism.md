---
layout: layouts/post.njk
title: An Estimate of Cattle Killed due to EU GMO Skepticism
date: 2022-05-07
tags: post
---

# An Estimate of Cattle Killed due to EU GMO Skepticism

![img]({{ '/img/hero/cattle.png' | url }})

<div class="edit">
<p>
Correction 2026-10-18: In the original version of this post, I misread Beyond Meat’s sales figures, thinking they were reported in pounds rather than <a href="https://www.sec.gov/Archives/edgar/data/1655210/000165521022000019/bynd-20211231.htm">thousands of pounds</a>. This egregious error caused my estimate of the cattle affected to be 1,000 times too small. However, I have also improved the back-of-the-envelope calculation in a few ways, causing a (smaller) downward revision. The net effect is that my new estimate is about 61 times larger, with a median of about 1,100 cattle rather than 18 cattle. Therefore, my previous conclusion that the number of extra deaths is “less than I would have guessed, which only goes to show how off my original intuition was” was only half right, as the number is somewhat fewer than I would have guessed, but my original intuition was pretty reasonable.
</p>

<p>
In 2024, EFSA’s GMO panel gave soy leghemoglobin a positive safety opinion (EFSA GMO Panel 2024), after its food additives panel had done the same (EFSA FAF Panel 2024). But it still <a href="https://agfundernews.com/impossible-makes-uk-retail-debut-at-tesco-without-its-flagship-heme-protein">hasn’t received final approval</a>; although some Impossible Foods products went on sale in the Netherlands and the UK this year, they are made without soy leghemoglobin. According to Claude Opus 5.5, revising and extending my estimates to October 2026, about 4,800 (90% CI: 500 to 47,000) cattle have so far died as a result of EU GMO regulation. This is sad and infuriating.
</p>

</div>

## Summary

Impossible Foods has not been able to put its product on the European market because it contains a genetically modified organism (GMO); the European Food Safety Authority (EFSA) is hesitant to approve GMO products for human consumption. **I estimate, with a rough back-of-the-envelope calculation, this delay to have caused the deaths of something like 1,100 cattle so far, and to cause the deaths of maybe 710 to 17M cattle (that's my 90% confidence interval) in total.**

## Background

To make beef, you need to grow cattle.[^1] Most cattle in the developed world are raised in factory farms.[^2] As far as factory farmed animals go, beef cattle probably have it the best. But they have it bad enough. For example, in the US and elsewhere they are often branded with hot iron. Once they have reached maturity, they're usually taken to crowded feedlots where they are fattened. After that follow long and stressful transports during which it's not uncommon to see animals die or become "downed" (unable to walk or stand). Then, of course, there's the horror of the slaughterhouse and the actual killing.

So in my view it would be good if people ate less meat, beef included. One way of doing that is by replacing meat consumption with good plant-based alternatives. In Europe, for example, we've had the Beyond Burger for a few years now. It's a fine product. I eat it regularly. But from what I hear, there's an even better plant-based burger out there: the Impossible Burger. I say *hear* because I haven't yet had the chance to taste it: the Impossible Burger is unfortunately stuck awaiting EFSA's approval and therefore hasn't yet been introduced into the European market.

Flora Southey [reports](https://www.foodnavigator.com/Article/2022/04/14/Regulating-precision-fermentation-Challenges-and-opportunities-in-marketing-microbially-derived-foods-in-Europe/):

> The Impossible Burger first launched in 2016, having been approved [by the Food and Drug Administration]. In Europe, on the other hand, the company was required to submit a [GMO] dossier to the European Commission, because its soy leghemoglobin contains host proteins in the final product. This means, explained the regulatory expert, that the product is not "absolutely pure". Due to the presence of host DNA in the final product, it is classified as a GMO in the EU.
> 
> Impossible submitted its European dossier in 2019. It took around 18 months for the dossier to be validated, and then it was "immediately clock stopped", or paused. The European Food Safety Authority [contacted] Impossible to request more information. The dossier is still on pause. [...] EFSA has suggested the dossier will be taken off pause by the end of 2022, but there are no guarantees. More "clock-stops" can be issued and EFSA's deadline to complete its risk assessment, pushed back.

In other words, Impossible Foods use a yeast engineered with soy DNA to produce heme, which simulates the bloodiness of animal meat. That means the Impossible Burger contains a genetically modified organism, which is why EFSA is taking its sweet time approving it. (The next deadline for EFSA is apparently [in October](https://open.efsa.europa.eu/questions/EFSA-Q-2019-00651).) The "problem" is that, generally speaking, GMOs are very safe. They are no less natural than the modern corn, carrot, and zucchini that we all eat. I am confident that the Impossible Burger is as safe to consume as any burger patty. It also seems to me that other risks associated with GMOs are either non-existent or overblown. (See [Marius Hobbhahn's post](https://www.mariushobbhahn.com/2022-01-20-genetic_enhancements/) for more on GMOs.) This makes EFSA's dilly-dallying extremely frustrating to read about -- don't they realize that *real animal lives* are at stake here?

Every time I was reminded of this in the past couple of years, a palm went for my face. And I'd wonder, how many cattle have died because of European prudence?

## Estimate

Here's a very rough back-of-the-envelope calculation. Suppose Impossible Foods, like Beyond Meat, had been free to sell in Europe without EU approval and had launched in early 2020, reaching full volume a year later (that is, in January 2021). Suppose furthermore that:

- Impossible Foods would have added a net volume of plant-based meat equal to 35% (90% CI: 8% to 150%) of Beyond Meat's volume.[^3] Beyond Meat sold 19,474,000 kg of products outside the US in 2020 and 2021.[^4] If we adjust that to account for Impossible Foods likely needing some time to reach its full volume, we get about 16M kg, so Impossible Foods would have added a net 0.35 × 16M kg outside the US in those years.[^5]
- 55% (90% CI: 40% to 75%) of its international volume was from the EU (including the UK[^6]).
- 70% (90% CI: 55% to 90%) of its EU volume was in the sale of flagship products (ground beef).
- Each kg of plant-based meat displaces 0.2 kg (90% CI: 0.04 to 1 kg) of beef.[^7]
- Each kg less beef eaten means 0.6 kg (90% CI: 0.35 to 1 kg) less beef produced (since lower prices might make others eat a bit more).[^8]
- One head of cattle yields somewhere between 200 and 260 kg of beef -- let's say 230 kg.

Under these assumptions, GMO regulation increased beef consumption by 16M kg × 0.35 × 0.55 × 0.7 × 0.2 = 430,000 kg, and beef production by 430,000 kg × 0.6 = 260,000 kg. That means it caused the deaths of about 1,100 cattle (90% CI: 110 to 11,000), very roughly.[^9] For comparison, in 2016 alone, over 300M cattle were slaughtered worldwide.[^10] That would suggest the regulations are responsible for 1,100 ÷ 2 ÷ 300M = 0.00018% of cattle deaths yearly so far.

I don't know about you, but that is somewhat fewer than I would have guessed. 1,100 heads of cattle is not nothing, however. (And to each of those 1,100 cattle it is everything.) That said, here are some reasons to think the actual impact might be larger still:

- The estimate is only of direct effects on consumption, but there are likely significant indirect effects too, e.g. somebody having a great experience with the Impossible Burger, persuading them to reduce their meat intake more broadly/permanently (or even go vegetarian or vegan). (This is probably not a huge effect since it's likely very rare, maybe a factor of 2 or less?)
- The Impossible Burger seems to be somewhat higher quality than the Beyond Burger and other alternatives, so it might have generated more buzz or created a more positive impression of plant-based meat had it been available. (This also seems like a small effect.)
- The delay might have discouraged other plant-based meat companies from using GMOs in the future. That might be a significant loss in the medium-term because GMOs open up a lot of possibilities for new plant-based protein products. (This seems like a potentially large effect?)
- This estimate is only for 2020 and 2021. It seems unlikely that Impossible Foods gets approval any time soon, meaning they (and I) could still have years of waiting ahead of us. More importantly, these companies are still in the early stages of their existence. A delay for Impossible Foods doesn't just mean it can't sell anything now -- it also means it will sell less than it otherwise would have once it *has* approval, because it will need to ramp up production, establish distribution channels, market its products, and so on. Scaling up takes time, and a delay can have long-lasting effects or even kill a business before it gets off the ground. (Depending on how long it would take to catch up to the counterfactual, and on how much volume is moved once it has, I think this could cause the number of cattle killed to be one or two orders of magnitude larger. If my math is correct, that should be roughly the equivalent of a timeline delayed by five years, so to 2025, alongside an eventual yearly reduction in beef consumption 4-40 times that of the current yearly estimate, so 860,000 kg to 8,600,000 kg per year at its height.)

I'm obviously really uncertain about all this, but if I were to venture a guess, I'd say that these considerations could increase the number of dead cattle (compared to the scenario where Impossible Foods could have launched in Europe in 2020) by up to about four orders of magnitude. Combined with the uncertainty in the estimate above, that gives something like 710 to 17M. And so I can only conclude that yes, EFSA's delay is an unforced error, though who knows of what magnitude.

## References

<style>.csl-entry{text-indent: -2em; margin-left: 2em;}</style><div class="csl-bib-body">
  <div class="csl-entry">Chenarides, Lauren, Joel Cuffey, Wenying Li, Shuoli Zhao, and Brianna Adamo. 2024. “Consumer Spending on Plant-Based Meat Alternatives.” <i>Choices</i>. <a href="https://choicesmagazine.org/choices-magazine/submitted-articles/consumer-spending-on-plant-based-meat-alternatives">https://choicesmagazine.org/choices-magazine/submitted-articles/consumer-spending-on-plant-based-meat-alternatives</a>.</div>
  <div class="csl-entry">EFSA FAF Panel. 2024. “Safety of Soy Leghemoglobin from Genetically Modified Komagataella phaffii as a Food Additive.” <i>EFSA Journal</i> 22 (6): e8822. https://doi.org/10.2903/j.efsa.2024.8822</div>
  <div class="csl-entry">EFSA GMO Panel. 2024. “Assessment of Soy Leghemoglobin Produced from Genetically Modified Komagataella phaffii, under Regulation (EC) No 1829/2003 (Application EFSA-GMO-NL-2019-162).” <i>EFSA Journal</i> 22 (11): e9060. https://doi.org/10.2903/j.efsa.2024.9060</div>
  <div class="csl-entry">MacAskill, William. 2015. <i>Doing Good Better: How Effective Altruism Can Help You Make a Difference</i>. Gotham Books.</div>
  <div class="csl-entry">Neuhofer, Zachary T, and Jayson L Lusk. 2022. “Most Plant-Based Meat Alternative Buyers Also Buy Meat: An Analysis of Household Demographics, Habit Formation, and Buying Behavior among Meat Alternative Buyers.” <i>Scientific Reports</i> 12 (July): 13062. https://doi.org/10.1038/s41598-022-16996-5</div>
  <div class="csl-entry">Norwood, F Bailey, and Jayson L Lusk. 2011. <i>Compassion, by the Pound: The Economics of Farm Animal Welfare</i>. Oxford University Press.</div>
</div>

[^1]:	 This will change as cellular agriculture matures and scales up, but for now it is still true enough as a general statement.

[^2]:	 See e.g. [this article](https://sentientmedia.org/u-s-farmed-animals-live-on-factory-farms/) which says 70% of cows live on factory farms.

[^3]:	 That is, Impossible Foods would have sold about 70% of Beyond Meat's actual volume, but half of that would just have replaced other plant-based beef products. (In the US, Impossible Foods's growth after 2021 seems to have come mostly at the expense of other brands. In 2022, plant-based meat volumes [fell 5%](https://www.levervc.com/wp-content/uploads/2023/07/Beyond-the-Headlines-U.S.-Retail-Datasets-Indicate-a-Bright-Future-for-Plant-Based-Meat.pdf) while Impossible Foods's sales grew 50%.)

	This guesstimate seems reasonable to me, though it's really hard to know for sure. I'll note that Beyond Meat seems to have a [somewhat larger market share](https://frb.mydigitalpublication.com/january-february-2022/page-36) in the US than Impossible Foods. It's possible that the gap created by the Impossible Burger's absence in the EU has been almost entirely filled by the Beyond Burger and other plant-based competitors.

[^4]:	 From their [annual reports](https://investors.beyondmeat.com/financial-information/annual-reports), which give volume in thousands of pounds, I see [15,965 in 2020 and 26,968 in 2021](https://www.sec.gov/Archives/edgar/data/1655210/000165521022000019/bynd-20211231.htm) outside the US (including Canada), or 19,474,000 kg in all.

[^5]:	 I assume here that Impossible Foods's sales would've grown steadily from nothing in January 2020 to full volume in January 2021. That would average to 50% of its full volume in 2020 and 100% in 2021.

[^6]:	 The UK left the EU in January of 2020. I seem to recall reading somewhere that Impossible Foods initiated the process for selling its products in the UK last year, in 2021. That suggests (1) they are eager to start selling their products in the EU, but cannot due to GMO approval processes and (2) the UK (which kept the EU's GMO rules after Brexit) slowed them down too.

[^7]:	 My source here is [this article](https://cleantechnica.com/2020/09/20/impossible-burger-sales-replace-72-of-traditional-burger-sales/): "Chicago-based analytics company Numerator analyzed consumer buying habits of the Impossible Burger in the most recent 13-week period. [...] Impossible Burger is displacing animal-derived foods for 72% of total purchases." True, that number is expressed as a share of dollars (not of pounds or kilograms) and it covers all animal-derived foods (not just ground beef). From what I can tell, studies of household purchase data find little or no fall in meat purchases after households start buying plant-based meat (see e.g. Neuhofer and Lusk (2022) and Chenarides et al. (2024)), though they can't rule out a moderate effect. For these reasons, I use a much lower figure than 72%.

[^8]:	 Norwood and Lusk (2011) estimate 0.68 for beef, as cited by MacAskill (2015) (see [this excerpt](https://forum.effectivealtruism.org/posts/KAsnFWNdasSSTu9rP/excerpt-from-doing-good-better-how-vegetarianism-decreases)).

[^9]:	 I model each assumption that has a confidence interval as an independent lognormal distribution with that 90% interval (for the beef per head of cattle, 200 to 260 kg), and treat the launch date and ramp-up as fixed. Multiplying these distributions (I used [squigglepy](https://github.com/rethinkpriorities/squigglepy)) gives a median of about 1,100 cattle, with a 90% confidence interval of about 10 times either way.

[^10]:	 See [this Faunalytics article](https://faunalytics.org/global-cow-slaughter-statistics-and-charts/).
