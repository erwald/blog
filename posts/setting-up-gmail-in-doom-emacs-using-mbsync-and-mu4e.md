---
layout: layouts/post.njk
title: Setting Up Gmail in Doom Emacs using mbsync and mu4e
date: 2021-11-06
tags: post
---

# Setting Up Gmail in Doom Emacs using mbsync and mu4e

<div class="edit">
<p>
Edit 2022-10-20: I no longer use mbsync/mu4e, mainly because (1) mu4e was buggy (or I used it badly) and (2) I never managed to integrate it with org-mode in a way that enhanced my productivity. That means (a) doing all this was indeed a waste of time and (b) <b>this guide may be outdated or broken</b> when you read this, as I am no longer maintaining it. That said, it might still be the best guide out there – only use at your own risk.
</p>

</div>

I can think of far better ways to spend a quiet Sunday afternoon than trying to get [Doom Emacs](https://github.com/hlissner/doom-emacs) to serve as an email client, but I couldn't at the time. So here I am scanning my inbox in the world's mightiest text editor. I am now able to access my email without an internet connection, although, true, I am never without an internet connection. I am now able to organise my email in neat folders, although, true, I keep everything in the same folder. I am now able to view email from all my accounts in one place, although, true, I really only use one account. Wait, why did I do this again? I must have been [under the influence of Drew DeVault](https://drewdevault.com/2016/04/11/Please-use-text-plain-for-emails.html).

It felt necessary to exorcise this demon by way of a blog post. And who knows? It might even be of use to somebody. In fact, I think I was a bit flippant just now. There are other advantages of using Emacs for email. One is a general advantage of Emacs, namely its enabling tight integration of different tools, in this case for example by linking directly to email from org-mode files. It also gives you a performant keyboard-first interface for reading and writing email, which is nice for those of us who prefer speed over latency and keyboards over mice.

The set-up has three main components. First there is a tool for downloading emails, for we shall mirror our inboxes, which are stored in the cloud somewhere, locally. For this we use [mbsync](https://isync.sourceforge.io/mbsync.html). Second, we need to index those locally stored emails so that we can quickly search through them. For this we use [mu](https://www.djcbsoftware.nl/code/mu/). Third, we need a way of viewing the emails and maybe even writing and sending new ones. For this we use [mu4e](https://www.djcbsoftware.nl/code/mu/mu4e.html), which comes bundled with mu.

Two small warnings. First, you are going to need to configure your Gmail account to allow "less secure app access". This allows third parties to access your email even if they are not on Google's list of approved consumers, so long as they have the account's password. Second, depending on the size of your inbox, your emails may take up quite a bit of disk space – around 15 GB for me.

Most of this, by the way, is outlined in the relevant Doom [docs](https://github.com/hlissner/doom-emacs/blob/develop/modules/email/mu4e/README.org), though I found it a little hard to follow. Certainly if there are any discrepancies between those docs and my instructions here, I am in the wrong and they are not.

## I. Configure Gmail

1. Go to [this Google support page](https://support.google.com/accounts/answer/6010255?hl=en) and enable "Less secure app access".
2. Go to your Gmail account and open Settings and make sure "Forwarding and POP/IMAP" has these options configured:
   - For "When I mark a message in IMAP as deleted", choose "Auto-Expunge off - Wait for the client to update the server."
   - For "When a message is marked as deleted and expunged from the last visible IMAP folder", choose "Move the message to the Bin."

## II. Install mbsync and mu/mu4e

(I provide installation instructions with [Homebrew](https://brew.sh/) as I am on Mac, but it should be similar for other Unix-likes.)

1. Install mbsync using `brew install isync`[^1].
2. Install mu using `brew install mu`.
3. Go to your `init.el` configuration file (you can use `M-x doom/open-private-config` which is bound to `C-c f P` for me). There, you'll want to uncomment `(mu4e +gmail)` (obviously removing the `+gmail` part if you are not using Gmail). Now open up your shell and run `doom sync`, then restart Emacs.

## III. Configure mbsync

1. Set up your mbsync configuration file in `~/.mbsyncrc`. This one is based on [Ben Maughan's file](http://pragmaticemacs.com/emacs/migrating-from-offlineimap-to-mbsync-for-mu4e/):

```
# imap account information
IMAPAccount gmail
Host imap.gmail.com
User example@gmail.com
Pass PutYourPasswordHere
AuthMechs LOGIN
SSLType IMAPS
CertificateFile /usr/local/etc/openssl/cert.pem

# remote storage (use the imap account specified above)
IMAPStore gmail-remote
Account gmail

# local storage
MaildirStore gmail-local
Path ~/.mail/
Inbox ~/.mail/Inbox
Subfolders Verbatim

# channel to remote storage
Channel gmail
Far :gmail-remote:
Near :gmail-local:
Patterns * ![Gmail]* "[Gmail]/Sent Mail" "[Gmail]/Bin"
Create Both
SyncState *
```

Note: if you haven't installed OpenSSL via homebrew, you may have your `cert.pem` file stored elsewhere. You may be able to find out where with something like `fd "^cert" --extension pem /usr` or `fd "^cert" --extension pem /opt` (using fd, which you can install with `brew install fd`).

### (Optionally) Store Your Password in an Encrypted File

If it feels icky to put down your password in plaintext in `.mbsyncrc`, you can instead store it in an OpenPGP-encrypted file.

1. Install gpg using `brew install gnupg`. (Note that Homebrew actually links `gpg` to `gpg2`, which is the command you would be using in Linux.)
2. If you haven't already, create a GPG key by typing `gpg --gen-key` into your terminal and following the steps you're presented with.
3. Generate a nice keyphrase using your password manager. (You are using a password manager, right? If not, I recommend having a look at [Bitwarden](https://bitwarden.com/).) Store the keyphrase in your password manager.
4. Put your email account password in a text file and encrypt that file using the email you used for your GPG key:

```shell-session
$ echo "my-password" > ~/.mbsync-pw-mailbox
$ gpg --encrypt --recipient "example@gmail.com" ~/.mbsync-pw-mailbox
```

5. This will generate an encrypted version of that file called `~/mbsync-pw-mailbox.gpg`. If you are curious, as I was, you can have a look at its contents:

```shell-session
$ hexdump ~/.mbsync-pw-mailbox.gpg
0000000 84 5e 03 48 75 ee 04 c0 fe 9a e7 12 01 07 40 47
0000010 77 27 84 6f e7 6a bc a4 d5 c1 40 36 b7 5a e7 d3
0000020 c0 25 4c 70 e6 6b 28 b5 f9 6f 90 92 14 56 41 30
0000030 46 5c 2e 9c ad 2f 18 15 83 78 ff 25 b0 a3 39 ff
0000040 d4 77 ef 6c 21 fa fb 9b 87 af 0c 17 e6 e5 ad 6e
0000050 aa e6 3f 5c c3 c1 30 d9 17 44 d5 ae 5d c0 42 f0
0000060 d4 55 01 09 02 15 6d f6 0e 58 f8 6c d3 95 f8 d8
0000070 3b 9f 75 34 35 23 b6 a1 27 7b f5 34 d3 7a 57 61
0000080 0a 16 0c 86 f0 49 c4 6d 07 4c 03 31 af f3 cf 6b
0000090 bf e7 9f fe 5a d5 b2 47 4b 1d 96 86 7a 6a f5 44
00000a0 24 44 1b f4 54 54 8e de 08 e8 04 92 2c 55 2b 16
00000b0 f3 1d e0 1a b3 3a 16
00000b7
```

6. Delete the file storing your password in plain text: `rm ~/mbsync-pw-mailbox`. You now have your email password stored in a safely encrypted file, and can pull it out at any time using your GPG key: `gpg --decrypt ~/.mbsync-pw-mailbox.gpg`
7. In `~/.mbsyncrc`, remove `Pass <INSERT YOUR PASSWORD HERE>` and replace it with `PassCmd "gpg --quiet --for-your-eyes-only --no-tty --decrypt \~/.mbsync-pw-mailbox.gpg"`.

### (Optionally) Store Your Password in an Obfuscated File

If it feels icky to put down your password _in plaintext_ in `.mbsyncrc`, you can instead store it with Base64 encoding. Note that this does not really provide more security than storing your password in plaintext.

1. Store the encoded password to a file: `echo "my-password" | base64 > ~/.mbsync-pw-mailbox`.
2. In `~/.mbsyncrc`, remove `Pass <INSERT YOUR PASSWORD HERE>` and replace it with `PassCmd "base64 -d ~/.mbsync-pw-mailbox"`.

## IV. Sync Your Local Mailbox with Your Remote Mailbox

1. Create a directory for your local mailbox: `mkdir ~/.mail`. Then run `mbsync -V gmail` (and supply your GPG key if you went that route). This will sync your local mailbox with your remote mailbox, which in practice means you will download all of your emails. Note that this can be several gigabytes of data.
2. Run `mu init --maildir ~/.mail --my-address example@gmail.com` and `mu index`. This indexes your local mailbox.

## V. Configure Emacs and Send an Email

1. Open up your `config.el` (`C-c f P`) and add something like this:

```lisp
(set-email-account!
 "gmail"
 '((mu4e-sent-folder       . "/[Gmail]/Sent Mail")
   (mu4e-trash-folder      . "/[Gmail]/Bin")
   (smtpmail-smtp-user     . "example@gmail.com"))
 t)
(setq mu4e-get-mail-command "mbsync gmail"
      ;; get emails and index every 5 minutes
      mu4e-update-interval 300
	  ;; send emails with format=flowed
	  mu4e-compose-format-flowed t
	  ;; no need to run cleanup after indexing for gmail
	  mu4e-index-cleanup nil
	  mu4e-index-lazy-check t
      ;; more sensible date format
      mu4e-headers-date-format "%d.%m.%y")
```

2. Restart Emacs with `M-x doom/restart` (`C-c q R`).
3. Open up mu4e using `M-x =mu4e` (`C-c M M`) and enjoy. Consult [the manual](https://www.djcbsoftware.nl/code/mu/mu4e/) for learning the ropes.
4. When sending your first email, you will be prompted for an SMTP host and port. Enter host `smtp.gmail.com` and port `587`. (Here I got an error related to the macOS Keychain. What solved it for me was adding `(after! auth-source (setq auth-sources (nreverse auth-sources)))` to my `config.el` as per [here](https://github.com/zzamboni/dot-doom/blob/master/doom.org).)

[^1]: The project is called `isync` although the executable is called `mbsync`, apparently as part of a migration from the former to the latter.
