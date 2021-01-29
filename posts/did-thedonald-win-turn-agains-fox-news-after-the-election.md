---
layout: layouts/base.njk
title: Did thedonald.win Turn against Fox News after the Election?
date: 2020-12-12
tags: post
---

# Did thedonald.win Turn against Fox News after the Election?

It must take a special kind of self-restraint for American liberals not to revel in the MAGA faction's apparent mutiny against Fox News, perhaps for the same reason that the neocon mutiny against Trump was a kind of heroin for them. There's nothing better than a divided enemy. And there's no tranquilliser more powerful than the confirmation of those on the other side.

To drink this potent elixir you're best off going to the source, which in the case of MAGA has to be [thedonald.win](https://thedonald.win/). I'll happily admit to have started checking in on the reluctant orchestra myself at intervals since Election Day. It's all kind of fascinating & probably not a worse way of spending one's time than watching some or another Netflix show or whatever. You can't have spent any time there recently & not have noticed that these people hate Fox News. But when did that begin? Did it start around 11:20 p.m. on election night when Fox called Arizona?[^1] That question came up recently & I wanted to answer it quantitatively.

## Methodology

I started by scraping all the snapshots of the `/top` page that were available on [the Internet Archive](https://web.archive.org/web/*/https://thedonald.win/top) from September 1st to November 21st (the day of my programming this). That meant opening each visible post in each snapshot & scraping all of the visible comments in that post. This gave me 730k comments which was whittled down to 66k after removing empties & combining duplicates (always taking upvote & downvote amounts from the latest observation).

I considered a comment to be about Fox News simply if it contained the word "fox" or "faux". I also wanted to look at Fox's two little siblings & so did the same for One America News Network ("oann" or "one america news") & Newsmax ("newsmax"). But I only considered comments that contained exactly one of these, because the comments that contained more than one often made a comparison, such that it'd be inappropriate to calculate a single sentiment score for the whole comment.

I used [sentimentr](https://github.com/trinker/sentimentr) to calculate the polarity sentiment of each comment. (I'll use the word **sentiment** here to refer to the sentiment analysis done by sentimentr. I'll use **attitude** to refer to what thedonald.win's users actually think, that is, the thing that I'm trying to estimate.) sentimentr does account for valence shifters to some degree – in other words, it tries to make a difference between "Fox is good" & "Fox is _not_ good" or "Fox is bad" & "Fox is _very_ bad" – but it is not perfect. Here are the most negative sentences about Fox News in the data set:

- "Trump warned us about the enemy within - RINOS and FOX - we need to nuke this cancer before we go onto destroying the puppet masters of the weak minded." `-0.850`
- "Fuck the FBI, fuck Fox News." `-0.816`
- "Which explains why Fauxi basically said masks were stupid and useless early on, but now it's a crime against humanity to not wear one." `-0.816`
- "Fake Fox is dead to me." `-0.714`

& the most positive:

- "YES! CONFIRMED BY FOX NEWS!" `+0.525`
- "Well...Fox is controlled opposition and they proved that, so it's more than just the cool thing to say ya know?" `+0.495`
- "That is one fine-looking foxy female ...said no one ever, not even inmates locked in prison for the past 30 years" `+0.472`
- "Link, source? I dont TV and I dont eat fox news ads. Please forgive." `+0.441`

So you see both a false negative & several false positives there, but at least the comments with low sentiment seem to be more negative than those with high sentiment. Since we'll only be interested in comparing scores from different segments, that's really all we'll need. Still, as you read on, remember that this signal is noisy.

I then set about converting the upvotes & downvotes into a combined & standardised value. Upvotes & downvotes were both distributed exponentially so I started by taking the logarithm of those. Then I just computed the difference, so `log(upvotes + 1) - log(downvotes + 1)`. That means a comment with +9/-0 got the same value as one with +99/-9 & one with +999/-99 which seemed fine to me. Finally I scaled the computed values to have mean 0 & standard deviation 1.

Of course, we have to take into account that this voting score is dependent on both the users' attitude & the sentiment of the comment. For positive users & a positive comment we expect a high voting score, but for positive users & a negative comment we expect a low voting score. That means we probably can't just look at the sentiments themselves.

As you'll see soon enough, I started analysing the data by taking only the comments with a voting score over the mean (so relatively well-received comments) & plotting the sentiment density for those. That already gave me a pretty good idea of whether attitudes changed towards Fox News after election night. But it didn't really use the information in the voting score. If a positive comment about Fox was downvoted to hell, that tells us something about the users' attitude towards Fox. There was a simple solution to this. I built a Bayesian multilevel regression model with partial pooling.[^2] That gave me more proper estimates of users' attitudes towards the three news channels.

If you want to have a look at the code, I've [put it up on GitHub](https://github.com/erwald/sentiment-analysis-thedonald-fox-news). The code is written in R & the model uses [Stan](https://mc-stan.org/).

## Results

Now to the good stuff. This graph shows the density of sentiment towards Fox News in relatively upvoted comments, before & after the election.

![Sentiment towards Fox News before & after 2020 U.S. election night.]({{ '/img/sentiment_density_fox.png' | url }})

As you can see (or not, if you're colour blind), the post-election distribution looks shifted somewhat to the left as compared to the pre-election distribution, suggesting sentiment deteriorated somewhat after election night.

Here's how Fox News compared to OANN & Newsmax across the whole data set.

![Sentiment towards OANN, Fox News & Newsmax around the 2020 U.S. election.]({{ '/img/sentiment_density_all_networks.png' | url }})

The area of the Fox News density is much larger than the others because I scaled the three groups to be proportional to their sample sizes: there are many more comments about Fox News in the data set than there are about the other two. There's not much more to say here. I don't know why the three distributions have different shapes. If there are any effects here, they are pretty small & it's hard to tell from the graphs alone if there's really something there or not.

Which is why I also modelled the problem, using sentiment & voting score to infer attitude. Of course a Bayesian model spits out posterior probability distributions. To compare two groups we calculate the difference between their posterior distributions. That's called the **contrast**. Here I wanted to know the contrast between the post-election & pre-election groups. This plot shows just that for each of the three news channels, with 89% percentile intervals.

![Mean & 89% percentile interval contrasts between post/pre-election attitude posteriors.]({{ '/img/model_contrasts.png' | url }})

In numbers, the model is

- 89% sure that attitudes towards Fox News deteriorated after election;
- 85% sure that attitudes towards OANN improved after election; &
- 54% sure that attitudes towards Newsmax deteriorated after election.

Of course this is under all the previously stated assumptions. There are very few comments about only Newsmax or only OANN before the election (N = 5 & N = 16 respectively, compared to N = 239 for Fox News). That's why the uncertainty bands are larger for those two. But most fatal is probably the iffiness of the sentiment analysis, which is noisy & has both false positives & false negatives. If I'd had more time, I would have considered labelling the data manually. But there it is. Make of all of this what you will.

[^1]: Of course Fox News ended up being correct on Arizona, but it was still probably a premature call. "I think there are some people that still think that might have been a little bit early", former White House press secretary & modern-day Cicero Sarah Huckabee Sanders said shortly thereafter. And of course among those people was Nate Silver.
[^2]: I'm not an expert in statistical modelling so there may be bugs in there. But the results make sense to me & agree reasonably with my naïve plots & with my priors. Most of what I know about this stuff, I've learned from Richard McElreath's outstanding book _Statistical Rethinking_.
