const { DateTime } = require("luxon");
const markdownIt = require("@gerhobbelt/markdown-it");
const markdownItAnchor = require("@gerhobbelt/markdown-it-anchor");
const markdownItFootnote = require("@gerhobbelt/markdown-it-footnote");
const markdownItSup = require("@gerhobbelt/markdown-it-sup");
const markdownItSub = require("@gerhobbelt/markdown-it-sub");
const pluginRss = require("@11ty/eleventy-plugin-rss");

const removeTitle = (str) => str.replace(/<h\d.+<\/h\d>\s+/, "");
const removeTitleAndQuotesAndFootnotes = (str) => {
  // Remove the title & footnote references.
  const withoutTitle = removeTitle(str)
    .replace(/<sup class="footnote-ref">[^s]*<\/sup>/g, "")
    .replace(/^\s+/g, "");

  // If there's an opening quote, remove that, too.
  const withoutTitleAndQuote = withoutTitle.match(/^<blockquote>/)
    ? withoutTitle.substring(withoutTitle.indexOf("</blockquote>") + 14)
    : withoutTitle;

  return withoutTitleAndQuote;
};

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

  eleventyConfig.setLibrary("md", markdownLibrary);

  // Add filter for extracting the first 2 paragraphs from a string of HTML.
  eleventyConfig.addNunjucksFilter("abbrev", (str) =>
    removeTitleAndQuotesAndFootnotes(str)
      .split(/<\/p>/)
      .slice(0, 2)
      .join("</p>")
  );

  // Add filter for removing title header from content.
  eleventyConfig.addNunjucksFilter("removeTitle", (str) => removeTitle(str));

  // Add shortcode for getting a post's series (if it is a part of one).
  eleventyConfig.addNunjucksFilter("getSeries", (slug, series) => {
    return series.find((ps) => ps.posts.map((p) => p.slug).includes(slug));
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
