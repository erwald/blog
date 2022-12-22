---
layout: layouts/post.njk
title: How Bad Is QWERTY, Really? A Review of the Literature, such as It Is
date: 2022-01-15
tags: post
---

# How Bad Is QWERTY, Really? A Review of the Literature, such as It Is

![Drawing of hands locked in prayer and keyboard by Viktoriia Shcherbak.]({{ '/img/qwerty.jpeg' | url }})

Some six or so years ago, not long after I had started working as a programmer, I developed a bad case of repetitive strain injury (RSI) and for a while couldn't use my left hand for typing, but had to rely on my right hand and dictation. This situation being obviously untenable, I took action: I purchased an ergonomic keyboard (Microsoft Sculpt), remapped shift to the space bar when pressed in combination with another key, started doing hand/wrist stretches and switched from typing on the QWERTY layout to [Colemak](https://colemak.com/). This grab bag of interventions worked, my RSI got better and, though it still flares up sometimes, I now have it under control.

I have stuck with Colemak since then and have liked it and occasionally even recommended it to friends and colleagues. But beyond reading popular articles about the topic, I never really looked into the evidence on key layouts and ergonomics[^1] and productivity[^2] – until now, that is!

Before we get to the good stuff, a word of caution. I am in no way an expert on this; I estimate I spent roughly 15-25 hours researching and taking notes, so there is still a lot that I'm uncertain about. My target group here is touch-typing office workers, typing mainly in English, without disabilities that significantly impede their typing (e.g. the loss of an arm or that sort of thing). For people who don't touch-type, QWERTY is probably fine. For people who have disabilities that affect their typing, I assume special considerations, of which I know little, apply.

## Summary

My current model on the RSI risk is something like this. The evidence has made me update towards the risk of developing serious RSI from keyboard use being small. I had a pretty strong prior, based on what I've heard from other programmers and on my own experience, that it often causes RSI. I still think it's a risk, but not as large as I did before, though with lots of uncertainty (80% confidence interval would be 2%-20% chance of developing keyboard RSI over a lifetime for the aforementioned target group). I think key layout is a minor part of the ergonomic harms of keyboard use; keyboard type (i.e. ergonomics of design) and posture/positioning both seem more important (70% confidence).

As for productivity, compared to e.g. Dvorak or Colemak, QWERTY seems somewhat slower for typing on the margin (80% confidence). But most people, and most programmers even, don't type enough that switching would result in a significant productivity boost (80% confidence).

In general, the QWERTY layout, while undoubtedly suboptimal, doesn't seem as bad as I had thought previously. If you are interested in making the switch and don't mind the transaction cost, you might see small benefits on the margins; if not, don't bother.

## QWERTY – Designed to Be Slow?

