---
layout: layouts/post.njk
title: Building a Lightweight, Command-Line Newsletter Program
date: 2021-03-20
tags: post
---

# Building a Lightweight, Command-Line Newsletter Program

There are of course hundreds of newsletter services out there, the lich queen of them being MailChimp, which owns over half of the market share. But maybe you don't want to use proprietary software, or maybe you don't want to depend on an organisation that can [ban swathes of its users](https://www.inc.com/sonya-mann/mailchimp-icos.html) because of the (seemingly innocent) content they circulate. The alternative then is Mailtrain and other free and open source options. But these need to be self-hosted, have fairly involved installation procedures and are weighed down by far more features than people like myself ever need.

Me, I just wanted two things: for people to be able to subscribe to my newsletter and to be able to send emails to my subscribers. That's it. So I thought it might be fun to implement a simple command-line utility that accomplishes those two things. The result is `nwsl` (pronounced "newsletter").

The only prerequisite of `nwsl` is a mailbox. I get them from my domain name registrar, but you can just use a ProtonMail or Gmail account. The program uses the mailbox both for receiving subscriptions (and unsubscriptions) and for sending emails (though it can also be configured to use two separate mailboxes, one for each function). Prospective subscribers sign up by sending an email to this inbox with the word "subscribe" in the subject line. To unsubscribe, they repeat the process but with "unsubscribe" in the subject line. That's it – `nwsl` gets the list of subscribers by scanning the mailbox for these emails.[^1]

In order for this to work, the email's hostname and username need to be configured using `nwsl configure`:

```shell-session
$ nwsl configure --help
Usage: nwsl configure [OPTIONS]

  Edit the emailing config file. This starts the editor with the current
  contents of the config file. You can edit the following fields:

      sender - This is the sender name, probably the name of your
      newsletter.

      imap_host - The IMAP hostname of the subscriber-handling inbox.

      imap_user - The IMAP username of the subscriber-handling inbox.

      smtp_host - The SMTP hostname of the newsletter-sending email account.

      smtp_user - The SMTP username of the newsletter-sending email account. This is also used as the sender email address.

Options:
  --help  Show this message and exit.
```

Then one can get the list of subscribers using `nwsl subscribers`:

```shell-session
$ nwsl subscribers --imap-password=$IMAP_PASSWORD
one@example.net
two@example.net
three@example.net
```

The command that actually sends out emails to subscribers is `nwsl send-email`. This command takes one or two arguments, an HTML file and/or a plain text file. These files contain the content that shall be sent out. The rest is straightforward:

```shell-session
$ nwsl send-email ./newsletter.txt ./newsletter.html
IMAP password:
SMTP password:
Fetching emails for newsletter@example.net at mail.host.net

Want to send out newsletter to 3 subscriber(s):

# My Newsletter Title

This here is the plain text version ...

HTML body:

<html>
    <head></head>
    <body>
        <p>This here is the HTML version</p> ...

Do you want to proceed? [Y/n]: y
Sent "My Newsletter Title" to 3 subscriber(s)
```

Or one can pipe content into it,

```shell-session
$ cat ./newsletter.txt | sed -e 's/localhost:8080/www.mydomain.net/g' | nwsl send-email -
```

though this permits only one file and sends emails without first showing a confirmation prompt.

I use Eleventy to create this blog. Eleventy is a static site generator which, among other things, creates an HTML page for each blog post I put into the project directory (these posts are written in Markdown). It was pretty simple for me to generate an alternative HTML file for each post in addition to the one that's shown on this blog:

{% raw %}

```html
---
pagination:
  data: collections.post
  size: 1
  alias: post
permalink: newsletters/{{ post.fileSlug | pathify }}.html
eleventyExcludeFromCollections: true
---
<html>
    <head></head>
    <body>
        <p><i>You can read this post in all its glory <a href="https://www.erichgrunewald.com{{ post.url }}?ref=Newsletter">on the blog</a>. To unsubscribe, simply send an email to <a href="mailto:<REDACTED>"><REDACTED></a> with the word "unsubscribe" in the subject line.</i></p>
        <h1>{{ post.data.title }}</h1>
        {{ post.templateContent | formatForNewsletter | safe }}
    </body>
</html>
```

{% endraw %}

This is the Nunjucks template used in generating the HTML files I feed into `nwsl send-email`. The `formatForNewsletter` filter adjusts the post content for displaying it in emails, e.g. by replacing images with caption texts, removing anchor links and adding a ref parameter to all links pointing to my blog. So, having put a new post in my blog's directory, I can straightaway send it out to my subscribers with a simple terminal command. That's even easier than publishing it on the web, which requires me to commit and push!

There are, however, some limitations. For instance, subscribing is somewhat harder than with other services, it doesn't allow for segmenting subscribers into separate mailing lists and it hasn't been tested at scale. There are many features that want implementing, optimisations that want doing and documentation that wants writing. In short, this is an early alpha version. But for the core use case it works.

If you're feeling brave, you can subscribe to this blog. All you need to do is send an email with "subscribe" in the subject line to `newsletter AT erichgrunewald DOT com`. (It's also possible to subscribe via [RSS](https://www.erichgrunewald.com/feed.xml).)

You can read the Python source code for `nwsl` [here](https://github.com/erwald/nwsl). It's licensed under GNU GPLv3.

[^1]: This is an _O(n)_ operation. If I ever get enough subscribers that this starts becoming slow, I'll consider optimising it, maybe by implementing some sort of local cache.
