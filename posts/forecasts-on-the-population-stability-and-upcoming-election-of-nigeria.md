---
layout: layouts/post.njk
title: Forecasts on the Population, Stability and Upcoming Election of Nigeria
date: 2023-02-01
tags: post
---

# Forecasts on the Population, Stability and Upcoming Election of Nigeria

![img]({{ '/img/nigeria.jpeg' | url }})

This post explains my reasoning on three forecasts I made on questions that have to do with Nigeria. I spent ~1 hour on the first two questions and ~3 hours on the third question, having had little prior knowledge. The questions are:

- Will Nigeria's population exceed 400 million before 2050? I give 32% probability that it will.
- Will Nigeria have a successful coup before 2025? I give 5% probability that it will.
- Who will win the 2023 Nigerian Presidential Election? I give Bola Tinubu 45%, Peter Obi 34%, Atiku Abubakar 20% and Rabiu Kwankwaso 1%.

## Nigerian Population >400M by 2050

[Will Nigeria's population exceed 400 million before 2050?](https://www.metaculus.com/questions/2632/will-nigerias-population-exceed-400-million-before-2050/)

As of 2021, Nigeria has a population of 213.4M, making it the sixth most populous nation. (That's an estimate; Nigeria [hasn't had a census since 2006](https://archive.ph/FRbfL), though it's [planning one this year](https://archive.is/zzrIv).) Out of the ten most populous countries, Nigeria has the highest year-on-year growth rate at +2.4%, with a comfortable lead. But that growth rate has been mostly slowing since at least 1980, and so has its [death rate](https://ourworldindata.org/grapher/crude-death-rate-the-share-of-the-population-that-dies-per-year?tab=chart&country=NGA) since at least 1950, pointing to a [demographic transition](https://en.wikipedia.org/wiki/Demographic_transition).

![img]({{ '/img/nigeria_population_growth_rate.jpeg' | url }})

There's no point beating around the bush. The [UN population projection](https://population.un.org/wpp/Graphs/Probabilistic/POP/TOT/566) has a median estimate of 372M for 2049

![img]({{ '/img/nigeria_population_projection.png' | url }})

with a [steadily declining growth rate](https://population.un.org/wpp/Graphs/Probabilistic/POP/GrowthRate/566)

![img]({{ '/img/nigeria_population_growth_rate_projection.png' | url }})

which makes for about 35% probability of >400M before 2050 (reconstructing their probability distribution using the median and 80% confidence interval numbers and assuming a not-quite-correct normal distribution). That's for their medium-fertility scenario, which I think is the most plausible one.

The population team at the UN seems to have done a good job: they use historical census[^1] data to estimate fertility, mortality and migration rates (using Bayesian hierarchical models, no less), and then do a bunch of careful-seeming consistency checks (e.g. to make sure the total net world migration is 0) and adjustments (e.g. to account for young children being systematically undercounted).

I assume they do not account for the possibility of transformative AI when making their population forecasts. I assign a [substantial probability that we get transformative AI](https://www.cold-takes.com/where-ai-forecasting-stands-today/) by 2050. It's far from obvious how that affects Nigeria's population growth, but it seems more likely than not that its growth would slow more in a world with transformative AI than in a world without it, for example due to [explosive economic growth](https://www.cold-takes.com/the-duplicator/) driving a rapid decrease in total fertility rates, or a [global catastrophe](https://www.cold-takes.com/ai-could-defeat-all-of-us-combined/) causing the deaths of a substantial portion of the world population.

I'll suppose the probability that Nigeria's population exceeds >400M by 2050 is 30% in the world where transformative AI arrives by 2040, and 35% in worlds where it arrives later than that, or not at all. That gives me a combined, unconditional probability of 32%.

<table width="100%" border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">

<colgroup>
<col  class="org-left" />

<col  class="org-right" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">Source</th>
<th scope="col" class="org-right">Prediction</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-left">Me</td>
<td class="org-right">32%</td>
</tr>

<tr>
<td class="org-left">Metaculus community</td>
<td class="org-right">36%</td>
</tr>
</tbody>
</table>

## Nigerian Coup by 2025

[Will Nigeria have a successful coup before 2025?](https://www.metaculus.com/questions/9589/nigerian-coup-b-2025/)

The base rate of successful coups since independence (1960-2022) is ~7.2% annually (depending on how you count). That shakes out to ~14% probability that there's a successful coup before 2025 (so, this year or next). But:

- There have been no coups in the last ~30 years or since the restoration of democracy in 1999. (There was apparently one foiled coup plot in 2004.)
- Lucky Irabor (head of the Nigerian Armed Forces) [said last month](https://archive.ph/yOtws): "Never again will we see men in uniform take power. [...] Democracy has come to stay; a government of the people, by the people and for the people has come to stay. That is an assurance, and then of course for the elections, I am sure you know that the police are on the lead."
- Most of the probability mass is probably around this year's election (see next section). For example, there could be widespread protests as a result of election fraud, causing the military to take over in response (in the style of the 2020 Malian coup d'état, sort of). But this seems like it'll be the best-run election since the establishment of democracy in Nigeria.

So I adjust down to 5%.

<table width="100%" border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">

<colgroup>
<col  class="org-left" />

<col  class="org-right" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">Source</th>
<th scope="col" class="org-right">Prediction</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-left">Me</td>
<td class="org-right">5%</td>
</tr>

<tr>
<td class="org-left">Metaculus community</td>
<td class="org-right">12%</td>
</tr>
</tbody>
</table>

## Nigerian Presidential Election 2023

[Who will win the 2023 Nigerian Presidential Election?](https://www.metaculus.com/questions/14493/nigerian-presidential-election-2023/)

Nigeria has a fascinating and important presidential election (to be held on February 25th) coming up:

- Nigeria is Africa's largest country by population, and sub-Saharan Africa's largest economy measured by PPP-adjusted GDP.
- For the first time since the restoration of democracy in 1999, there are three credible candidates vying for the presidency.
- In particular, there's a youth-led movement, sprung from the [End SARS](https://en.wikipedia.org/wiki/End_SARS) protests, supporting an unexpectedly competitive third candidate, Peter Obi.
- This _may_ change the dynamics of Nigerian politics, for example to shift it away to some degree from its customary ethnic and religious voting patterns.

The main candidates are:

<table width="100%" border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">

<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-right" />

<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">Name</th>
<th scope="col" class="org-left">Party</th>
<th scope="col" class="org-right">Age</th>
<th scope="col" class="org-left">Religion</th>
<th scope="col" class="org-left">Ethnicity</th>
<th scope="col" class="org-left">Notable experience</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-left">Atiku Abubakar</td>
<td class="org-left">PDP</td>
<td class="org-right">76</td>
<td class="org-left">Muslim</td>
<td class="org-left">Hausa/Fulani (north)</td>
<td class="org-left">Vice president (1999-2007)</td>
</tr>

<tr>
<td class="org-left">Rabiu Kwankwaso</td>
<td class="org-left">NNPP</td>
<td class="org-right">66</td>
<td class="org-left">Muslim</td>
<td class="org-left">Hausa/Fulani (north)</td>
<td class="org-left">Kano Governor (1999-2003, 2011-2015)</td>
</tr>

<tr>
<td class="org-left">Peter Obi</td>
<td class="org-left">LP</td>
<td class="org-right">61</td>
<td class="org-left">Christian</td>
<td class="org-left">Igbo (south-east)</td>
<td class="org-left">Anambra Governor (2006, 2007-2014)</td>
</tr>

<tr>
<td class="org-left">Bola Tinubu</td>
<td class="org-left">APC</td>
<td class="org-right">70</td>
<td class="org-left">Muslim</td>
<td class="org-left">Yoruba (south-west)</td>
<td class="org-left">Lagos Governor (1999-2007)</td>
</tr>
</tbody>
</table>

There's no perfect candidate in any political race, but there's especially no perfect candidate in this race. My impression (and this is truly a low-confidence take) is that Peter Obi is pretty competent and honourable. Kwankwaso I don't know much about. Tinubu and Abubakar are antique and ["tainted by the system"](https://archive.is/TCKaQ). Even Obi has been [implicated](https://archive.is/DFa2r) in shell corporation shenanigans, though at least he didn't have [armoured vehicles bring cash to his residence](https://archive.is/Y8T1F) at the height of an election season ... I could of course be wrong about any of them.

Either way, whoever wins won't be much worse than what came before, for there's a widespread sense that the outgoing president, Muhammadu Buhari, [has done a bad job of it](https://archive.is/7v77V#selection-677.132-677.743):

> [Buhari] has floundered on almost every measure. Between 2015 and 2020 the average income per person (adjusted for local purchasing power) slid from $5,400 to $4,900 a year. The share of Nigerians living on less than $1.90 a day, which had fallen from about 43% to 37% in the previous five years, increased to almost 40% in 2019, before covid-19 hit. Violence has spread across the country. Last year jihadists, bandits, and separatists hit at least 550 of the country's 774 local government areas. More than 3,000 people were kidnapped last year, an almost thirty-fold increase on 2016. Many were children.

Bola Tinubu is the candidate for Buhari's party, and I expect his predecessor's failures will hurt him a bit. But it may not be enough: pundits generally hold him to be the frontrunner.

Tinubu gives the impression of one who thinks he is due the presidency. In one sense at least he is right. Nigeria is about half Christian, half Muslim (49.3% Christian, 48.8% Muslim). The north is generally more Muslim, poor and rural. The south has four of the nation's five largest cities, including the massive Lagos metropolitan area. The custom has been for every other president to be a northern Muslim, and every other a Christian from the south. Tinubu is a southerner, so he is due in that sense, though he is also a Muslim.

He's got other advantages too. Here's [Ebenezer Obadare](https://archive.ph/AXFD2):

> Patronage and politics are Siamese twins in (Nigerian) politics, and, with the possible exception of Abubakar, arguably no other Nigerian politician of his generation has spent more resources than Tinubu to lubricate the great machine of political patronage. Yet, not only, invariably, has Tinubu been unable to pacify every segment of the Nigerian society, but the source of his stupendous wealth is also a perennial bone of contention. For every Nigerian who insists that Tinubu's wealth is ill-gotten, there is another one who counters that he merely typifies a political class that is rotten to the bone.

Connections, favours, organisation and money [matter](https://archive.ph/tubqd):

> Nigeria is a complex heterogeneous country where winning elections often involve building a financial war chest, which can be utilised to lubricate alliances of loyalty and patronage. These structures are expected to provide the necessary leverage for winning elections. For instance, Nigeria's ruling All Progressives Congress (APC) is currently in charge in 22 out of 36 states of the country. The constitutional requirement for the winner of the presidential election is that the individual must score the highest number of votes and a required 25% of the votes in at least 24 (two-thirds) of the states in the country. Coming into the contest with 22 governors confers a considerable advantage on the ruling party's candidate.

While most pundits think Tinubu will win, the second strongest contender is generally seen to be Atiku Abubakar. Abubakar has been running in Nigerian national elections for decades, and was vice president of Nigeria between 1999 and 2007. (That was under president Olusegun Obasanjo, who'd previously led the country under military rule in the 70s; Obasanjo, whom I've seen described as a "wannabe Mandela", made a bit of a splash recently when he endorsed Peter Obi.) Here's [Ebenezer Obadare](https://archive.ph/pbFr3) again:

> [Abubakar] is a known quantity to the political elite, among whom he is openly extolled for his generosity and unswerving loyalty to friends and political associates. Furthermore, and not unlike Bola Tinubu, the All Progressives Congress (APC) candidate with whom he is most often compared, Abubakar is a man of means; although, again similar to Tinubu, the source of his wealth is a subject of controversy. Finally, Abubakar has also managed to build an extensive political network. That he has, somehow, not been able to construct a distinct lineage, at least not in the manner of Tinubu, is one of the key differences between the two.

Abubakar has four wives and twenty-eight children. "I felt extremely lonely as a child," he's [said](https://en.wikipedia.org/wiki/Atiku_Abubakar#Marriages_and_personal_life) by way of explanation.

Another Nigerian convention is to have a split Muslim-Christian ticket. If the presidential candidate is a Muslim, the vice presidential candidate is a Christian, and vice versa. The Tinubu and Abubakar tickets are both Muslim-Muslim. That means the only credible ticket with a Christian is Peter Obi's. Peter Obi is an interesting candidate. His popularity transcends religion: he generates considerable excitement wherever he goes, but especially among the urban and the young. The "Obidient" cheer him at airports, mob his car and turn up in large numbers at rallies and town halls. If you search Spotify for "Obidient" you will find about fifty songs in his honour.

Peter Obi is first in most opinion polls, but everyone says Nigerian polls are unreliable, and there aren't many of them anyway. An example is [this December poll](http://anapfoundation.com/press-releases/peter-obi-consolidates-lead-in-a-fragmented-presidential-race) which has Obi at 23%, Tinubu at 13%, Abubakar at 10% and Kwakwaso at 2% (with 29% undecideds), though a lot of people in the south-west (38% of respondents there) refused to share who they'd vote for, which may indicate an undercount in the Tinubu number. I looked at a couple of older polls by the same organisation and they seemed pretty ok, enough that I think this is a fairly good signal.

The bookies give Tinubu 35%, Abubakar 32%, Obi 25% and Kwankwaso 1% (as of January 30th). I'm more bullish on Obi than they are, and more bearish on Abubakar.

Reasons to be bullish on Obi:

- I probably weigh the polls more heavily than pundits and bettors do.
- There's substantial grassroots and social media support for Peter Obi, which counts for something. (But not too much. I've been burned in this way before: I once boldly predicted that Andrew Yang's considerable grassroots and social media support would translate into electoral success, but as I recall he fizzled out after the first debate.)
- Obi is the only credible Christian candidate; Nigeria has 49.3% Christians, and Nigerians often vote along sectarian lines.
- Voter turnout seems like it may rise, with a slew of young first-time voters. Young voters seem to favour Obi.

Reasons to be bearish on Abubakar:

- I just don't see any advantage of his over Tinubu or Obi, except perhaps a little name recognition and hailing from the north.
- He's a perennial loser, having run for president of Nigeria five times before and lost (1993, 2007, 2011, 2015 and 2019).[^2]

To sum up:

<table width="100%" border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">

<colgroup>
<col  class="org-left" />

<col  class="org-right" />

<col  class="org-right" />

<col  class="org-right" />

<col  class="org-right" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">Source</th>
<th scope="col" class="org-right">Tinubu</th>
<th scope="col" class="org-right">Obi</th>
<th scope="col" class="org-right">Abubakar</th>
<th scope="col" class="org-right">Kwankwaso</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-left">Me</td>
<td class="org-right">45%</td>
<td class="org-right">34%</td>
<td class="org-right">20%</td>
<td class="org-right">1%</td>
</tr>

<tr>
<td class="org-left">Metaculus community</td>
<td class="org-right">60%</td>
<td class="org-right">23%</td>
<td class="org-right">22%</td>
<td class="org-right">2%</td>
</tr>

<tr>
<td class="org-left">Bookies</td>
<td class="org-right">35%</td>
<td class="org-right">25%</td>
<td class="org-right">32%</td>
<td class="org-right">1%</td>
</tr>
</tbody>
</table>

[^1]: The data actually comes not only from censuses, but also surveys, population registers and so on. But "census" is right to a first approximation.
[^2]: That is, Abubakar has either run as a candidate for president, or participated in the primaries to be nominated as a candidate.