Here is an anecdote [recounted](https://archive.ph/R3NCX) by Michael Tiemann, expressing a commonly held belief:

> One weekend I visited Richard Stallman at MIT and I was shocked to learn that he could no longer type. He was given strict instructions by his doctor to not touch a computer keyboard for 6-12 months, and that if he did, he may lose forever his ability to type. He was a programming pioneer, and at the time, his symptoms were not well known or understood. We all came to understand that it was RSI – repetitive stress injury, exacerbated by the very keystroke combinations that made the Emacs editor such a powerful programming environment. But the root cause was not Emacs – it was the [punitive] design of the QWERTY keyboard, a legacy of the industrial era when complex keyboard mechanisms were not able to keep up with the speed of human fingers. The solution? Design a keyboard so confounding and unnatural that no human could ever outrun what the mechanism could handle. Or so they thought. Humans are remarkably adaptable, to a point. Human typists did manage (with practice and perseverance) to type every bit as quickly as before QWERTY, but at the expense of long-term health.

In other words, the idea is that QWERTY was designed so that humans would type as slowly as possible in order to prevent mechanical jamming. This idea is apparently false.[^3] Christopher Latham Sholes and others developed QWERTY in the 19th century initially for telegraph workers to receive Morse transmissions, where typing speed would have been important.[^4] (Though on the other hand, jamming is really bad for typing speed!) Quoting Yasuoka & Yasuoka:

> The development of QWERTY was a winding road, first by Sholes and others, second by Harrington and Craig, then by Jenne and Clough, again by Sholes, and at last by Wyckoff, Seamans & Benedict. There was no consistent policy towards QWERTY. The keyboard arrangement was incidentally changed into QWERTY, first to receive telegraphs, then to thrash out a compromise between inventors and producers, and at last to evade old patents.[^5]

That said, QWERTY _was_ an early attempt at designing a key layout, and it _was_ designed under conditions very different from those we have now. It would be surprising if the last 150 years of keyboard use and technological change would not have revealed some real flaws in QWERTY – if we got it pretty much right after no more than a few tries.

(Many of the academic discussions of QWERTY's history and suitability have taken place in journals of economics. Economists are interested in whether QWERTY is an example of **path dependence**. Is the market stuck in a suboptimal equilibrium due to a seeming accident of history – the adoption of QWERTY for early typewriters – or would events have played out the same way every time even if circumstances had been slightly different? As a result, much of the literature seems to have been written answering not the question "Is QWERTY suboptimal?" but the question "Is the market efficient?" and should therefore be treated with some suspicion.)

The second claim that Tiemann makes is that QWERTY is bad for ergonomics but not for typing speed. (Though confusingly he compares QWERTY to whatever was "before", even though QWERTY became the standard when typewriter technology was still in its infancy.) We'll see whether this second claim holds up.

## Theory

In theory, alternative keyboards like Dvorak and Colemak have a lot going for them. Many characteristics have been proposed as significant, for example:

- It's better if fingers have less traveling to do.
- It's better if consecutive taps are done with different fingers or, better yet, different hands.
- It's better if common keys are near the fingers' natural resting places.
- It's better to avoid stretching and overusing the pinky finger, which is the weakest of the five.

I have had a hard time finding much evidence either way on whether these factors make a difference as far as ergonomics and productivity are concerned. It really does seem like many of them _should_ make a difference. For example, in my experience awkward pinky movements really do cause discomfort or pain, and this also makes sense given what I've read about RSI. And it seems obvious that one can type faster if one's fingers need to travel less, right?

Not so fast! Typing could be constrained by neurological not physical speed, for example.[^6] And awkward pinky movements could feel uncomfortable or painful because of RSI without actually causing it, the way jumping up and down can feel painful when you have a headache without having actually caused the headache. So is there any evidence that these factors affect ergonomics or productivity?

I really only found one study that's relevant here. The researchers had a subject (singular) spend six weeks typing away first at a QWERTY keyboard and then at a Dvorak keyboard.[^7] Although the subject typed faster on QWERTY (likely due to her prior experience), typing on the home row and typing consecutively with different hands both increased typing speed, and these are both things that Dvorak and Colemak do better than QWERTY.[^8]

Some forward-thinking people have set about evaluating key layouts objectively on metrics like these. For example, the [Carpalx](http://mkweb.bcgsc.ca/carpalx) project has a quantitative model for measuring the typing effort of a key layout, based on things like finger travel distance and awkward finger reaching. (The model is parameterised, meaning it can be adjusted to give different weights to various characteristics, but from reading the project's extensive documentation I have the impression that a lot of thought has gone into default parameter selection.[^9] The documentation is well-written and extensive, so I recommend having a look at it if you want to learn more about the model.)

By Carpalx's measures, QWERTY is bad, though better than the average random key layout. Dvorak does better, and Colemak better still:

> The typing effort reduction in moving to Dvorak is 30%. Each effort component for Dvorak is lower. The finger component of the penalty is higher, due to Dvorak's increased use of the pinky (18% of keystrokes vs 10% on QWERTY are done by the pinky), which can be seen by a +56% increase in the finger penalty over QWERTY. If you have very weak pinkies, Dvorak may not be for you.
>
> Dvorak certainly does a good job in lowering the base effort – this is the component of effort that measures finger travel distance – by moving frequently used keys, such as vowels, to home row. Because Dvorak vowels are serviced by the same hand, hand-alternation is increased (one-character hand run is 62% for Dvorak and 51% for QWERTY), a desirable property of an efficient layout.
>
> The Colemak effort has an even lower effort than Dvorak and it achieves this by further lowering all three components of the effort. It significantly decreases the penalty component seen in Dvorak. Thus, although Colemak's finger penalty is still higher than QWERTY (again, through the increased use of the pinky), [the] overall penalty is lower by 24%.

## Ergonomics

RSI is an umbrella term for injuries that occur due to "repetitive movements, awkward postures, sustained force, and other risk factors".[^10] The most common and costly form it takes is carpal tunnel syndrome (CTS), where the median nerve has gotten compressed where it travels through the wrist, leading to pain, discomfort, numbness, etc.[^11] QWERTY plausibly increases the risk of CTS because it involves rotating the wrist towards the pinky more often to reach characters at edge of the keyboard.[^12] (This is not the only ergonomic issue with keyboard use, but as far as I can tell, it is the only issue that varies for different layouts.) So once again Theory whispers, "QWERTY baaad." Is it?

My first thought here was, if keyboard use in general doesn't cause RSI, bad key layouts won't be causing it either. So that seemed like a good sanity check.

The NHS [writes](https://www.nhs.uk/live-well/healthy-body/tips-to-prevent-rsi/) that "[s]pending a lot of time using a computer, keyboard and mouse is a common cause of RSI", but without citing any specific studies. Of course what I want to know is not "What proportion of RSI cases were caused by keyboard use?" but "How likely is keyboard use to lead to RSI?"

Fagarasanu & Kumar is a somewhat old (2003) review on CTS; the authors explain that, when we type, we adopt awkward hand/wrist postures that increase carpal tunnel pressure (CTP) which causes CTS.[^13] They write:

> When using traditional QWERTY key layout, both forearms are pronated and both wrists are in ulnar deviation and extension. [...] CTS was attributed to keyboarding in 8% of cumulative trauma disorders. Sauter et al. conducted a study with 932 [computer] users and assessed discomfort in wrist and right hand at 13% and 12% respective from the total sample. [...] Although there is a strong evidence of a causal relation between keyboarding and pointing devices on the one hand and CTS occurrence on the other, the role of every single design element is not known.[^14]

In other words, keyboard use can cause CTS, but we don't really know what about it we need to change in order to improve things.

(It's perhaps worth pointing out that, as risk factor for RSI, keyboard use is way less risky than some manual labour.[^15][^16] Most CTS patients are "industrial workers, females, and the elderly", not young male programmers.[^17] Reported CTS has decreased overall in the United States labour force, and appears in larger numbers in blue collar industries than in white collar industries even though there are over 50% more workers in the latter; mostly it seems that manufacturing work is to blame.[^18] I find this easy to believe; manufacturing work seems like really hard work, especially on the body.)

A 2008 review, Thomsen et al., seems inconclusive on whether keyboard use causes CTS; it did find increased CTP with keyboard and mouse use, but levels were below what's considered harmful.[^19] Wright & Atkinson (2019) advise doctors that "[p]atients with CTS can be counseled [...] that use of a keyboard and mouse at work is unlikely to be the cause of their symptoms, but it is possible that these activities may aggravate them."[^20] A 2010 review on musculoskeletal disorders and computer work found "limited evidence for a causal relationship between computer work per se, computer mouse and keyboard time related to a diagnosis of wrist tendonitis" (tendonitis being tendon pain and swelling).[^21] A more recent (2021) review looking at workplace CTS prevention finds mixed quality in studies; they write:

> [D]ecreasing ulnar drift or maintaining the wrist in neutral position with measures such as changing or modifying [accessories like keyboards] may reduce exposure to CTS. However [...] the results were not statistically significant when comparing the use of conventional ergonomic elements and the desired intervention. Results may be different if longer exposure times were analyzed, if bigger sample sizes were used, if subjects had more time to become familiar with the modifications made, or if bias assessment was controlled, among others.[^22]

In Pan & Schleifer (1996), subjects experienced more arm discomfort/pain/fatigue the more keys they pressed while doing a data entry task.[^23] Finally, Feng et al. is a recent (2021) cross-sectional study that found that "prolonged computer use time and working without breaks were associated with presence of wrist/hand symptoms".[^24] But of course correlation is not causation, and there are many potential confounders here, e.g. maybe people who spend lots of time at the computer exercise little, and it is the lack of exercise, not computer use, that causes problems.

So we have the theory, a bunch of anecdotal reports and some (non-randomised, non-controlled) studies suggesting there is a causal link between keyboard use and CTS, and a bunch of (non-randomised, non-controlled) studies finding little evidence for such a link. The studies I've come across here leave something to be desired – they are much less rigorous than the studies I read when researching [health effects of veganism]({{ '/posts/can-a-vegan-diet-be-healthy-a-literature-review/' | url }}) – possibly because the magnitude of the problem isn't that great (or maybe it is the nefarious influence of Big Keyboard).

If keyboard use does carry the risk of developing RSI, what is it about the keyboard that's bad? Is it the physical design, the key layout, hand/wrist posture, or something else? My impression is that key layout is a relatively small component here, for several reasons. The first is my own experience, according to which it's much more important to use a split keyboard, say, than the appropriate layout if I want to avoid RSI flare-ups. The second is that CTS is largely caused by CTP, which in theory seems more impacted by physical design (chiefly whether a keyboard is split and/or tilted/tented) and less by finger stretching or the horizontal rotating we do with our hands to reach keys at the sides of the keyboard. The third is Carpalx's model, which suggests that established alternatives like Dvorak and Colemak, while better on the whole, use the pinky more heavily than does QWERTY – maybe it is a little bit bad to reach for the outermost keys, but any layout will have some keys at the extremes, so perhaps the difference between layouts just isn't that great.

What about QWERTY specifically? I wasn't really able to find any research on this. Maybe that's because it's very hard to design experiments to test it? You can't just take a bunch of people and ask half of them to start using Dvorak, because there's a significant learning curve involved. But you don't want to find out if _learning_ a new layout is good, you want to find out _using_ it is good once you have learned it. There is no natural control group for these experiments, and no obvious placebo.

In sum, keyboard use in general does seem to cause RSI, but the risk seems fairly small. Bad key layouts may only be a minor part of the RSI risk, though QWERTY does seem worse than most alternatives, relatively speaking. The evidence here is weak and my confidence intervals are wide.

## Productivity

The evidence is somewhat better for typing speed, though the earliest studies (think 1930s to 1950s) are riddled with methodological flaws (e.g. non-random control groups) and conflicts of interest (e.g. being conducted by August Dvorak himself).

A difficulty in comparing QWERTY typing speeds with those of alternative designs is that nearly everybody knows QWERTY well and the alternatives not at all. So how are you going to get a fair test?

One way is to only look at the most talent typers for each layout. You might not have known that there is an Ultimate Typing Championship, for example. In the last edition to take place, in 2020, exactly one of the 26 competitors used Dvorak, and the other 25 used QWERTY; the lonely Dvorak user ended up in 12th place. On one well-known [leaderboard](https://docs.google.com/spreadsheets/d/1r-g7uIqNJ_bDCBVCFOe_hultBrCkqFzxAQ-W5aYzGbY/edit#gid=0) that same Dvorak user is in the top 30 and two Colemak users are in top ten and top 30 respectively; the rest of the top 30 all use QWERTY, I think. That sounds pretty good for QWERTY until you remember that the vast, vast majority of people have grown up and are used to using it, so given that the transaction cost of switching to an alternative layout like Dvorak is high (and more on this later), ten percent of the top thirty using alternative layouts is actually pretty significant! On the other hand, if Dvorak and other layouts really do have an edge over QWERTY, you might have expected most of the ultra-competitive top 30 to have switched over by now. (Anecdotally, it seems some competitors have achieved better word per minute high scores after switching.)

There are other ways of circumventing the problem of varying skill. Three studies carried out in three different decades with three different methodologies show very similar results.

Kinkead (1975) recorded 22 people doing standardised typing tests (presumably on QWERTY keyboards).[^25] He then looked to see which digrams were faster/slower to type and estimated how fast typing would have been on a Dvorak keyboard (assuming that digram typing speed remains constant for two physical keys, even if the characters they represent change).[^26] He found that the Dvorak keyboard would need around 2.6% less time to type the same thing as the QWERTY keyboard, however the "ideal" keyboard (based on the recorded data) would be 7.6% faster than QWERTY.[^27] I am somewhat sceptical of this study, partly because of the small sample and partly because I don't know if it captures all the ways in which Dvorak could be better than QWERTY (e.g. maybe some trigrams are significant in a way that considering only digrams doesn't capture).

I don't have access to the original paper, but in Liebowitz & Margolis, the authors note a study by Norman & Rumelhart (1983) that found a 5% typing speed advantage for Dvorak over QWERTY, and a 2%-9% advantage for QWERTY over alphabetically sorted layouts.[^28] They write: "For the expert typist, the layout of keys makes surprisingly little difference. There seems no reason to choose [QWERTY], Dvorak or alphabetically organized keyboards over one another on the basis of typing speed. It is possible to make a bad keyboard layout, however, and two of the arrangements that we studied [not sure which layouts they refer to here] can be ruled out."[^29]

Cho (2014) presents an interesting study design.[^30] Remember the problem of people already knowing QWERTY really well, making it hard to do a fair comparison. The trick Cho does is basically to (1) transpose words typed on Dvorak to a QWERTY keyboard (so the same physical keys need to be struck, though all the words are now gibberish) and (2) do something similar for QWERTY, except transposing the QWERTY words to a mangled version of QWERTY that more or less retains the same characteristics.[^31] I think this is smart and does a pretty good job of testing the designs while reducing familiarity effects. The main result is in this chart. (Numbers one to 15 represent the 15 test subjects; "untransformed" refers to QWERTY as we know it, whereas "QWERTY" refers to the mangled version.[^32])

![From Cho (2014).]({{ '/img/qwerty_cho.png' | url }})

As far as I can tell, that shows three out of the 15 typing faster with the mangled QWERTY, and the other 12 typing faster with the transposed Dvorak. But the difference looks small (around 5% which is similar to the earlier studies). The author does a quick Fermi estimate:

> Assuming a person [types] 1,000 words a day, typing will solely take about 15 minutes a day. If that person can save 10% of typing time by changing to Dvorak, he or she can save 1.5 minutes a day, 45 minutes a month, and finally 9 hours a year. It means this time saving might be overwhelmed by the cost of changing the layout.[^33]

How much time do we actually spend typing? Xah Lee logged his keyboard use for two years and [found](http://xahlee.info/kbd/how_many_keystrokes_programers_type_a_day.html) that he typed roughly one hour per day (assuming 50 words per minute). Now, that is likely an underestimate as it only records the stuff he wrote in Emacs, but he also reports spending 13 hours a day in front of the computer, much of it likely in Emacs. Most people probably type significantly less. A 5% improvement for Xah Lee would save him around 18 hours per year, which is not bad, but also the upper end of what one might expect.

In sum, I think there's a good chance that touch-typists, after a period of relearning, can type faster with Dvorak and Colemak than with QWERTY. But I also think switching over would be unlikely to lead to noticeable productivity boosts (with perhaps a few exceptions).

## Concerns

I'm sure by now you're itching to point something out. Before you do, let me try to security test my own review.

### What's the Cost of Transition?

Some people find switching to a new key layout a real struggle. You have to rewire your muscle memory, and QWERTY is wired real hard. Studies I found report anywhere from two and 24 days to regain one's typing speed.[^34] When I switched from QWERTY to Colemak, I did it cold turkey and typed all day in the new layout, and it still took me something like a week until I was comfortable and two weeks until I had regained my former speed. This is definitely a drawback of switching, though not an insurmountable one. Note however that this cost of transitioning does not make QWERTY a better key layout – it only makes sticking with QWERTY a better choice than it would have been otherwise.

### What's the Cost of Not Sticking to the Universal Standard?

You might think, "Isn't it annoying to use an alternative design when the whole world was built with QWERTY in mind?" I think the concern here is that you might unlearn QWERTY but still occasionally need to use it, for example when borrowing a computer or typing on a phone. I've tried to think of ways that this could be a serious problem but cannot. For some reason it's easy for me to switch between Colemak on the computer and QWERTY on the phone. Colemak and Dvorak both come pre-installed on Mac and most Linux distros, and seem easy enough to install on Windows. And if I just need to type something out quickly on a QWERTY keyboard, I usually manage ok, and if not, the keys are all there, anyway.

### What If You're Bilingual?

Alternative designs like Colemak and Dvorak were optimised for typing English, but many people do most of their typing in multiple languages. What should they (we, actually) do? QWERTY has lots of variants with special characters for different languages; alternative designs are usually one-size-fits-all solutions where special characters are typed via so-called dead keys (in other words, via multiple keys in succession). (Of course it's possible to customise one's key layout, but that's only an option for technical people with time on their hands, like me.)

I think the answer here is: it depends. For me, using Colemak for Swedish and German in addition to English has been fine, but I do most of my typing in English, and Swedish and German are both Germanic languages that have similar letter frequencies to English's and few additional characters. If you are sometimes writing Turkmen, say, you may have to switch between layouts if you want to use something like Colemak or Dvorak for English. There seem to be few modern layouts optimised specifically for non-English languages.

## Conclusion

In a real sense, the stakes here are quite high. Even if alternative key layouts only provide a small benefit, and even if the transaction cost is too high to make it worthwhile for any one individual to switch, the costs for society could be significant. There are billions of people out there typing suboptimally, all day, every day. If we were ever given a clear sense of the loss involved in doing something slightly suboptimally over vast periods of time, we might tremble and rue those lost riches. But as it is, the effects are too diffused for us to see them.

I have been hedging a lot in the preceding sections. That is because I am still uncertain about much of this, mostly due to the dearth of empirical evidence. But if you are a believer in revealed preferences, know this. While researching this article, I came across [the QWYRFM layout](http://mkweb.bcgsc.ca/carpalx/?partial_optimization), a product of the aforementioned Carpalx project. One week or so ago I switched from Colemak to typing on QWYRFM due to the reduced load it places on the pinkies. I have been typing on it since then, both on and off the clock. In fact, I have written most of this review on QWYRFM. And not only am I not finding it a struggle to switch, but I am even sort of enjoying the experience.

[^1]: I will only look at RSI here. Obviously there is more to ergonomics than that, but RSI seems widespread and bad and well-defined enough that it's worth focusing on.
[^2]: As with ergonomics, there is more to key layout and productivity than typing speed (maybe it's even advantageous to type in a slow and steady pace rather than in quick bursts), but speed seems like a significant component of productivity, so I will focus on it here.
[^3]: Yasuoka, K., & Yasuoka, M. (2011). On the Prehistory of QWERTY. _Zinbun_, _42_, 161-174.
[^4]: ibid.
[^5]: ibid.
[^6]: Liebowitz, S. J., & Margolis, S. E. (1990). The fable of the keys. _The Journal of Law and Economics_, _33_(1), 1-25.
[^7]: Shieh, K. K., & Lin, C. C. (1999). A quantitative model for designing keyboard layout. _Perceptual and motor skills_, _88_(1), 113-125.
[^8]: ibid.
[^9]: But note that there really are a lot of judgment calls here. As Xah Lee [puts it](http://xahlee.info/kbd/most_efficient_keyboard_layout.html): "When you study keyboard layout as Carpalx did, one thing quickly becomes obvious. The difficulty in creating the 'most efficient' [layout] isn't about computing distances or gathering statistics, but making subtle judgement on what's considered more efficient. For example, is minimizing distance of finger travel more important than alternating hands? How [much importance] do we assign to ease of bigram [typing]? What weight should we attach to avoiding single-finger repetition? Should the key J and K have [an] ease-of-press score difference of 0.1 or 0.2?"
[^10]: Van Tulder, M., Malmivaara, A., & Koes, B. (2007). Repetitive strain injury. _The Lancet_, _369_(9575), 1815-1822.
[^11]: Fagarasanu, M., & Kumar, S. (2003). Carpal tunnel syndrome due to keyboarding and mouse tasks: a review. _International Journal of Industrial Ergonomics_, _31_(2), 119-136.
[^12]: ibid.
[^13]: ibid.
[^14]: ibid.
[^15]: Barcenilla, A., March, L. M., Chen, J. S., & Sambrook, P. N. (2012). Carpal tunnel syndrome and its relationship to occupation: a meta-analysis. _Rheumatology_, _51_(2), 250-261.
[^16]: Battista, E. B., Yedulla, N. R., Koolmees, D. S., Montgomery, Z. A., Ravi, K., & Day, C. S. (2021). Manufacturing Workers Have a Higher Incidence of Carpal Tunnel Syndrome. _Journal of occupational and environmental medicine_, _63_(3), e120-e126.
[^17]: Wright, A. R., & Atkinson, R. E. (2019). Carpal tunnel syndrome: An update for the primary care physician. _Hawai'i journal of health & social welfare_, _78_(11 Suppl 2), 6.
[^18]: Battista, E. B., Yedulla, N. R., Koolmees, D. S., Montgomery, Z. A., Ravi, K., & Day, C. S. (2021). Manufacturing Workers Have a Higher Incidence of Carpal Tunnel Syndrome. _Journal of occupational and environmental medicine_, _63_(3), e120-e126.
[^19]: Thomsen, J. F., Gerr, F., & Atroshi, I. (2008). Carpal tunnel syndrome and the use of computer mouse and keyboard: a systematic review. _BMC musculoskeletal disorders_, _9_(1), 1-9.
[^20]: Wright, A. R., & Atkinson, R. E. (2019). Carpal tunnel syndrome: An update for the primary care physician. _Hawai'i journal of health & social welfare_, _78_(11 Suppl 2), 6.
[^21]: Wærsted, M., Hanvold, T. N., & Veiersted, K. B. (2010). Computer work and musculoskeletal disorders of the neck and upper extremity: a systematic review. _BMC musculoskeletal disorders_, _11_(1), 1-15.
[^22]: Trillos-Chacón, M. C., Castillo-M, J. A., Tolosa-Guzman, I., Medina, A. F. S., & Ballesteros, S. M. (2021). Strategies for the prevention of carpal tunnel syndrome in the workplace: A systematic review. _Applied Ergonomics_, _93_, 103353.
[^23]: Pan, C. S., & Schleifer, L. M. (1996). An exploratory study of the relationship between biomechanical factors and right-arm musculoskeletal discomfort and fatigue in a VDT data-entry task. _Applied ergonomics_, _27_(3), 195-200.
[^24]: Feng, B., Chen, K., Zhu, X., Ip, W. Y., Andersen, L. L., Page, P., & Wang, Y. (2021). Prevalence and risk factors of self-reported wrist and hand symptoms and clinically confirmed carpal tunnel syndrome among office workers in China: a cross-sectional study. _BMC Public Health_, _21_(1), 1-10.
[^25]: Kinkead, R. (1975, October). Typing speed, keying rates, and optimal keyboard layouts. In _Proceedings of the Human Factors Society Annual Meeting_ (Vol. 19, No. 2, pp. 159-161). Sage CA: Los Angeles, CA: SAGE Publications.
[^26]: ibid.
[^27]: ibid.
[^28]: Liebowitz, S. J., & Margolis, S. E. (1990). The fable of the keys. _The Journal of Law and Economics_, _33_(1), 1-25.
[^29]: ibid.
[^30]: Cho, H. (2014). _Comparing QWERTY and Dvorak Keyboard Speed: a Pilot Study_ (Doctoral dissertation, 서울대학교 대학원).
[^31]: ibid.
[^32]: ibid.
[^33]: ibid.
[^34]: Liebowitz, S. J., & Margolis, S. E. (1990). The fable of the keys. _The Journal of Law and Economics_, _33_(1), 1-25.
