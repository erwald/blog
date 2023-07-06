---
layout: layouts/post.njk
title: Evolution of Programming Language Traits
date: 2021-01-02
tags: post
---

# Evolution of Programming Language Traits

Say you need to add some strings together. Maybe you have a word known only at runtime that you need to put inside a sentence. How you do that depends on which language you're using. For instance, in Fortran, you would use _string concatenation_:

```fortran
Sentence = 'If Socrates is human and ' // Property // ', then he is ' // Property // '.'
```

But if you were doing it in Objective-C, you would probably have done it like this:

```objc
NSString *sentence = [NSString stringWithFormat:@"If Socrates is human and %@, then he is %@.", property, property];
```

That's _string formatting_: putting placeholders in a string and specifying which variables should replace those placeholders at runtime. That works, but these days you're more likely to write it differently. Today you would probably write it in something like the following manner:

```js
const sentence = `If Socrates is human and ${property}, then he is ${property}.`;
```

This is _string interpolation_ – where variables are inserted directly inside the string – in JavaScript. So here we have three different ways of putting strings together.[^3] What is interesting is that they seem to vary in prevalence over time. Specifically, string interpolation seems to have become more and more popular, crowding out string concatenation and string formatting. In JavaScript, it was introduced with ES6 (2015); Scala introduced it in version 2.10.0 (2013):

```scala
val sentence = s"If Socrates is human and $property, then he is $property."
```

C# added it in version 6.0 (2015):

```cs
string sentence = $"If Socrates is human and {property}, then he is {property}.";
```

Python added f-strings in version 3.6 (2016):

```python
sentence = f"If Socrates is human and {property}, then he is {property}."
```

In other words, many languages started adding string interpolation in the 2010s. My intuitive feeling is that it became popular with Ruby, which alongside Rails began to pick up steam around 2005 (although Ruby was far from the first language to feature it). Here's how it looks in Ruby:

```ruby
sentence = "If Socrates is human and #{property}, then he is #{property}."
```

