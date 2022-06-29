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
