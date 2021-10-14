---
layout: layouts/post.njk
title: How Impactful Is Free and Open Source Software Development?
date: 2021-10-09
tags: post
---

# How Impactful Is Free and Open Source Software Development?

> It's fairly clear that one cannot code from the ground up in bazaar style. One can test, debug and improve in bazaar style, but it would be very hard to originate a project in bazaar mode. Linus didn't try it. I didn't either.[^1]
>
> – Eric S. Raymond

It seems likely to me that much of our future prosperity (or much of our future, at any rate) will be built on software, including free and open source (FOSS) software. Software already pervades all the other major branches of technology – it is used in agriculture, medicine, manufacturing, construction, energy, transportation, accounting, electronics and more. It constitutes the most common means of collecting, storing, retrieving and processing information at scale. It has enabled the Global Positioning System, commercial mobile phones, near-instantaneous cash transfers, cryptocurrencies, spreadsheets, 3D printing, remote work, advanced statistical modelling, forecasting platforms and the internet among much else. Few of today's great scientific discoveries could have been made without it.

There are inventions that result in new devices or processes and no more. Then there are those inventions that result in new devices or processes that are useful in coming up with new inventions. In this second category we can include human languages and writing, the wheel, the microscope, the steam engine, electricity and the ball bearing. Often these inventions are instances of what economists call general-purpose technology, that is technology that leads to productivity increases across all sectors of a region's economy.

Software is a strong candidate for a general-purpose technology.[^2][^3] And as software is a general-purpose technology, so are there general-purpose[^4] software technologies. I mean things like programming languages, database systems, Reactive Extensions, data structure and processing libraries like NumPy and Pandas, graphics frameworks like OpenGL and distributed version control systems like Git and Mercurial – in other words, the substructure and the infrastructure of software. These are very often released under FOSS licenses, for everyone to use, inspect and modify as they wish, and are consequently often used by vast numbers of people.

Austin Vernon [is more bearish](https://austinvernon.site/blog/softwareisprocess.html) on productivity gains from software:

> The current status quo means we don't get productivity growth until these software-driven companies become behemoths. Amazon was founded in 1994, almost thirty years ago. In 2020, it was still less than 10% of total retail sales. Is it any wonder that we haven't seen robust productivity gains? [...] In many industries, assembly lines builders are just getting started. If these companies maintain rapid growth as their market share increases, [total-factor productivity] should finally show some life. [...] Since software is a multiplier, any increase in input quality or quantity is even more beneficial. Software is more impactful in a universe with 1 trillion humans than one with 10 billion humans.

In [Evolution of Programming Language Traits]({{ '/posts/evolution-of-programming-language-traits/' | url }}), I wrote about research showing that innovation rates are largely driven by a group of people's interconnectedness. I wrote:

> [W]hat greatly affects a population's rate of innovation is its **interconnectedness**, in other words how widely ideas, information and tools are shared.[^5] In a culture that is deeply interconnected, where information is widely shared, innovations are **observable** and shared tools and standards mean that innovations are also more likely to be **compatible**. Most importantly, interconnectedness provides each individual with a large pool of ideas from which they can select the most attractive to modify, recombine, extend and spread in turn.

I then went on to quote Richard Stallman:

> Software development used to be an evolutionary process, where a person would take an existing program and rewrite parts of it for one new feature, and then another person would rewrite parts to add another feature; in some cases, this continued over a period of twenty years. Meanwhile, parts of the program would be "cannibalized" to form the beginnings of other programs.
>
> The existence of owners prevents this kind of evolution, making it necessary to start from scratch when developing a program. It also prevents new practitioners from studying existing programs to learn useful techniques or even how large programs can be structured.

In other words, the free and open source philosophies really allow us to share tools and information in a way that wasn't possible before. So supposing, as I do, that technology is on the whole good for the world, creating free and open source software, especially general-purpose software, seems good for the world.

Okay, but how much _marginal_ impact can a single programmer expect to have? I think that is hard to estimate, but I will note, as the epigraph suggests, that many important FOSS projects have been created basically by a single person, alone.[^6] Linus Torvalds created the Linux kernel, various distributions of which has [the majority of the marketshare](https://en.wikipedia.org/wiki/Usage_share_of_operating_systems#Market_share_by_category) in smartphones, supercomputers, web servers and embedded systems. Then, for good measure, he wrote [git](https://git-scm.com/) which, though it was not exactly the first of its kind, has fairly revolutionised software development and code sharing. Richard Stallman wrote the text-editor [Emacs](https://www.gnu.org/software/emacs/), which is being used today, nearly 40 years after it was created, and he also laid the foundations for the [GNU Compiler Collection](https://gcc.gnu.org/). Carsten Dominik created the widely used and hugely influential information organising tool [org-mode](https://orgmode.org/). Satoshi Nakamoto[^7], building on previous work by Wei Dai and Adam Back, conceptualised and implemented Bitcoin and the blockchain.[^8] Ryan Dahl created [Node.js](https://nodejs.org/); David Heinemeier Hansson created [Ruby on Rails](https://rubyonrails.org/); Salvatore Sanfilippo created [Redis](https://redis.io/); Igor Sysoev created [nginx](https://nginx.org/). And so on.

Of course, I _would_ say all this. As a programmer, a part of me _wants_ FOSS to be important and impactful, and so I don't entirely trust myself when I say that it seems pretty important and impactful _to me_. I, too, would be sceptic if I read an accountant explaining how good pro-bono accounting is for the world. Maybe software is not as good for humanity as I think. Maybe the free and open source philosophies are not as good for software as I think. Maybe a single programmer, talented and dedicated though they may be, is just extremely unlikely to ever write a software program that is a significant improvement for the world on the margin. Software does pervade all the other major branches of technology, but so does pretty much every other major branch of technology!

How impactful is FOSS programming? 80,000 Hours, when [writing about software engineering](https://80000hours.org/2014/02/in-which-career-can-you-make-the-most-difference/), don't seem to consider FOSS at all:

> Overall, [software engineering] is good for [earning to give](https://80000hours.org/earning-to-give). Software engineers can also make some direct contributions to innovation and economic productivity, especially if working for a good company. Advocacy potential is moderately good because you can be involved in the influential and innovative tech community.

I reckon that FOSS development is good for the world, likely more impactful than whatever direct proprietary contributions one can make working for a company, but I think this is really hard to quantify – certainly much harder than quantifying charitable donations – and reckon further that this is one reason why it is talked about less than those other things. But I would like to hear other opinions.

[^1]: Raymond, E. (1999). The cathedral and the bazaar. _Knowledge, Technology & Policy_, _12_(3), 23-49.
[^2]: Basu, S., & Fernald, J. (2007). Information and communications technology as a general-purpose technology: Evidence from US industry data. _German Economic Review_, _8_(2), 146-173.
[^3]: Naughton, J. (2016). The evolution of the Internet: from military experiment to General Purpose Technology. _Journal of Cyber Policy_, _1_(1), 5-28.
[^4]: By general purpose, I mean only that they can be used in a wide variety of different applications.
[^5]: Brien, M. & Shennan, S. (2010). _Innovation in cultural systems : contributions from evolutionary anthropology_. Cambridge, Mass: MIT Press.
[^6]: Of course many other people have worked to extend, maintain and test these creations since their conceptions. I do not mean to diminish that work, which is also important.
[^7]: It is not a proven fact that he is a single person, but it seems likely to me.
[^8]: Nakamoto, S. (2008). Bitcoin: A peer-to-peer electronic cash system. _Decentralized Business Review_, 21260.