Many new popular languages feature string interpolation, including Dart (2011), Kotlin (2011), Elixir (2011), Julia (2012) and Swift (2014). One that does not is Rust (2010). A [GitHub issue](https://github.com/rust-lang/rfcs/issues/1250) created in 2015 in `rust-lang/rfcs`, which suggests adding string interpolation to Rust, is instructive, as it shows Rust users requesting it, often mentioning having come from some other language which does have it. User vvaidy [writes](https://github.com/rust-lang/rfcs/issues/1250#issuecomment-463818560): "I must confess it astonished me when I started in Rust that a modern language did not support string interpolation."[^4]

<div class="edit">
<p>
Edit 2023-07-06: Rust added support for captured identifiers in format strings (essentially, string interpolation) in its <a href="https://blog.rust-lang.org/2022/01/13/Rust-1.58.0.html">1.58.0 release</a>, announced on 13 January 2022, one year after I wrote this post.
</p>
</div>

This seems to be a common sentiment and I agree. I for one don't want to go back to a world where the only way of combining strings is by concatenating them. Having the option of string interpolation seems unambiguously good. So maybe it would be prudent for us to find out what sort of process gave us string interpolation.

We can start doing that by making some observations about the string combination problem:

1. Different languages solve this problem in different ways, indeed some languages even solve it in multiple ways, in other words, there is _variation_.
2. Each language supports a limited number of ways of doing it and each programmer uses a limited number of languages, such that each way of combining strings is in a sense pitted against other ways when somebody chooses one to include in a language or use in code, in other words, there is _competition_.
3. New languages (and new versions of old languages) are influenced by older languages, in other words, there is _inheritance_.

These three qualities – variation, competition and inheritance – are preconditions for evolution; without them, evolution (as described by Darwin) cannot happen.[^5] There is at any moment a variety of approaches to string combination, the better ones tend to win out in the struggle for adoption and those that survive in turn influence future approaches. This is an example of evolution of programming language traits, which is itself an example of [cultural evolution](https://plato.stanford.edu/entries/evolution-cultural/).

## Innovation on a Microscale

More specifically, the development of string interpolation is an example of innovation, the act of creating new and different things. Though innovation seems to be happening at breakneck speed, there is nothing abrupt about it. Changes are small and cumulative.[^6] New ideas are based on old ideas, on recombinations of them and on extending them to new domains.[^7] This does not make those ideas any less important. An illustrative example is the lightbulb, [the history of which is one of incremental improvement](https://theness.com/neurologicablog/index.php/who-invented-the-lightbulb/). Because recombination and extension of ideas enables innovation, we can imagine that it's beneficial to have programmers knowing several languages, paradigms and tools, so that they can transfer ideas between them and combine ideas found in different places.

There is evidence that innovation diffusion normally follows an S-shaped cumulative distribution curve, with a very slow uptake followed by rapid spread followed by a slowing as the innovation nears ubiquity.[^8] Joseph Henrich has shown that these curves, which are drawn from real-life data, fit models where innovations are adopted based on their intrinsic attributes (as opposed to models in which individuals proceed by trial-and-error, for example).[^9] In other words, in the real world, it seems, innovations spread in the main because people choose to adopt them based on their qualities.

What qualities? Everett Rogers, an innovation theorist (and coiner of the term "early adopter"), identified five essential ones: an innovation must (1) have a _relative advantage_ over previous ideas; (2) be _compatible_ such that it can be used within existing systems; (3) be _simple_ such that it is easy to understand and use; (4) be _testable_ such that it can be experimented with; and (5) be _observable_ such that its advantage is visible to others.[^10] String interpolation is all of those things.

Here's a rough empirical test of the two hypotheses, that (1) string interpolation has become much more prevalent in recent years and (2) its increase in prevalence follows an S-shaped cumulative distribution curve.

I use [this PYPL data set](https://raw.githubusercontent.com/pypl/pypl.github.io/master/PYPL/All.js) to get a measure of the popularity of 28 different programming languages between 2004 and 2020. Then I calculate, for each year, the sum of popularity scores of the languages that supported string interpolation that year as a proportion of the sum of popularity scores of all languages that year. (You can find the R code [on GitHub](https://github.com/erwald/string-interpolation-prevalence/tree/master).) Here is the result:

![Relative prevalence of string interpolation over time.]({{ '/img/relative_prevalence.png' | url }})

<div class="edit">
<p>
Edit 2023-07-06: I have since updated the plot using a new script written in Python, but the new graphs show essentially the same thing as the old graph.
</p>
</div>

This admittedly limited approach gives evidence compatible with hypothesis 1 but not with hypothesis 2. There was a gradual drop-off in string interpolation prevalence from 2007–14 as use of two of the main languages supporting it then, Perl and PHP, declined. In 2015–16 there was however a sharp increase in prevalence, as popular languages like C#, JavaScript and Python added support for it. Why do the graphs not show the expected S-shaped curve?

- Maybe the sample size is just too small for us to expect any kind of smooth curve. It's a pretty noisy signal.[^11]
- Maybe it's that my methodology makes things appear less continuous than they were. For example, Python added support for string interpolation in version 3.6, but it surely took time for Python users to migrate to that version, so in reality access to string interpolation increased more smoothly than my plot shows.
- Maybe there is a different cultural-evolutionary process going on. Natural languages have been found to develop in bursts of change interspersed with periods of relative stasis, what in biology is known as _punctuated equilibria_.[^12] Maybe something similar drives the evolution of programming languages, though if so it's not clear to me which sorts of events activate those bursts.

## Innovation on a Macroscale

> So Meliboeus, carefully set out  
> Your plants and pear trees, all in rows – for whom?  
> For strangers, for others, we have farmed our land.[^1]
>
> – Virgil

The rate of cultural innovation generally is correlated with population size.[^13] That makes sense: a country of a million will naturally produce more innovations than a country of one. Simulations indicate that innovation produces far more value in large population groups.[^14] So reducing barriers of entry to becoming a programmer is beneficial for everyone in so far as one wants programming to produce more goods (though it can still be detrimental to an individual programmer since programmers compete for scarce goods like prestige, jobs and promotions).

But there's also another factor that greatly affects the population-level rate of innovation. That factor is _not_ necessity, which the adage calls the mother of invention. (Companies generally cut R&D costs when times are tough, not the other way around.[^15]) Neither is it a handful of geniuses making earth-shattering individual contributions.[^16] No, what greatly affects a population's rate of innovation is its _interconnectedness_, in other words how widely ideas, information and tools are shared.[^17] In a culture that is deeply interconnected, where information is widely shared, innovations are _observable_ and shared tools and standards mean that innovations are also more likely to be _compatible_. Most importantly, interconnectedness provides each individual with a large pool of ideas from which they can select the most attractive to modify, recombine, extend and spread in turn.

Interconnectedness relies on people actually sharing their knowledge, their ideas and tools. This is what free and open source software (FOSS) is all about. Richard Stallman wrote in _[Why Software Should Be Free](https://www.gnu.org/philosophy/shouldbefree.html)_:

> Software development used to be an evolutionary process, where a person would take an existing program and rewrite parts of it for one new feature, and then another person would rewrite parts to add another feature; in some cases, this continued over a period of twenty years. Meanwhile, parts of the program would be "cannibalized" to form the beginnings of other programs.
>
> The existence of owners prevents this kind of evolution, making it necessary to start from scratch when developing a program. It also prevents new practitioners from studying existing programs to learn useful techniques or even how large programs can be structured.

Why do people contribute to FOSS? Who would have thought, during most of the past century, that a new market would open up to which vast masses of people would contribute their labour freely, avidly and for no apparent benefit? one which enormous corporations, too, would support and fund at no direct profit? and whose ethos would spread into science, agriculture, design, media, the arts and elsewhere? It is rare for people to give away their labour free of charge.

Yet GitHub has >100M hosted repositories.[^2] Smartphones, supercomputers, web servers and embedded systems all see Linux and Linux-derived operating systems [with the majority of the market share](https://en.wikipedia.org/wiki/Usage_share_of_operating_systems#Market_share_by_category). Regular people contribute to it, corporations sponsor it, governments fund it and [the European Commission advocates it](https://ec.europa.eu/info/news/european-commission-adopts-new-open-source-software-strategy-2020-2023-2020-oct-20_en). What gives?

There are different answers to this conundrum. Stallman, trying to explain why people _should_ contribute to FOSS, points to pleasure, altruism and alternative funding models among other things. Eric S. Raymond, trying to explain why people _do_ contribute to FOSS, wrote that "[t]he 'utility function' Linux hackers is maximizing is not classically economic, but is the intangible of their own ego satisfaction and reputation among other hackers." In other words, maybe there is a reputation system in which failure to share knowledge is seen as bad and prestige is granted to many of those who do share. Other accounts point to contributors' signalling to potential employers and, for companies, improving FOSS quality as a way of selling complementary services.[^18]

Programming is often seen as a solitary occupation. In fact, programming has its centre in people and is a deeply social occupation, in the sense that not only did we learn to program through other people and content that they made, and not only do we do it now with tools and ideas created by them, but that this learning, these tools and these ideas are in constant change as other people work on improving them, tirelessly, for our benefit, every minute of the hour and every hour of the day.

[^1]: Virgil & Ferry, D. (2000). _The eclogues of Virgil : a translation_. New York: Farrar, Straus, and Giroux.
[^2]: Some of these are owned or sponsored by for-profit companies or non-profit foundations that pay their developers. But I expect the majority to be unfunded and free and open source.
[^3]: There are further differences within these groups. For instance, some languages with string interpolation allow only variables to be inserted, whereas others also allow expressions to be inserted. Other languages allow string formatting, but only when printing to the console. These distinctions are interesting but not relevant for what I want to discuss here.
[^4]: There is now an accepted [RFC](https://rust-lang.github.io/rfcs/2795-format-args-implicit-identifiers.html) that proposes adding string interpolation to Rust.
[^5]: Mesoudi, A. (2011). _Cultural evolution : how Darwinian theory can explain human culture and synthesize the social sciences_. Chicago London: University of Chicago Press.
[^6]: It's true that there are different thresholds in various techniques and that these techniques are sometimes replaced by new ones with much higher thresholds. But that probably means there was a gradual development happening in another area, which become viable for this application. So while at some point the electronic calculator must have seemed like a large and sudden improvement over the abacus and the mechanical calculator, it was the product of a gradual development of computers until at a certain point they became a viable alternative in the calculating aid niche.
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
