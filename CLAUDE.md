# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Cardinal rules

1. **The user must approve all code changes.** Never edit, create, or delete files without first describing the intended change and getting explicit approval in this conversation. Show every proposed edit as an exact diff in chat before making it, since the permission prompt does not display the change contents. When a change is approved, make only that change — approval does not extend to other files or follow-up changes. Never commit or push unless asked.
2. **Always follow the project's conventions.** Before writing anything, look at how the existing posts, templates, and scripts do it, and match them. When a convention here conflicts with a general best practice, the convention wins. If you're unsure what the convention is, ask rather than guess.

## What this is

Erich Grunewald's personal blog ([erichgrunewald.com](https://www.erichgrunewald.com/)), a static site built with Eleventy (11ty) and deployed on Netlify (`_redirects` holds redirect rules). There is no build/lint/test tooling beyond Eleventy itself; Prettier (v3) is available for formatting JS.

A mirror of the blog, mainly for making it easier to discover and subscribe, [exists on Substack](https://erichgrunewald.substack.com/).

## Commands

```bash
# Serve locally at http://localhost:1000 (in a tmux session named "11ty")
./start_server.sh

# Or run Eleventy directly
npx @11ty/eleventy --serve --port 1000

# One-off build to _site/
npx @11ty/eleventy

# Convert hero images in img_original/hero/ to dithered PNGs in img/hero/
# (requires ImageMagick; --dry-run to preview, --convert-all to redo existing)
./dither_convert.sh

# Or dither arbitrary images in place (one 660px <name>_dithered.png each,
# written beside the source); leaves the repo's img folders untouched
./dither_convert.sh ~/Downloads/*.jpg
```

## Architecture

- `.eleventy.js` — all site configuration: markdown-it setup (footnotes, anchors, sub/sup, typographer), custom filters (`readableDate`, `pathify`, `apostrophy`, `removeTitle`, `getSeries`, `featuredPosts`), plugins (syntax highlighting, RSS, read time). The `featuredPosts` filter hardcodes the "start here" post list — adding a featured post means editing this file.
- `posts/*.md` — one file per post, generated from Org (see below); the filename is the URL slug (kebab-case).
- `_includes/layouts/` — `base.njk` and `post.njk` Nunjucks layouts.
- `_data/metadata.json` — site metadata; `_data/series.json` — post series definitions, matched to posts by slug via the `getSeries` filter.
- `img_original/` — source images (also zipped in `img_original.zip`); `img/` — web-ready images. Hero images get a black-and-white dithered treatment via `dither_convert.sh`, which produces three sizes: main (660px), `_substack` (730px), `_thumbnail` (300px).
- `_site/` — build output; never edit by hand.

## Posts are generated from Org

Every published post has an Org source in `~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/projects/blog/` (found by its `#+slug:` line). A background service, `blog-export.el` in `~/Documents/doom-config/`, exports each Org file marked `#+status: ready` to `posts/<slug>.md`, plus a plain-Markdown copy for LessWrong and the EA Forum in `crossposts/<slug>.md` (generated, ignored by git). Files marked `#+status: draft` are never exported. The Org folder has no version history; git history of `posts/` is the only record.

- When Erich asks for a change to a post, make it in the post's Org file, and the service updates `posts/<slug>.md` within seconds. Edit `posts/*.md` directly only for a post that has no Org file.
- Never edit an Org file unless Erich has explicitly asked for that change. The Org files are his words.
- Never hand-edit `posts/*.md` for a post that has an Org file, or anything in `crossposts/`: the exporter refuses to overwrite uncommitted hand edits, and overwrites committed ones on the next export.
- The service log is `~/Library/Logs/blog-export.log`; in Emacs, `M-x blog-export-install-service` (re)installs the service.

## Post conventions

Frontmatter: `layout: layouts/post.njk`, `title`, `date` (YYYY-MM-DD), `tags: post`. The post body repeats the title as a `# H1` (stripped from listings by the `removeTitle` filter) and typically follows with a hero image: `![img]({{ '/img/hero/... .png' | url }})`.

In post text, write `--` for dashes and plain straight quotes — the markdown-it typographer converts them. Footnotes use standard `[^n]` markdown-it-footnote syntax.
