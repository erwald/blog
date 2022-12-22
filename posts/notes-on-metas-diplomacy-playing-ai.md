---
layout: layouts/post.njk
title: Notes on Meta's Diplomacy-Playing AI
date: 2022-12-22
tags: post
---

# Notes on Meta's Diplomacy-Playing AI

![img]({{ '/img/europe.jpeg' | url }})

## Summary

- **CICERO is a new AI developed by Meta AI that achieves good performance at the board game Diplomacy.** Diplomacy involves tactical and strategic reasoning as well as natural language communication: players must negotiate, cooperate and occasionally deceive in order to win.
  - CICERO comprises (1) a strategic model deciding which moves to make on the board and (2) a dialogue model communicating with the other players.
  - CICERO is honest in the sense that the dialogue model, when it communicates, always _tries_ to communicate the strategy model's actual intent; however, it can omit information and change its mind in the middle of a conversation, meaning it can _behave_ deceptively or treacherously.
- Some who are concerned with risks from advanced AI think the CICERO research project is unusually bad or risky.
  - It has at least three potentially-concerning aspects:
    1. It may present an advancement in AIs' strategic and/or tactical capabilities.
    2. It may present an advancement in AIs' deception and/or persuasion capabilities.
    3. It may be illustrative of cultural issues in AI labs like Meta's.
  - My low-confidence take is that (1) and (2) are false because CICERO doesn't seem to contain any new insights that markedly advance either of these areas of study. Those capabilities are mostly the product of using reinforcement learning to master a game where tactics, strategy, deception and persuasion are useful, and I think there's nothing surprising or technologically novel about this.
  - I think, with low confidence, that (3) may be true, but perhaps no more true than of any other AI project of that scale.
