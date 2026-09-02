import { DateTime } from "luxon";
import markdownIt from "markdown-it";
import markdownItAnchor from "markdown-it-anchor";
import markdownItFootnote from "markdown-it-footnote";
import markdownItSup from "markdown-it-sup";
import markdownItSub from "markdown-it-sub";
import syntaxHighlight from "@11ty/eleventy-plugin-syntaxhighlight";
import pluginRss from "@11ty/eleventy-plugin-rss";
import emojiReadTime from "@11tyrocks/eleventy-plugin-emoji-readtime";

const removeTitle = (str) => str.replace(/<h\d.+<\/h\d>\s+/, "");

export default function (eleventyConfig) {
    const md = new markdownIt({
        html: true,
    });
    // expose markdown renderer as a filter.
    eleventyConfig.addFilter("markdown", (content) => {
        return md.renderInline(content);
    });

    // copy images & css to site dir.
    eleventyConfig.addPassthroughCopy("img");
    eleventyConfig.addPassthroughCopy("css");
    eleventyConfig.addPassthroughCopy("fonts");

    // remove all characters except letters, numbers & dashes.
    eleventyConfig.addFilter("pathify", (str) => {
        return str.replace(/[^A-Za-z0-9\-]/g, "");
    });

    // make sure we have readable dates.
    eleventyConfig.addFilter("readableDate", (dateObj) => {
        return DateTime.fromJSDate(dateObj, { zone: "utc" }).toFormat(
            "yyyy-MM-dd"
        );
    });

    eleventyConfig.addFilter("apostrophy", (str) => {
        return str
            .replace(/\B\'/g, "‘")
            .replace(/\'/g, "’")
            .replace(/\B\"/g, "“")
            .replace(/\"/g, "”");
    });

    // configure footnotes.
    // i got this from here (thanks!):
    // http://dirtystylus.com/2020/06/15/eleventy-markdown-and-footnotes/
    let markdownLibrary = markdownIt({
        html: true,
        breaks: true,
        linkify: true,
        typographer: true,
    })
        .use(markdownItAnchor, {
            permalink: markdownItAnchor.permalink.linkInsideHeader({
                class: "direct-link",
                symbol: "#",
            }),
        })
        .use(markdownItFootnote)
        .use(markdownItSup)
        .use(markdownItSub);
    markdownLibrary.linkify.set({ fuzzyLink: true });

    markdownLibrary.renderer.rules.footnote_block_open = () =>
        "<h2 id='footnotes'>Footnotes <a class='direct-link' href='#footnotes'>#</a></h2>\n" +
        "<ol class='footnotes-list'>\n";
    markdownLibrary.renderer.rules.footnote_block_close = () => "</ol>\n";

    eleventyConfig.setLibrary("md", markdownLibrary);
    eleventyConfig.amendLibrary("md", (mdLib) => mdLib.enable("code"));

    // add filter for removing title header from content.
    eleventyConfig.addNunjucksFilter("removeTitle", (str) => removeTitle(str));

    // add shortcode for getting a post's series (if it is a part of one).
    eleventyConfig.addNunjucksFilter("getSeries", (slug, series) => {
        return series.find((ps) => ps.posts.map((p) => p.slug).includes(slug));
    });

    // add markdown syntax highlighting plugin.
    eleventyConfig.addPlugin(syntaxHighlight);

    // add rss plugin.
    eleventyConfig.addPlugin(pluginRss);

    // add netlify redirect config file.
    eleventyConfig.addPassthroughCopy("_redirects");

    // add plugin for showing estimated post read time.
    eleventyConfig.addPlugin(emojiReadTime, {
        showEmoji: false,
        label: "min read",
        wpm: 300,
        bucketSize: 5,
    });

    // add filter for creating "start here" collection
    eleventyConfig.addFilter("featuredPosts", (posts) => {
        const postsAndImages = [
            {
                slug: "against-llm-reductionism",
                image: "/img/hero/datacenter_thumbnail.png",
            },
            {
                slug: "why-i-think-you-should-almost-never-use-ai-to-write-anything-substantive",
                image: "/img/hero/writing_thumbnail.png",
            },
            {
                slug: "not-a-meat-eater-faq",
                image: "/img/hero/pigs_thumbnail.png",
            },
            {
                slug: "attention-on-existential-risk-from-ai-likely-hasnt-distracted-from-current-harms-from-ai",
                image: "/img/hero/datacenter_2_thumbnail.png",
            },
            {
                slug: "alpha",
                image: "/img/hero/gorilla_thumbnail.png",
            },
            {
                slug: "the-prospect-of-an-ai-winter",
                image: "/img/hero/ai_winter_thumbnail.png",
            },
            {
                slug: "the-literary-technique-of-recapitulation",
                image: "/img/hero/murnane_horseracing_thumbnail.png",
            },
            {
                slug: "uncommon-sensations-a-review-of-the-selected-prose-of-fernando-pessoa",
                image: "/img/hero/pessoa_thumbnail.png",
            },
            {
                slug: "notes-on-metas-diplomacy-playing-ai",
                image: "/img/hero/europe_thumbnail.png",
            },
            {
                slug: "impact-above-replacement",
                image: "/img/hero/twins_thumbnail.png",
            },
        ];
        return postsAndImages.map(({ slug, image }) => {
            const post = posts.find((post) => post.fileSlug.includes(slug));
            return { ...post, image: image };
        });
    });

    return {
        templateFormats: ["md", "njk", "html", "png", "jpg", "ico"],
        passthroughFileCopy: true,
        markdownTemplateEngine: "liquid",
        htmlTemplateEngine: "njk",
        dataTemplateEngine: "njk",
        pathPrefix: "/",
        favicons: "/",
    };
};
