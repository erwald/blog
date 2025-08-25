const { DateTime } = require("luxon");
const markdownIt = require("@gerhobbelt/markdown-it");
const markdownItAnchor = require("@gerhobbelt/markdown-it-anchor");
const markdownItFootnote = require("@gerhobbelt/markdown-it-footnote");
const markdownItSup = require("@gerhobbelt/markdown-it-sup");
const markdownItSub = require("@gerhobbelt/markdown-it-sub");
const syntaxHighlight = require("@11ty/eleventy-plugin-syntaxhighlight");
const pluginRss = require("@11ty/eleventy-plugin-rss");
const emojiReadTime = require("@11tyrocks/eleventy-plugin-emoji-readtime");

const removeTitle = (str) => str.replace(/<h\d.+<\/h\d>\s+/, "");

module.exports = function (eleventyConfig) {
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
    return DateTime.fromJSDate(dateObj, { zone: "utc" }).toFormat("yyyy-MM-dd");
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
      permalink: true,
      permalinkClass: "direct-link",
      permalinkSymbol: "#",
    })
    .use(markdownItFootnote)
    .use(markdownItSup)
    .use(markdownItSub);

  markdownLibrary.renderer.rules.footnote_block_open = () =>
    "<h2 id='footnotes'>Footnotes <a class='direct-link' href='#footnotes'>#</a></h2>\n" +
    "<ol class='footnotes-list'>\n";
  markdownLibrary.renderer.rules.footnote_block_close = () => "</ol>\n";

  eleventyConfig.setLibrary("md", markdownLibrary);

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
    postsAndImages = [
      {
        slug: "against-llm-reductionism",
        image: "/img/hero/datacenter_thumbnail.png",
      },
      {
        slug: "the-prospect-of-an-ai-winter",
        image: "/img/hero/ai_winter_thumbnail.png",
      },
      {
        slug: "how-bad-is-qwerty-really-a-review-of-the-literature-such-as-it-is",
        image: "/img/hero/qwerty_thumbnail.png",
      },
      {
        slug: "the-devastating-power-and-heartbreaking-pain-of-truly-changing-minds",
        image: "/img/hero/lds_joseph_smith_thumbnail.png",
      },
      {
        slug: "can-a-vegan-diet-be-healthy-a-literature-review",
        image: "/img/hero/woman_eating_bowl_thumbnail.png",
      },
      {
        slug: "doubts-about-track-record-arguments-for-utilitarianism",
        image: "/img/hero/utilitarianism_thumbnail.png",
      },
      {
        slug: "uncommon-sensations-a-review-of-the-selected-prose-of-fernando-pessoa",
        image: "/img/hero/pessoa_thumbnail.png",
      },
      {
        slug: "the-atemporal-franz-kafka",
        image: "/img/hero/kafka_thumbnail.png",
      },
      {
        slug: "does-it-smell-like-pollocks-in-here",
        image: "/img/hero/pollock_thumbnail.png",
      },
      {
        slug: "the-biggest-game-in-town",
        image: "/img/hero/game_b_thumbnail.png",
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
