---
layout: layouts/base.njk
title: A Contradiction at the Heart of Stallman's Free Software Argument
date: 2021-01-23
tags: post
---

# A Contradiction at the Heart of Stallman's Free Software Argument

> When they came to him, straightway he cast the serpent into the deep sea, where he lies about all the land; and this serpent grew so greatly that he lies in the midst of the ocean encompassing all the land, and bites upon his own tail.[^1]
>
> – Snorri Sturluson

Let me begin with a throat clearing. I'm all for free (as in free speech) software. I have contributed, in small ways at least, to free & open source projects, I admire many of its proponents & contributors & am increasingly trading out proprietary tools & services for free ones. The [code for this website](https://github.com/erwald/blog) is free. Nearly every other software project I have undertaken privately is also free. I think that [making software free is good for innovation]({{ '/posts/evolution-of-programming-language-traits/' | url }}). It's good for programmers. It's good for people. It's the kind of thing that everybody can get behind.

But (& you knew there was going to be a "but") the philosophy that Richard Stallman presents in _[Why Software Should Be Free](https://www.gnu.org/philosophy/shouldbefree.en.html)_ goes too far for me. It goes so far that it bends into a circle & eats its own tail, like [the world-serpent of the Norse sagas](https://en.wikipedia.org/wiki/J%C3%B6rmungandr). That is to say, there is a contradiction at its heart, precisely where its theory meets its praxis.

I will explain what I mean by that soon enough. But first I will try to summarise Stallman's argument as clearly & sympathetically as I can. The argument goes something like this:

1. When somebody has tailored themselves a jacket, they own that jacket. They are justified in controlling it because if they were not, somebody else could do something with it which would be bad for its owner, or somebody else could steal it which, again, would be bad for its owner as it would deprive them of a jacket. The same isn't true for software. If someone copies your program, you still have your program. If someone modifies the copy, your program is still unmodified.
2. Hence no creator is justified, when their created thing is immaterial, in controlling that thing. The two are separate from one another. The creator is entitled to credit & gratitude for their work but they are not – no matter how much time, skill or effort was involved in creating it – justified in controlling its spread or use.
3. Proprietary software is like private roads. Free software is like public roads. Either we could have a world where all roads are privately built & funded by tolls, such that private actors would be incentivised to build roads because they profit directly from it; or we could have a world where all roads are publicly funded & freely available to whoever wishes to use them. The latter is more beneficial to society & less costly for it.
4. The utility of allowing free access to a program is greater than that of restricting access to it, which in fact causes harm, e.g. by preventing others from learning about it, by preventing them from building on it, by reducing innovation or by damaging social cohesion. Therefore, each person is not only justified but even obliged to spread programs freely, no matter who created them. Because this is what will maximise utility for those who use programs. As Stallman writes:

> Suppose that both you and your neighbor would find it useful to run a certain program. In ethical concern for your neighbor, you should feel that proper handling of the situation will enable both of you to use it. A proposal to permit only one of you to use the program, while restraining the other, is divisive; neither you nor your neighbor should find it acceptable.
>
> Signing a typical software license agreement means betraying your neighbor: “I promise to deprive my neighbor of this program so that I can have a copy for myself.” People who make such choices feel internal psychological pressure to justify them, by downgrading the importance of helping one's neighbors – thus public spirit suffers. [...]
>
> Many users unconsciously recognize the wrong of refusing to share, so they decide to ignore the licenses and laws, and share programs anyway. But they often feel guilty about doing so. They know that they must break the laws in order to be good neighbors, but they still consider the laws authoritative, and they conclude that being a good neighbor (which they are) is naughty or shameful.

I think it's important to distinguish between two senses of ownership here. The first is that of exerting control over a thing. The second is that of benefitting somehow, in a privileged way, from a thing. Stallman argues that the first is not only wrong but even incoherent in a way, since there can be no owner of software in that way. From what I can tell, Stallman is fine with a programmer benefitting from the programs they write. He writes:

> We thus have a paradox: the developer of useful software is entitled to the support of the users, but any attempt to turn this moral obligation into a requirement destroys the basis for the obligation. A developer can either deserve a reward or demand it, but not both.
>
> I believe that an ethical developer faced with this paradox must act so as to deserve the reward, but should also entreat the users for voluntary donations. Eventually the users will learn to support developers without coercion, just as they have learned to support public radio and television stations.

However, he seems to think that it's only fine to the extent that benefitting is divorced from exerting control, viz. when the programmer benefits passively but doesn't restrict their program in order to do so. I think this is somewhat disingenuous because recognising that the programmer is justified in benefitting passively from a program they wrote means recognising that the program they wrote is "tethered" to them in some way. It means that their having written the program gives them some rights with regard to it (specifically, the right to benefit from it). But if _that's_ true, there is reason to believe also that their having written the program gives them some rights to control it, which Stallman denies.

That's not normally how we think about these things. We usually think whoever comes up with a new thing _is_ justified in acting to benefit from it. Imagine a nobody approaches a Hollywood studio executive with an idea for a movie. The person is rebuffed but the studio goes on to make the movie anyway: it is a huge box office success. The person sees none of the money. Doesn't it seem like the studio executive wronged that person? Like they used that person as a mere means to further their own ends? Under Stallman's view there'd be nothing wrong with this; under his view, the only thing that'd be wrong is if the person had then decided to sue the studio for damages.

But let's say, for the sake of argument, that Stallman can smoothen out that friction. Let's say that the scenario with the studio executive [seems wrong intuitively]({{ '/posts/tolstoy-in-ryazan/' | url }}) but is not wrong upon deliberation. Stallman holds that it is wrong to exert control over a program once you've written it. But the GNU General Public License (which I like) does exactly this. It restricts people in the way that they use the licensed program. [GPL-3](https://www.gnu.org/licenses/gpl-3.0.html), the latest of them, does this in a variety of ways, by requiring the user to:

- include information about where to find the original software,
- include information about how the software has been modified,
- include installation instructions,
- retain the GPL-3 license &
- retain the original copyright.

All of these are ways in which the owner, who selected the license, exerts control over the program & the user, who is bound by it. In other words, GPL-3 & its ancestor licenses recognise the creator's right to a measure of control over the thing they created even after it's out there in the world. That makes some of Stallman's arguments, such as the example of the neighbours that I quoted earlier, sound almost incoherent.[^2] Thus the world-serpent bites its own tail.

There's now no room for defence left on any ground outside utilitarianism. Ownership of a program is only bad to the extent that it produces bad outcomes; & it is also good to the extent that it produces good outcomes. But there's nothing inherently bad or incoherent about it. Stallman does speak of consequences & cost-benefit analyses. Personally, I am neither a consequentialist nor a utilitarian. I am a Kantian, I think. I am, however, willing to consider utilitarian arguments. But in my opinion the argument from pure utilitarianism is not nearly strong enough to support the sort of conclusions that Stallman draws, such as that one is obliged to share a program with those who want it against the wishes of its creator. And I think no full account of software can be made without really considering which duties we have towards those who create it.

[^1]: Sturluson, S. & Brodeur, A. G. (1916). _The Prose Edda_.
[^2]:
    The example of the neighbours is a little strange in that it only seems to consider the utility of the neighbours & not that of the creator of the program. I think that's because, in Stallman's view, there's no such thing as an owner, so the creator has no rights over the program. This muddles things up a bit because it's no longer a universal utilitarian argument.

    One could argue against the example of the neighbours on consequentialist grounds. For instance, it could deprive the creator of monetary compensation, or it could create risks for them, e.g. from the neighbour's using the program for something immoral, causing the creator to become associated with that immoral act.

    But it would be hard to think of this reading Stallman's presentation of the example because it magics away the programmer who wrote the program & human agency generally. Hence he writes that "proper handling of the situation will enable both of you to use it" & that "[a] proposal to permit only one of you to use [it] is divisive". The acting agents here are a "proper handling" & a "proposal".
