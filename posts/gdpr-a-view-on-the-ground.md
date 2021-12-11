---
layout: layouts/post.njk
title: "GDPR: A View on the Ground"
date: 2021-12-11
tags: post
---

# GDPR: A View on the Ground

I think a lot of people don't really know what effect the "toughest privacy and security law in the world"[^1] – the General Data Protection Regulation (GDPR) – has actually had on the software industry. I don't know either, but I do know the effect it's had on the tiny corner of it in which I have worked. So perhaps I can shed a tiny bit of light by way of an example.

In my previous job, I worked on a project for a major European tech company. The project started before GDPR came into effect, and we had to adapt to it on the fly. The company was more or less a "good actor" in the sense that its employees and culture had some understanding of and concern for users' interests. This was good because the product we built handled sensitive user data. But of course the company's purpose was ultimately to turn a profit. This is all just to say that it probably wasn't the median company, and I am uncertain about whether my experience generalises.[^2]

The good:

- GDPR kept our attention focused on privacy in a way it would not otherwise have been. Any decisions involving the collection and processing of user data, as well as related questions of consent and security, needed to take it into account. This involved thinking about what user data we needed exactly, how to store and use it, how long to keep it around, etc. You'd often hear the question, "And what about GDPR?"
- We prepared a data retention policy and actually regularly hid and deleted user data. (Why not only delete data? One user's data was deeply intertwined with other users' data, and partly visible to them; some data also had to be kept for longer for auditing purposes; therefore, we sometimes could only hide data before we could fully delete it.)
  - To be clear, this was not solely downstream of GDPR. Internal business needs also affected the policy.
- In at least one instance, we decided not to add tracking to a web app partly because we would also need to add a cookie banner, which we didn't want.
- Following Article 15's right of access, we allowed users to request access to (very nearly) all the data we stored about them; a number of them took us up on this offer.

The bad:

- GDPR created a lot of complexity and added work, not only for engineers but also for product owners, customer support and legal. I mention this not because I dislike exerting effort, but because there is an opportunity cost in making a bunch of people spend a bunch of time on work that may not be very meaningful.
  - This was especially the case when the data model as the user saw it was different from the one being stored on disk. For example, you might have wanted to retain an "object" (something that appeared as a single thing to the user) for a certain amount of time and then realise that it is stored in multiple database tables, alongside data that you want to retain for different amounts of time.
  - Processing data access requests, although we automated parts of this, was also time-consuming, both for engineers and customer support. This was partly because, again, each user's data was deeply connected with other users' data – remember, user data was very sensitive – and partly also because the data model had changed in the past, such that older records needed to be manually cross-checked against records in another system (to which we didn't have direct access).
  - We needed to write additional code for handling data visibility and deletion. This code could get pretty complicated if different data objects were handled differently in the data retention policy, as was sometimes the case.

This might be a clue as to why there has been so much disagreement around the question of whether GDPR is good. That is because you have a really complicated cost-benefit calculation on your hands – that is, unless you specify _for whom_ it is supposed to be good. It seems pretty likely to me that GDPR is good _for users_, or at least those users who care about data and privacy, but also _not_ good _for businesses_, or at least those businesses that deal with sensitive user data. I don't know whether it's good in the absolute sense.

There is of course one additional reason that GDPR is bad for businesses, and that is that it deprives them of a major – if not their main – source of revenue. That, for example, was why, a few weeks before GDPR came into effect, Facebook apparently "transferred 1.5 billion user profiles from its international headquarters in Ireland to its American offices in California".[^3] Facebook chose not to be GDPR compliant everywhere, but instead formulated its own global data policy. "We’re still nailing down details on this, but it should directionally be, in spirit, the whole thing", said Mark Zuckerberg.[^4] But Facebook has time and again tried to evade and obstruct GDPR enforcement.[^5] Businesses that rely on user data might say that restrictions on data collection and use damages their business model. A GDPR advocate might reply that this is the point.

To me, using somebody's data without their informed consent is wrong.[^6] The way it works, or used to work, with many of these services is that they offer an enticing free product which surreptitiously collects user data. It's not that users don't consent – it's that they don't even get the opportunity to consent, because they don't know what data is being collected or what purpose it's being used for. The service provider is furthering its own ends without concern for the users' interests. In Kantian terms, they violate the Formula of Humanity – they treat their users as mere means to generate revenue, and not as ends in themselves.

If another person's interests matter to you, you ask them before doing something with them or to them of which they might disapprove. That is what treating a person with respect means. By their conduct, people and organisations who collect and use our data without our informed consent show that they don't care about us. They have no respect for us. We are only unwitting value producers or something like that.

Needless to say, this website – my blog – does not store any information about you, the reader. (Not unless you are [Tom Cruise]({{ '/posts/the-sadness-of-tom-cruise/' | url }}), at least, but even with you, Tom, we are only talking about publicly available information.) It does track page views. But it does this without storing any user data, without using cookies and without being able to recognise the same user on different days. This would have been the case even if GDPR had never existed.

[^1]: This is from [GDPR.eu](https://gdpr.eu/what-is-gdpr), a project funded but not run by the European Union.
[^2]: People have [pointed out](https://archive.md/VaS0E) that GDPR has not been strictly and forcefully enforced, so it's possible that businesses who choose not to do anything about GDPR don't really get punished for it. That would be pretty bad, because it means bad actors gain a competitive advantage.
[^3]: My source here is Sue Halpern's [article](https://archive.md/20210512042557/https://www.nybooks.com/articles/2018/09/27/privacy-technology-known-known/). I wasn't able to find the original source. I am not sure exactly what this means, but I assume the data was previously stored in the EU, and is now stored in the US.
[^4]: ibid.
[^5]: See for example reports on [data breach handling](https://gdpr.eu/the-gdpr-meets-its-first-challenge-facebook/), [attempts to avoid data collection protections by modifying its terms and conditions](https://www.securityweek.com/has-facebook-sidestepped-gdprs-user-consent-requirements), [lack of transparency](https://archive.md/20210906021254/https://www.nytimes.com/2021/09/02/business/facebook-whatsapp-privacy-fine.html) and [legal delay tactics](https://archive.md/VaS0E).
[^6]: Informed consent obviously does not include shoving something in the middle of a terms and conditions agreement.
