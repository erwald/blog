---
layout: layouts/post.njk
title: It Did Not Take Matt Bruenig and Jon White Two Days to Make a Good Child Tax Credit Website
date: 2021-07-24
tags: post
---

# It Did Not Take Matt Bruenig and Jon White Two Days to Make a Good Child Tax Credit Website

I am often voyaging into areas where I am not an expert, and I often get things wrong or overlook subtleties, so it is always nice when the universe grants me the higher ground, so to put it, letting _me_ be the expert pointing out some confusion in the work of a holidaying writer. (The world would undoubtedly be a better place if every conversation, and perhaps even every entry into a journal or diary, was tenderly guarded by an expert in its subject matter.) The occasion this time was my reading a [blog post](https://www.peoplespolicyproject.org/2021/06/23/it-took-two-days-to-make-a-good-ctc-website/) by Matt Bruenig about the U.S. Internal Revenue Service's (IRS) Child Tax Credit (CTC) sign-up website for people who haven't filed a tax report.

I want to be careful here, because Bruenig is, I think, an excellent and insightful writer and policy analyst, as is shown, for example, [in](https://www.peoplespolicyproject.org/2021/02/04/romneys-child-allowance-improves-on-biden-proposal/) [his](https://www.peoplespolicyproject.org/2021/02/05/romneys-child-caps-and-phase-outs-are-pointless/) [previous](https://www.peoplespolicyproject.org/2021/02/08/the-newest-ctc-proposal-is-still-a-mess/) [posts](https://www.peoplespolicyproject.org/2021/02/19/oren-cass-wants-child-benefits-for-everyone-but-the-poor/) [on](https://www.peoplespolicyproject.org/2021/04/30/parent-carers-really-should-get-child-care-benefits/) [the](https://www.peoplespolicyproject.org/2021/05/03/sunset-the-eitc-not-the-ctc/) [CTC](https://www.peoplespolicyproject.org/2021/05/17/irs-confirms-major-ctc-participation-problems/). I agree with most of what is written in this latest post, too. But I think he underestimates the amount of work that goes into a website like the one he is criticising, and I think a more accurate picture will blunt the force of his critique.

He describes the situation like this:

> Earlier this year, the Biden administration signed into a law a reform of the Child Tax Credit that increased benefit amounts from $2,000 per year to $3,000 per year, made the payments available monthly, and made the poorest families in the country eligible for the program. In their messaging, the administration mostly touted the latter reform, claiming that it would cut child poverty in half.
>
> But making poor people eligible for the program is not the same thing as enrolling them in it. Many poor people do not file tax returns and so the IRS does not have their information on file. The IRS also does not have benefit offices sprinkled throughout the country because they are a tax agency and because they effectively outsource the customer service aspects of tax-filing to private companies like H&R Block and Liberty Tax Service that operate seasonal offices.
>
> Given all this, the only thing the IRS could really do was set up a website for non-filers to sign up for the new CTC and hope that those non-filers find their way to it. They had months to set up this [website](https://www.freefilefillableforms.com/#/fd/childtaxcredit). And this was the result of their efforts.

He then presents us with this screenshot:

![Screenshot of the IRS's CTC non-filer sign-up tool.]({{ '/img/irs_csc_website_screenshot.png' | url }})

It is not easy to deconstruct a masterpiece, but if I had to pick a favourite thing about this site it would have to be the vast pale-blue sidebar, the space of which is expertly used to display two tiny links. (I would have picked the repeating background gradient, but it does not actually repeat when viewed in a browser; I assume this is an artefact of Bruenig's having stitched together two screenshots in order to cover the whole height of the page.) Here is Bruenig again:

> As Michelle Singletary reported at the Washington Post, this website is a [disaster](https://webcache.googleusercontent.com/search?q=cache:https%3A%2F%2Fwww.washingtonpost.com%2Fbusiness%2F2021%2F06%2F15%2Firs-child-tax-credit-tool%2F). Among other things:
>
> 1. The website is not hosted on a .gov address. Instead, it is hosted at freefilefillableforms.com.
> 2. The website's URL, design, and lack of any indication that it has a formal affiliation with the IRS makes it look like a phishing scam.
> 3. The website does not work on mobile devices even though poor people are far less likely to access the internet through laptop or desktop computers.
> 4. The website is not available in Spanish even though Spanish speakers are overrepresented among non-filers.
> 5. The website does not work with a screen reader.
> 6. The website hits you with a wall of complicated and intimidating text and rules, including a literal caution box in the center.

Bruenig then goes on to describe [an alternative site](https://www.peoplespolicyproject.org/projects/childtaxcredit/), commissioned by Bruenig and created by Jon White, which the latter delivered, so the former reports, after a mere 13 hours and 20 minutes of work:

> The site works on mobile, is available in Spanish, is not designed to look like a phishing website, is simple and inviting, and replaces the complicated set of eligibility rules with question prompts. The site eventually links back to the account creation page on freefilefillableforms.com because we don't have e-file abilities here at People's Policy Project. But the point remains: it is neither difficult nor time-consuming to create a website that doesn't suck. That the IRS failed to do so should be seen as a scandal.

It _is_ unfortunate that the IRS could not accomplish anything better than that abysmal mess of a website, but it is not really true that it is "neither difficult nor time-consuming to create a website that doesn't suck", or at least Bruenig and White's experiment does not prove that. What Bruenig and White have made is a prototype of a website, or, actually, a prototype of the introductory part of a website, because I assume there is some kind of form for users to fill out after they have registered. The title of Bruenig's post is "It Took Two Days to Make a Good CTC Website", but a website is more than an arrangement of pixels. Off the top of my head, a real, fully functional alternative to the IRS's CTC tool would need:

- authentication, including email validation;
- a database, including a system for backing up and, if necessary, restoring data;
- input validation;
- integrations with some other system or systems that consume the entered data (and/or some sort of reporting for manual use); and
- tools for monitoring and/or logging activity.

All these things are whatever the non-tip part of an iceberg is. Of course we cannot blame Bruenig for underestimating the amount of work that goes into a piece of software. That is something that software engineers do _all the time_. But while White's prototype is clearly superior to the original website in its design, it is not superior as a website, for it is not a website.
