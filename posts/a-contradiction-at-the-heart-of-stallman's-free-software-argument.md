---
layout: layouts/post.njk
title: A Contradiction at the Heart of Stallman's Free Software Argument
date: 2021-01-23
tags: post
---

# A Contradiction at the Heart of Stallman's Free Software Argument

<div class="edit">
<p>
Edit 2022-10-22: The free software community did not like this post. First, it was overconfident and had an obnoxious tone. (I have now improved it on both counts.) Second and more importantly, it claimed to have found a contradiction in the argument for free software given by the leading figure of free software. People took issue with that, and as a result I’ve spent the last couple of years suspecting that the post was flawed.

I’ve now re-read the post and some of Stallman’s articles, and I stand by it. Stallman argues that ownership of software (that is, the authority to restrict people’s use of a program) is wrong but that authors of programs are justified in using copyleft licenses like GPL-3 (which restrict people’s use of a program). He also argues that authors of programs are entitled to receive support from their users, but that they're prohibited from requiring that users support them in order to use their program. These things still seem contradictory to me. I have however revised the post to make my disagreement more clear.

(By the way, I’m immensely grateful to Stallman. He created <a href="https://en.wikipedia.org/wiki/GNU_Emacs">GNU Emacs</a> in 1984 and released it as free software one year later, and it’s a program I use every day, including for writing this blog.)

</p>
</div>

> When they came to him, straightway he cast the serpent into the deep sea, where he lies about all the land; and this serpent grew so greatly that he lies in the midst of the ocean encompassing all the land, and bites upon his own tail.[^1]
>
> – Snorri Sturluson

Let me begin with a throat clearing. I'm all for free (as in free speech) software. I have contributed, in small ways at least, to free and open source projects, I admire many of its proponents and contributors and am increasingly trading out proprietary tools and services for free ones. The [code for this website](https://github.com/erwald/blog) is free. Nearly every other software project I have undertaken privately is free. I think that making software free is [good for innovation]({{ '/posts/evolution-of-programming-language-traits/' | url }}), good for programmers and good for people. It's the kind of thing that everybody can get behind.

But (and you knew there was going to be a "but") I think there's a contradiction in the argument that Richard Stallman presents in _[Why Software Should Be Free](https://www.gnu.org/philosophy/shouldbefree.en.html)_. The argument goes something like this:

1. When somebody has tailored themselves a jacket, they own that jacket. They are justified in controlling it because if they were not, somebody else could do something with it which would be bad for its owner, or somebody else could steal it which, again, would be bad for its owner as it would deprive them of a jacket. The same isn't true for software. If someone copies your program, you still have your program. If someone modifies the copy, your program is still unmodified.
2. Hence no creator is justified, when their created thing is immaterial, in controlling that thing. The two are separate from one another. The creator is entitled to credit and gratitude for their work but they are not – no matter how much time, skill or effort was involved in creating it – justified in controlling its spread or use.
3. Proprietary software is like private roads. Free software is like public roads. Either we could have a world where all roads are privately built and funded by tolls, such that private actors would be incentivised to build roads because they profit directly from it; or we could have a world where all roads are publicly funded and freely available to whoever wishes to use them. The latter is more beneficial to society and less costly for it.
4. We gain more from allowing free access to a program than from restricting access to it. The latter actually causes harm, e.g. by preventing others from learning about it, by preventing them from building on it, by reducing innovation or by damaging social cohesion. Therefore, each person is not only justified but even obliged to spread programs freely, no matter who created them. As Stallman writes:

> > Suppose that both you and your neighbor would find it useful to run a certain program. In ethical concern for your neighbor, you should feel that proper handling of the situation will enable both of you to use it. A proposal to permit only one of you to use the program, while restraining the other, is divisive; neither you nor your neighbor should find it acceptable.
> >
> > Signing a typical software license agreement means betraying your neighbor: “I promise to deprive my neighbor of this program so that I can have a copy for myself.” People who make such choices feel internal psychological pressure to justify them, by downgrading the importance of helping one's neighbors – thus public spirit suffers. [...]
> >
> > Many users unconsciously recognize the wrong of refusing to share, so they decide to ignore the licenses and laws, and share programs anyway. But they often feel guilty about doing so. They know that they must break the laws in order to be good neighbors, but they still consider the laws authoritative, and they conclude that being a good neighbor (which they are) is naughty or shameful.