- Neural networks using reinforcement learning are always (?) trained in simulated worlds. Chess presents a very simple world; Diplomacy, with its negotiation phase, is a substantially more complex world. Scaling up AIs to transformative and/or general heights using the reinforcement learning paradigm may require more complex and/or detailed simulations.
  - Simulation could be a bottleneck in creating AGI because (1) an accurate enough simulation may already give you the answers you want, (2) an accurate and/or complex enough simulation may be AI-complete and/or (3) extremely costly.
  - Simulation could also _not_ be a bottleneck because, [following Ajeya Cotra's bio-anchors report](https://docs.google.com/document/d/1cCJjzZaJ7ATbq8N2fvhmsDOUWdm7t3uSSXv6bD0E_GM/edit#heading=h.9zg431cliphl), (1) we may get a lot of mileage out of simpler simulated worlds, (2) environments can contain or present problems that are easy to generate and simulate but hard to solve, (3) we may be able to automate simulation and/or (4) people will likely be willing to spend a lot of money on simulation in the future, if that leads to AGI.
  - CICERO does _not_ seem like an example of a more complex or detailed simulation, since instances of CICERO didn't actually communicate with one another during self-play. (Generating messages was apparently too computationally expensive.)

## Introduction

It's been a good few years for game-playing AIs. In 2016 and 2017 we saw AlphaGo and AlphaZero achieve excellent performance at go, chess and shogi using reinforcement learning with neural networks. In 2019, MuZero learned to play Atari games without any built-in knowledge of the rules, and Pluribus beat top human poker players at Texas hold 'em. Most of these systems learned to play from scratch, without any data of human play as input.

Last month, Meta AI announced a [new Diplomacy-playing AI](https://ai.facebook.com/research/cicero/), CICERO, which shows good (though not superhuman) performance at a board game that (1) features more than two competing players and (2) requires not only strategic and tactical thinking, but also the ability to communicate using natural language. To do this, CICERO combines a strategic model with a GPT-style language model (more on which later).

Diplomacy, reportedly a favourite of Henry Kissinger and Demis Hassabis, was released [at the height of the Cold War](https://medium.com/war-is-boring/please-stop-misusing-the-phrase-height-of-the-cold-war-1a547044c89e) in 1959. You play as one of seven great powers during early-20th-century Europe, moving military units around with the ultimate aim of capturing half of the continent. What sets it apart from other wargames is its negotiation phase, which focuses on private negotiation and diplomacy as players form alliances, make deals, glean information from and occasionally lie to their opponents.

Though Diplomacy is normally played with communication (known as Full-press Diplomacy), it can also be played without it (No-press Diplomacy).[^1] No-press Diplomacy is easier to master using machine learning models than Full-press because it doesn't involve natural language communication. There's already been impressive performance in No-press Diplomacy for a while. Bakhtin et al. (2021) achieved superhuman performance in 2-player No-press Diplomacy. Bakhtin et al. (2022) achieved human-level performance in 7-player No-press Diplomacy. (You'll recognise some of the names on these papers from the CICERO paper.) And now Meta AI et al. (2022) has achieved human-level performance in Full-press 7-player Diplomacy (specifically the Blitz version where players are only allowed to communicate for 5 minutes each round).

## How CICERO Works

CICERO comprises two main parts:

- A **strategic model**, which seems to work similarly to the already-existing models playing No-press Diplomacy, except that it also takes as input information from dialogues with other players (this is useful because the optimal strategy will depend on other players' intentions and suggestions, about which you can get information by talking with them).
  - The strategic engine is a compromise between optimising for winning against itself and optimising for playing like a human player. This is to avoid the model constructing ever more intricate and esoteric ways of beating its current best strategies. This method tells the model, "remember that you also need to win against and cooperate with humans".
    - Other game-playing AIs, e.g. AlphaStar, have solved this problem by periodically playing against earlier generations of themselves. CICERO cannot go this route because it needs to cooperate with humans in order to succeed; since it's learning by playing against _and with_ itself, it needs to be similar enough to a human that it knows how to cooperate with actual humans.[^2]
- A **dialogue model**, which takes the board state, the message history and a plan ("intent") produced by the strategic model as input (these are just shoved into the prompt) and outputs a message.
  - This is a 2.7B parameter Transformer-based model, pre-trained on internet text and then fine-tuned on messages from online Diplomacy games. (It's worth noting that 2.7B parameters isn't huge by today's standards. GPT-3 (2020), by comparison, had 175B parameters. So there's a [clear path](https://www.gwern.net/Scaling-hypothesis) towards improving the dialogue model.)
  - The language model is combined with filters and other supporting functions that help CICERO produce humanlike, sensible, consistent and strategically-valuable messages. For example, there's a filter that tries to remove messages that contradict the intent received as input from the strategic model.

Actual human Diplomacy involves lying and withholding information. Can CICERO also lie and withhold information?

Meta's [promotional video](https://www.youtube.com/watch?v=lNtBiZaLA0k) implies that CICERO is "fundamentally honest and fundamentally collaborative".[^3] Mike Lewis, one of CICERO's creators, [puts it like this](https://twitter.com/ml_perception/status/1595126521169326081?t=mS88nyX8YgUSWwV8ZkKQeg&s=19): "It's designed to never intentionally backstab -- all its messages correspond to actions it currently plans to take. However, sometimes it changes its mind ..."

From what I gather, CICERO can definitely withhold information, and it can kind of lie.

It can clearly cease to communicate with a player. As sanxiyn [points out](https://www.greaterwrong.com/posts/3TCYqur9YzuZ4qhtq/meta-ai-announces-cicero-human-level-diplomacy-play-with#comment-aZyFMNoj84hd47QCA), CICERO can just not say what it intends to do (either by just not striking up a conversation with a player, or by conversing with a player but not mentioning parts of its plan). I _think_ that happens when the filters adjoined to the dialogue model don't let any of the candidate messages through, e.g. because they aren't strategically valuable or sensible enough.

When CICERO communicates with another player, it always tries to communicate what it actually intends to do _at that moment_ -- it doesn't intentionally try to throw other players off by stating that it will do a thing it has no intention of doing. (Or rather, it's _trained_ not to do that. It's still a language model -- there's no guarantee that it'll _always_ produce messages that match the intent.[^4]) But it can change its intent from one moment to the next, e.g. in response to a message from another player. As a result, you can have a conversation with CICERO where it first expresses its intent, then seconds later changes its mind, and then keeps conversing with you without letting you know it has changed its mind. That may not feel like lying on the inside, but it sure looks like lying from the outside.[^5]

Gwern speculates that the training process may have smuggled deception in as a kind of superstructure around the honest intent-to-message function:

> CICERO may be constrained to be "honest" in each interaction but it still will betray you if you trust it & move into positions where betraying you is profitable. Is it merely opportunistic, or is it analogous to humans where self-deception makes you more convincing? (You sincerely promise to not steal X, but the temptation of X eventually turns out to be too great ...) It is trained end-to-end and is estimating expected value, so even if there is no "deception module" or "deception intent" in the planning, the fact that certain statements lead to certain long-term payoffs (via betrayal) may influence its value estimates, smuggling in manipulation & deception. Why did it pick option A instead of equally "honest" option B? No idea. But option A down the line turns out to "unexpectedly" yield a betrayal opportunity, which it then takes. The interplay between optimization, model-free, model-based planning, and the underlying models is a subtle one. (Black-box optimization like evolution could also evolve this sort of de facto deception even when components are constrained to be "honest" on a turn-by-turn basis.) [...] Just like "security" and "reliability", honesty is a system-level property, not a part-level property, and the composition of many "honest" components can yield deceptive actions.

If I understand the paper correctly, it's not exactly true to say that CICERO was trained end-to-end, or rather, it is true but this end-to-end training didn't involve the dialogue model as such.[^6] Gwern's point is still plausible, I think, as CICERO _could_ have picked up deceptive heuristics in the way that it chooses (and then discards) intents.

The extent to which CICERO actually did pick up deceptive heuristics is unclear to me. Adam Lerer from the CICERO team [writes](https://old.reddit.com/r/MachineLearning/comments/zfeh67/d_were_the_meta_ai_research_team_behind_cicero/izfhgd0/): "One reason that CICERO did not use deception effectively -- and why we abandoned it -- is that it wasn't very good at reasoning about the long-term cost of lying, i.e. knowing exactly how much a particular lie would hurt its ability to cooperate with the other player in the future." But I'm confused about what he means when he says they "abandoned" deception -- did they originally try to make CICERO deceptive and then reverse course only because it wasn't actually to its advantage?

(Diplomacy players sometimes seem to emphasise that deceptive and treacherous behaviour is often not conducive to success, because, while it produces a short-term gain, it also produces a loss in the long term as other players lose trust in you and are less willing to cooperate with you. Andrew Goff, who's won three Diplomacy world championships, and who was also involved in the development and publication of CICERO, [writes](https://old.reddit.com/r/MachineLearning/comments/zfeh67/d_were_the_meta_ai_research_team_behind_cicero/izfbfrz/): "Backstabbing tends to get devalued by CICERO. It has long been my thinking that backstabbing is a poor option in the game and I always feel like I fail when I have to do it, and CICERO seems to agree with me. It gets clearly better results when it is honest and collaborates with allies over the long term." I downweight this somewhat though as everyone likes to think that what they do is good and lawful, and Goff seems to be an unusually cooperative Diplomacy player. And I think even Goff would agree that deception _does_ play an important role in Diplomacy.)

## Is CICERO Dangerous?

Some people who are concerned with risks from advanced AI seem to find CICERO an unusually bad idea. E.g. [Form of Plato](https://twitter.com/FormOfPlato/status/1595095880868282371) (1.9K likes):

> Yudkowsky: In my blogging I invented AI-boxing as a cautionary tale.
>
> Tech company: At long last we have created the AI-box breaker from the classic blog post "Don't Create AI that Tries to Break out of Boxes".

Or [Erik Brynjolfsson](https://twitter.com/erikbryn/status/1595081326427676672) (1.5K likes):

> Nothing to see here.
>
> Just an AI system learning to strategically plan world conquest, negotiate with humans in English and then betray them via the game of Diplomacy.

Or [Gwern](https://www.lesswrong.com/posts/3TCYqur9YzuZ4qhtq/meta-ai-announces-cicero-human-level-diplomacy-play-with?commentId=yP3wMgc4irayJEMFZ#comments) (36 karma):

> Gain-of-lambda-function research: yes, this is among the worser things you could be researching, up there with the Codex code evolution & Adept Transformer agents. There are ... uh, not many realistic, beneficial applications for this work. No one really needs a Diplomacy AI, and applications to things like ad auctions are tenuous. (Note the amusing wriggling of [Meta] PR when they talk about "a strategy game which requires building trust, negotiating and cooperating with multiple players" - you left out some relevant verbs there ...) And as we've seen with biological research, no matter how many times bugs escape research laboratories and literally kill people, the _déformation professionnelle_ will cover it up and justify it. Researchers who scoff at the idea that a website should be able to set a cookie without a bunch of laws regulating it suddenly turn into don't-tread-on-me anarchocapitalists as soon as it comes to any suggestion that their research maybe shouldn't be done.

I can think of at least three things that may concern people about CICERO:

1. It presents an advancement in AIs' strategic and/or tactical capabilities.
2. It presents an advancement in AIs' deception and/or persuasion capabilities.
3. It shows Meta generally nosing around in an area it shouldn't and thinking that that's fine and not scary at all, i.e. it calls attention to cultural issues in AI labs.

I weakly think (1) and (2) are false, and am on the fence about (3).

The reason why I think (1) and (2) are false is not that CICERO isn't good at strategy, tactics, deception or persuasion. Zvi Mowshowitz [seems to argue something like this](https://thezvi.substack.com/p/on-the-diplomacy-ai):

> The strategic engine, as I evaluated it based on a sample game with six bots and a human, seemed to me to be mediocre at tactics and lousy at strategy. Humans are bad at tactics (and often strategy) in games and Diplomacy is no exception. Diplomacy's tactics [are] a good match for [an] AI. Anticipating other players proved harder. The whole thing feels like it is "missing a step".

Though he has since edited his post to amend a qualification:

> An author of the paper, however, points out that this engine entered and won a No-Press (Gunboat) Diplomacy Tournament, and won it, with one expert saying it was top-5 in the world at that. Perhaps my threshold for tactics is unfair here, or I happen to disagree with the key decisions I examined, or I am sufficiently rusty (or uneducated?) that I am neglecting other considerations and reaching wrong conclusions.

That seems to be a reference to Diplodocus, an earlier Diplomacy AI which was created by some of the same people as CICERO and, I believe, shares some of its code (Bakhtin et al. 2022). About Diplodocus, one high-level Diplomacy player [says in a video commentary](https://www.youtube.com/watch?v=AWQFhYSD7h4): "It was exceptionally strong tactically, [...] it could cooperate, it could signal and it could stab. Oh boy could it stab! I saw player after player get decimated by this AI after aligning themselves with it." That sounds like it's strong at both tactics and deception.

Given that we've seen AIs similar to CICERO achieve superhuman performance at 2-player No-press Diplomacy (Bakhtin et al. 2021), and strong though not superhuman performance at 7-player No-press Diplomacy (Bakhtin et al. 2022), and that expert players seem to rate CICERO's and its ancestors' tactical skills highly, I (who know little about Diplomacy) would guess that CICERO is better at tactics than ≥90% of tournament-going Diplomacy players and better at strategy than ≥70% of them. Its deceptive and persuasive capabilities are murkier since I've seen less of them.

But even if CICERO is better than previous game-playing AIs at tactics, strategy, deception and/or persuasion, I still think it doesn't present marked advances in any of those capabilities, because I can discern no novel insights that led to those improvements. Instead, I think they're mostly the product of using reinforcement learning to master a game where tactics, strategy, deception and persuasion are useful. But this looks less like a technological advance than the application of old technologies to a new (and ultimately irrelevant) domain.

(Exceptions could be the way CICERO combines a strategic model with a Transformer-based language model, or the way CICERO grounds its strategies in human models in order to cooperate with and anticipate human moves -- those may be technologically novel and significant capabilities advancements, but I lean towards not.)

As for (3), again I'll quote Zvi:

> Gwern's conclusion [in the comments of this post](https://www.lesswrong.com/posts/3TCYqur9YzuZ4qhtq/meta-ai-announces-cicero-human-level-diplomacy-play-with?commentId=yP3wMgc4irayJEMFZ#comments) is that the main update from the Diplomacy AI is that Meta bothered to make a Diplomacy AI. This seems right to me, with the note that it should update us towards Meta being even more of a bad actor than we previously assumed.

I do think Meta AI is a bad actor in the sense that it puts too little attention and resources on existential risks from AI, but I'm not convinced that CICERO should update our opinion on that. If (1) and (2) are false, CICERO is no more dangerous than any other AI research project, and we already knew Meta is pouring money into those. (Actually, we already knew Meta had been pouring money into Diplomacy-playing AIs, too.) So it seems to me that the research project that produced CICERO isn't more dangerous than a baseline AI research project of the same scale (which is to say, not _not_ dangerous).

## Simulated Worlds

Systems like CICERO are trained through reinforcement learning with self-play. Roughly speaking, you have the AI play against copies of itself, and then improve it based on how each copy fared. This process is repeated hundreds of thousands or millions of times. It's possible to repeat it rapidly because these models don't play _out there in the real world_, they play in simulated worlds (training environments).

The world of chess is really simple -- a board, 32 pieces and some meta-information like whose turn it is -- and is correspondingly simple to simulate. The real world is astoundingly complex and correspondingly hard to simulate. We can learn a lot from studying AIs in the isolated environments of board games. But the dream (or nightmare) is that we can scale up AIs like AlphaZero and CICERO, train them in more complex simulated worlds (perhaps even simulated approximations of the real world) and attain transformative AI that way.

Is that possible? I think this pathway is present, explicitly or implicitly, in many AGI scenarios, but you can imagine some reasons why it may not be feasible:

- **An accurate enough simulation may already give you the answers you want.** Say you want to train an AI to make money on the stock market. For it to do well on the _actual_ stock market _of the real world_, your simulated stock market needs to resemble the real-world stock market. But if you have _that_, you can just simulate security prices into the future and go long those that it predicts will go up and short the ones that will fall -- you don't need the AI.
- **An accurate and/or complex enough simulation may be AI-complete.** For example, perhaps getting AGI through reinforcement learning requires us to simulate something close to the real world. That's an astoundingly complex task which we plausibly cannot do without the economic, intellectual and labour power of AGI.
- **An accurate and/or complex enough simulation may be extremely costly.** Simulating such an environment may require so much money, labour and/or time that no one will be able to afford it, even if we could do it in theory.

But Ajeya Cotra thinks the costs of simulation[^7] [probably won't prevent us from creating transformative AI](https://docs.google.com/document/d/1cCJjzZaJ7ATbq8N2fvhmsDOUWdm7t3uSSXv6bD0E_GM/edit#heading=h.9zg431cliphl):

- **We could get a lot of mileage out of simpler simulated worlds**, for example more complex versions of existing video games, board games and procedurally generated environments. (Some of these may already allow us to train AIs to a high degree of intelligence, as it seems current human and AI performance is far from perfect.)
- **Environments can contain or present problems that are easy to generate and simulate but hard to solve**, e.g. factoring products of two large primes.
- **We may be able to automate simulation**, at least partly, for example using other, already-existing AIs.
- **People will likely be willing to spend a lot of money on building AGI in the future**, including on simulation. For example, you could employ a lot of people to design and program complex simulators.

(Cotra goes into more detail on each of these in the linked document.)

I _think_ Cotra's reasons presuppose that an intelligent enough AI can preserve its capabilities out-of-distribution, i.e. if you train a neural network in a simulated world not much more complex than Diplomacy with enough parameters and compute, such that it becomes just as intelligent and general as a human, then it would retain its capabilities also in other environments, such as the real world.

Had CICERO represented a capability advancement, I'd say this would've been it. The world of Diplomacy, because it includes communication with natural languages, is substantially more complex than that of chess or go. But CICERO was not actually trained in an environment that included dialogue; the dialogue part of the game was approximated during training (apparently because the computational costs of generating dialogue made it too cumbersome to do during training; the language model was instead optimised separately). So CICERO doesn't seem like an advancement in this respect either (though it's easy to imagine the next generation of Diplomacy-playing AIs being just that).[^8]

## The Future of Diplomacy AIs

The Metaculus community's [median estimate](https://www.metaculus.com/questions/11818/superhuman-diplomacy-ai/) for superhuman performance at Full-press Diplomacy is May 2024. My own 90% confidence interval is spring 2023 to spring 2027. I don't think you'd need any major technological breakthroughs to get there. Maybe you could tweak the current architecture, use a larger language model and throw more compute at the whole thing and end up with a superhuman AI next year already. (Maybe Meta AI is already doing this.)

What I'm less sure about is how much time and money Meta and its competitors are willing to invest in a Diplomacy-playing AI at this point -- whether anyone will bother improving on CICERO, or if they'll move on to other games instead. On the one hand, (1) Diplomacy is far less popular than chess or go; (2) it's unclear whether Meta AI (the most likely lab) feels that it has more to accomplish in Diplomacy after CICERO; and (3) future Diplomacy-playing AIs may need to deal with being recognised and possibly exploited or targeted by human players. On the other hand, (4) CICERO got a lot of attention for mere human-level performance; (5) a lot of the groundwork has already been done (CICERO's code [is open source](https://github.com/facebookresearch/diplomacy_cicero)); and (6) [compute seems to have been an important bottleneck](https://old.reddit.com/r/MachineLearning/comments/zfeh67/d_were_the_meta_ai_research_team_behind_cicero/izfeehk/).

## References

<style>.csl-entry{text-indent: -2em; margin-left: 2em;}</style><div class="csl-bib-body">
  <div class="csl-entry">Bakhtin, Anton, David J Wu, Adam Lerer, Jonathan Gray, Athul Paul Jacob, Gabriele Farina, Alexander H Miller, and Noam Brown. 2022. “Mastering the Game of No-Press Diplomacy via Human-Regularized Reinforcement Learning and Planning.” https://doi.org/10.48550/ARXIV.2210.05492</div>
  <div class="csl-entry">Bakhtin, Anton, David Wu, Adam Lerer, and Noam Brown. 2021. “No-Press Diplomacy from Scratch.” https://doi.org/10.48550/ARXIV.2110.02924</div>
  <div class="csl-entry">Meta AI, Anton Bakhtin, Noam Brown, Emily Dinan, Gabriele Farina, Colin Flaherty, Daniel Fried, et al. 2022. “Human-Level Play in the Game of Diplomacy by Combining Language Models with Strategic Reasoning.” <i>Science</i>, eade9097.</div>
</div>

[^1]: There's also a mode called public press, where players do communicate, but only publicly, never privately. There may also be other modes that I don't know of.
[^2]: Meta AI et al. (2022): "In finite [two-player zero-sum] games, certain reinforcement learning algorithms that learn by playing against themselves -- a process known as self-play -- will converge to a policy that is unbeatable in expectation in balanced games. In other words, any finite [two-player zero-sum] game can be solved through self-play with sufficient compute and model capacity. However, in games that involve cooperation, self-play without human data is no longer guaranteed to find a policy that performs well with humans, even with infinite compute and model capacity, because the self-play agent may converge to a policy that is incompatible with human norms and expectations."
[^3]:
    Though perhaps all that means is that Meta's promotional video is not fundamentally honest or fundamentally collaborative.

    Also see Meta AI et al. (2022): "CICERO conditions its dialogue on the action that it intends to play for the current turn. This choice maximizes CICERO's honesty and its ability to coordinate, but risks leaking information that the recipient could use to exploit it (e.g., telling them which of their territories CICERO plans to attack)."

[^4]: In the validation data for CICERO's language model, about 7% of generated messages did not match the given intent (Meta AI et al. 2022). The post-processing filters likely catch some, but not all, of these.
[^5]: Watching games, it seems there are also instances where CICERO is honest about what it's going to do, but dishonest or confused about its reasons for doing so. E.g. at 1:11:00 in [this game](https://www.youtube.com/watch?v=u5192bvUS7k), where Turkey says it'll move its fleet into the Black Sea in order to support the human player into Romania, even though it's already supporting the human player into Romania from Bulgaria this round, as it has also verbally confirmed; presumably the real reason was to use the Black Sea fleet as a power base against the human player (the game ends soon thereafter, Turkey not having gone against the human player).
[^6]: Meta AI et al. (2022): "One challenge in doing self-play in _Diplomacy_ is that players may adapt their actions substantially on the basis of dialogue with other players, including coordinating joint actions. Explicitly simulating conversations would be extremely expensive in [reinforcement learning]. However, a key insight is that a joint, shared [behavioral cloning] policy trained on the joint action distribution of the human data already implicitly captures the effects of dialogue on the action distribution of human players by modeling that action distribution directly."
[^7]: Cotra's report doesn't assume that an AI would be trained in simulated environments (generally unsupervised learning); it could also be trained on data (generally supervised learning).
[^8]: I do think Diplomacy is more complex than chess or go in the sense that its branching factor is many orders of magnitude larger, however I don't think it's orders of magnitude more difficult to simulate. This may be a point in favour of the "we can fairly simply simulate fairly complex worlds" thesis.
