const { DateTime } = require("luxon");
const markdownIt = require("@gerhobbelt/markdown-it");
const markdownItAnchor = require("@gerhobbelt/markdown-it-anchor");
const markdownItFootnote = require("@gerhobbelt/markdown-it-footnote");
const markdownItSup = require("@gerhobbelt/markdown-it-sup");
const markdownItSub = require("@gerhobbelt/markdown-it-sub");
const pluginRss = require("@11ty/eleventy-plugin-rss");

module.exports = function (eleventyConfig) {
  // Copy images & css to site dir.
  eleventyConfig.addPassthroughCopy("img");
  eleventyConfig.addPassthroughCopy("css");

  // Make sure we have readable dates.
  eleventyConfig.addFilter("readableDate", (dateObj) => {
    return DateTime.fromJSDate(dateObj, { zone: "utc" }).toFormat("d MMM y");
  });

  // Configure footnotes.
  // I got this from here (thanks!):
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
  markdownLibrary.renderer.rules.footnote_caption = (tokens, idx) => {
    let n = Number(tokens[idx].meta.id + 1).toString();
    if (tokens[idx].meta.subId > 0) {
      n += ":" + tokens[idx].meta.subId;
    }
    return n;
  };
  eleventyConfig.setLibrary("md", markdownLibrary);

  // Add filter for extracting the first 2 paragraphs from a string of HTML.
  eleventyConfig.addNunjucksFilter("abbrev", (str) => {
    // Remove the title & footnote references.
    const withoutTitle = str
      .replace(/<h\d.+<\/h\d>\s+/, "")
      .replace(/<sup class="footnote-ref">[^s]*<\/sup>/g, "");

    // If there's an opening quote, remove that, too.
    const withoutTitleAndQuote = withoutTitle.match(/^<blockquote>/)
      ? withoutTitle.substring(withoutTitle.indexOf("</blockquote>") + 14)
      : withoutTitle;

    // Return just the first 2 paragraphs.
    return withoutTitleAndQuote.split(/<\/p>/).slice(0, 2).join("</p>");
  });

  // Add RSS plugin.
  eleventyConfig.addPlugin(pluginRss);

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