I think it's important to distinguish between two senses of ownership here. The first is that of exerting control over a thing. The second is that of being entitled to benefit somehow, in a privileged way, from a thing. Stallman argues that a programmer exerting control over their program is wrong. From what I can tell, he's fine with a programmer benefitting from the programs they write. He writes:

> We thus have a paradox: the developer of useful software is entitled to the support of the users, but any attempt to turn this moral obligation into a requirement destroys the basis for the obligation. A developer can either deserve a reward or demand it, but not both.
>
> I believe that an ethical developer faced with this paradox must act so as to deserve the reward, but should also entreat the users for voluntary donations. Eventually the users will learn to support developers without coercion, just as they have learned to support public radio and television stations.

However, he seems to think that it's only fine to the extent that benefitting is divorced from exerting control, namely when the programmer benefits passively but doesn't restrict their program in order to do so. I think this is odd. Stallman says the programmer is "entitled to the support of the users", and being entitled to a thing means you have a right to that thing. But according to Stallman you're not allowed to claim that right. What's a right for if you can't do anything with it?

That's not normally how we think about these things. We usually think whoever comes up with a new thing _is_ justified in acting to benefit from it. Imagine a nobody approaches a Hollywood studio executive with an idea for a movie. The person is rebuffed but the studio goes on to make the movie anyway: it is a huge box office success. The person sees none of the money. Doesn't it seem like the studio executive wronged that person? Like they used that person as a mere means to further their own ends? Under Stallman's view there'd be nothing wrong with this; under his view, the only thing that'd be wrong is if the person had then decided to sue the studio for damages.

Let's say that the scenario with the studio executive, if it [seems wrong intuitively]({{ '/posts/tolstoy-in-ryazan/' | url }}), still is not wrong upon deliberation. Stallman thinks no one can own a piece of software -- that it's unethical for a programmer to exert control over a program once they've written it. But the GNU General Public License (which I like) does exactly this. It restricts people in the way that they use the licensed program. [GPL-3](https://www.gnu.org/licenses/gpl-3.0.html), the latest of them, does this in a variety of ways, by requiring the user to:

- include information about where to find the original software,
- include information about how the software has been modified,
- include installation instructions,
- retain the GPL-3 license and
- retain the original copyright.

All of these are ways in which the owner, who selected the license, exerts control over the program and the user, who is bound by it. In other words, GPL-3 and its ancestor licenses recognise the creator's right to a measure of control over the thing they created even after it's out there in the world. That seems to be in tension with some of Stallman's arguments, such as the example of the neighbours that I quoted earlier.[^2]

Of course Stallman might say that controlling a program you made is good if you restrict users in a good way and bad if you restrict users in a bad way. This works if your goal is to bring about the best consequences for society (or at least the users of programs). But Stallman doesn't seem like a utilitarian. He talks about "duties" and "obligations". He thinks [these freedoms are inviolable](https://www.gnu.org/philosophy/free-software-even-more-important.html): "I'm often asked to describe the 'advantages' of free software. But the word 'advantages' is too weak when it comes to freedom. Life without freedom is oppression, and that applies to computing as well as every other activity in our lives." And in [this interview](https://www.gnu.org/philosophy/po/rms-hack.fr-en.html") he seems to imply he's a deontologist:

> TV: It seems that the distinction between "open source" and "free software" is that the open source movement ultimately justifies the idea on utilitarian grounds; open source is the best way of producing functional software; while the ultimate justification for free software is non-calculative, non-utilitarian; freedom is unviolable. Is that a correct interpretation?
>
> RMS: More or less. I would say that freedom has value in itself, just as powerful reliable software does.

[^1]: Sturluson, S. & Brodeur, A. G. (1916). _The Prose Edda_.
[^2]:
    The example of the neighbours is a little strange in that it only seems to consider the utility of the neighbours and not that of the creator of the program. I think that's because, in Stallman's view, there's no such thing as an owner, so the creator has no rights over the program. This muddles things up a bit because it's no longer a universal utilitarian argument.

    One could argue against the example of the neighbours on consequentialist grounds. For instance, it could deprive the creator of monetary compensation, or it could create risks for them, e.g. from the neighbour's using the program for something immoral, causing the creator to become associated with that immoral act.

    But it would be hard to think of this reading Stallman's presentation of the example because it magics away the programmer who wrote the program and human agency generally. So he writes that "proper handling of the situation will enable both of you to use it" and that "[a] proposal to permit only one of you to use [it] is divisive". The acting agents here are a "proper handling" and a "proposal".
