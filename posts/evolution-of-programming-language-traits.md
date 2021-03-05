---
layout: layouts/post.njk
title: Evolution of Programming Language Traits
date: 2021-01-02
tags: post
---

# Evolution of Programming Language Traits

> So Meliboeus, carefully set out  
> Your plants and pear trees, all in rows – for whom?  
> For strangers, for others, we have farmed our land.[^1]
>
> – Virgil

Who would have thought, during most of the past century, that a new market would open up to which vast masses of people would contribute their labour freely, avidly & for no apparent benefit? one which enormous corporations, too, would support & fund at no direct profit? & whose ethos would spread into science, agriculture, design, media, the arts & elsewhere? I am talking, of course, about free & open source software, the body of which is tended to by armies of volunteers whose motivations are not at first sight clear. Rare is the person who got rich giving stuff away for free. There is a free-rider problem here: everybody benefits from free & open source software, including those who don't contribute to it. But contributing has a cost. So why exactly should one do it?

Yet GitHub has well over 100 million hosted repositories.[^2] Smartphones, supercomputers, web servers & embedded systems all see Linux & Linux-derived OSs [with the majority of the market share](https://en.wikipedia.org/wiki/Usage_share_of_operating_systems#Market_share_by_category). Regular people contribute to it, corporations sponsor it, governments fund it & [the European Commission advocates it](https://ec.europa.eu/info/news/european-commission-adopts-new-open-source-software-strategy-2020-2023-2020-oct-20_en). So what gives? I will return to this question. But before I do, I want to say something about innovation. And the best way to do _that_ is with an example.

Say you need to add some strings together. Maybe you have a word known only at runtime that you need to put inside a sentence. How you do that depends on which language you're using. For instance, in Fortran, you would use **string concatenation**:

```fortran
Sentence = 'If Socrates is human and ' // Property // ', then he is ' // Property // '.'
```

But if you were doing it in Objective-C, you would probably have done it like this:

```objc
NSString *sentence = [NSString stringWithFormat:@"If Socrates is human and %@, then he is %@.", property, property];
```

That's **string formatting**: putting placeholders in a string & specifying which variables should replace those placeholders at runtime. So far, so good. These days, however, you are more likely to write it differently. Today you would probably write it in something like the following manner:

```js
const sentence = `If Socrates is human and ${property}, then he is ${property}.`;
```

This is **string interpolation** – where variables are inserted directly inside the string – in JavaScript. So here we have three different ways of putting strings together.[^3] What is interesting is that they seem to vary in prevalence over time. Specifically, string interpolation seems to have become more & more popular, crowding out the other ways. In JavaScript, it was introduced with ES6 (2015); Scala introduced it in version 2.10.0 (2013):

```scala
val sentence = s"If Socrates is human and $property, then he is $property."
```

C# added it in version 6.0 (2015):

```cs
string sentence = $"If Socrates is human and {property}, then he is {property}.";
```

Python added f-strings in version 3.6 (2016):

```python
sentence = f'If Socrates is human and {property}, then he is {property}.'
```

In other words, many languages started adding string interpolation in the 2010s. My intuitive feeling is that it became popular with Ruby, which alongside Rails began to pick up steam around 2005 (although Ruby was far from the first language to have it). Here's how it looks in Ruby:

```ruby
sentence = "If Socrates is human and #{property}, then he is #{property}."
```

Many new popular languages feature string interpolation, including Dart (2011), Kotlin (2011), Elixir (2011), Julia (2012) & Swift (2014). One that does not is Rust (2010). A [GitHub issue](https://github.com/rust-lang/rfcs/issues/1250) created in 2015 in `rust-lang/rfcs`, which suggests adding string interpolation to Rust, is instructive, as it shows Rust users requesting it, often mentioning having come from some other language which does have it. User vvaidy [writes](https://github.com/rust-lang/rfcs/issues/1250#issuecomment-463818560): "I must confess it astonished me when I started in Rust that a modern language did not support string interpolation."[^4]

This seems to be a common sentiment & I agree. I for one don't want to go back to a world where the only way to combine strings is by concatenating them; & I assume you don't either. So perhaps it would be prudent for us to find out what sort of process made this happen. We can start doing that by making some observations about the string combination problem:

1. Different languages solve this problem in different ways, indeed some languages even solve it in multiple ways, in other words, there is **variation**.
2. Each language supports a limited number of ways of doing it & each programmer uses a limited number of languages, such that each way of combining strings is in a sense pitted against other ways when somebody chooses one to include in a language or use in code, in other words, there is **competition**.
3. New languages (& new versions of old languages) are influenced by existing languages, in other words, there is **inheritance**.

These three qualities – variation, competition & inheritance – are preconditions for evolution; without them, evolution (as described by Darwin) cannot happen.[^5] There is at any moment a variety of approaches to string combination, the better ones tend to win out in the struggle for adoption & those that survive in turn influence future approaches. This is an example of evolution of programming language traits, which itself is an example of [cultural evolution](https://plato.stanford.edu/entries/evolution-cultural/).

## Innovation on a Microscale

More specifically, the development of string interpolation is an example of innovation, the act of creating new & different things. Though innovation seems to be happening at breakneck speed, there is nothing abrupt about it. Changes are small & cumulative.[^6] New ideas are based on old ideas, on recombinations of them & on extending them to new domains.[^7] This does not make those ideas any less important. An illustrative example is the lightbulb, [the history of which is one of incremental improvement](https://theness.com/neurologicablog/index.php/who-invented-the-lightbulb/). Because recombination & extension of ideas enables innovation, we can imagine that it's beneficial to have programmers knowing many languages, paradigms & tools, so that they can transfer ideas between them & combine ideas found in different places.

Diffusion of innovations have been shown to normally follow S-shaped cumulative distribution curves, with a very slow uptake followed by rapid spread followed by a slowing down as the innovation nears ubiquity.[^8] Joseph Henrich has shown that these curves, which are drawn from real-life data, fit models where innovations are adopted based on their intrinsic attributes (as opposed to models in which individuals proceed by trial-&-error, for example).[^9] In other words, in the real world, it seems, innovations spread in the main because people choose to adopt them based on their qualities. And which qualities are those? Everett Rogers, an innovation theorist who coined the term "early adopter", identified five essential ones: an innovation must (1) have a **relative advantage** over previous ideas; (2) be **compatible** such that it can be used within existing systems; (3) be **simple** such that it is easy to understand & use; (4) be **testable** such that it can be experimented with; & (5) be **observable** such that its advantage is visible to others.[^10] Now go through that list again with the string interpolation example in mind & you'll see that it is all of those things.

### Quantitative Analysis

I decided to test my two informal hypotheses, that

1. string interpolation has become much more prevalent in recent years; &
2. its increase in prevalence follows an S-shaped cumulative distribution curve.

I used [this PYPL data set](https://raw.githubusercontent.com/pypl/pypl.github.io/master/PYPL/All.js) to get a measure of the popularity of 28 different programming languages between 2004 & 2020. Then I calculated, for each year, the sum of popularity scores of the languages that supported string interpolation that year as a proportion of the sum of popularity scores of all languages that year. (You can find the R code [on GitHub](https://github.com/erwald/string-interpolation-prevalence/tree/master).) Here is the result:

![Relative prevalence of string interpolation over time.]({{ '/img/relative_prevalence.png' | url }})

This admittedly limited approach gave evidence compatible with hypothesis 1 but not with hypothesis 2. There was a gradual drop-off in string interpolation prevalence from 2007–14 as use of two of the main languages supporting it then, Perl & PHP, declined. In 2015–16 there was however a sharp increase in prevalence, as popular languages like C#, JavaScript & Python added support for it. Why does it not show the expected S-shaped curve? Possibly the sample size is just too small to expect any kind of smooth curve. The signal is noisy.[^11] Or maybe there is a different cultural-evolutionary process going on. Natural languages have been found to develop in bursts of change interspersed with periods of relative stasis, what in biology is known as **punctuated equilibria**.[^12] Maybe something similar drives the evolution of programming languages, though if so it's not clear to me which sorts of events activate those bursts.

## Innovation on a Macroscale

So much for what makes an individual innovation spread. What can be said about population-level rates of innovation, that is to say, how innovative a population is as a whole? The rate of cultural innovation generally is correlated with population size.[^13] That makes sense: a country of a million will naturally produce more innovations than a country of one. Simulations indicate that innovation produces far more value in large population groups.[^14] From this I'm tempted to conclude that reducing barriers of entry to becoming a programmer is beneficial for all programmers.

But there is also another quality that greatly affects the population-level rate of innovation. That quality is _not_ necessity, which the adage calls the mother of invention; companies cut R&D costs when times are tough, not the other way around.[^15] Neither is it a handful of geniuses making earth-shattering individual contributions.[^16] No, what greatly affects a population's rate of innovation is its **interconnectedness**, in other words how widely ideas, information & tools are shared.[^17] In a culture that is deeply interconnected, where information is widely shared, innovations are **observable** & shared tools & standards mean that innovations are also more likely to be **compatible**. Most importantly, interconnectedness provides each individual with a large pool of ideas from which they can select the most attractive to modify, recombine, extend & spread in turn.

Interconnectedness relies on people actually sharing their knowledge, their ideas & tools. But this is what free & open source software is all about. Richard Stallman wrote in [_Why Software Should Be Free_](https://www.gnu.org/philosophy/shouldbefree.html):

> Software development used to be an evolutionary process, where a person would take an existing program and rewrite parts of it for one new feature, and then another person would rewrite parts to add another feature; in some cases, this continued over a period of twenty years. Meanwhile, parts of the program would be "cannibalized" to form the beginnings of other programs.
>
> The existence of owners prevents this kind of evolution, making it necessary to start from scratch when developing a program. It also prevents new practitioners from studying existing programs to learn useful techniques or even how large programs can be structured.

I started out by suggesting that the advantage of sharing in this way isn't immediately obvious. There are different answers to this. Stallman, in a normative account, points to pleasure, altruism & alternative funding models among other things. Eric S. Raymond, in a descriptive account, wrote that "[t]he 'utility function' Linux hackers is maximizing is not classically economic, but is the intangible of their own ego satisfaction and reputation among other hackers." In other words, maybe there is a reputation system in which failure to share knowledge is seen as bad & prestige is granted to many of those who do share. Other accounts point to contributors' signalling to potential employers &, for companies, improving the quality of free & open source software as a means to sell complementary services.[^18]

Programming is often seen as a solitary occupation. In fact, programming has its centre in people & is a deeply social occupation, in the sense that not only did we learn to program through other people & content that they made, & not only do we do it now with tools & ideas created by them, but that this learning, these tools & these ideas are in constant change as other people work on improving them, tirelessly, for our benefit, every minute of the hour & every hour of the day.

[^1]: Virgil & Ferry, D. (2000). _The eclogues of Virgil : a translation_. New York: Farrar, Straus, and Giroux.
[^2]: Some of these are owned or sponsored by for-profit companies or non-profit foundations that pay their developers. But I expect the majority to be unfunded & free & open source.
[^3]: There are further differences within these groups. For instance, some languages with string interpolation allow only variables to be inserted, whereas others also allow expressions to be inserted. Other languages allow string formatting, but only when printing to the console. These distinctions are interesting but not relevant for what I want to discuss here.
[^4]: There is now an accepted [RFC](https://rust-lang.github.io/rfcs/2795-format-args-implicit-identifiers.html) that proposes adding string interpolation to Rust.
[^5]: Mesoudi, A. (2011). _Cultural evolution : how Darwinian theory can explain human culture and synthesize the social sciences_. Chicago London: University of Chicago Press.
[^6]: It's true that there are different thresholds in various techniques & that these techniques are sometimes replaced by new ones with much higher thresholds. But that probably means there was a gradual development happening in another area, which become viable for this application. So while at some point the electronic calculator must have seemed like a large and sudden improvement over the abacus & the mechanical calculator, it was the product of a gradual development of computers until at a certain point they became a viable alternative in the calculating aid niche.
[^7]: Brien, M. & Shennan, S. (2010). _Innovation in cultural systems : contributions from evolutionary anthropology_. Cambridge, Mass: MIT Press.
[^8]: Henrich, J. (2001). _Cultural Transmission and the Diffusion of Innovations: Adoption Dynamics Indicate That Biased Cultural Transmission Is the Predominate Force in Behavioral Change_. American Anthropologist, 103(4), 992–1013.
[^9]: ibid.
[^10]: Rogers, E. (2003). _Diffusion of innovations_. New York: Free Press.
[^11]: These is an additional problem, too. The sudden increase around 2015–16 can partly be explained by the method I used, assuming as it does that all users of a language always use the latest version of it, which is obviously not the case in the real world, wherefore we should expect string interpolation in the real world to have seen a much more gradual increase starting 2015.
[^12]: Mesoudi, A. (2011). _Cultural evolution : how Darwinian theory can explain human culture and synthesize the social sciences_. Chicago London: University of Chicago Press.
[^13]: Shennan, S. (2001). _Demography and Cultural Innovation: a Model and its Implications for the Emergence of Modern Human Culture_. Cambridge Archaeological Journal, 11(1), 5–16.
[^14]: ibid.
[^15]: Brockhoff, K., & Pearson, A. (1998). _R&D Budgeting Reactions to a Recession_. MIR: Management International Review, 38(4), 363-376.
[^16]: Brien, M. & Shennan, S. (2010). _Innovation in cultural systems : contributions from evolutionary anthropology_. Cambridge, Mass: MIT Press.
[^17]: ibid.
[^18]: Lerner, J., & Tirole, J. (2003). _Some Simple Economics of Open Source_. The Journal of Industrial Economics, 50(2), 197–234.
