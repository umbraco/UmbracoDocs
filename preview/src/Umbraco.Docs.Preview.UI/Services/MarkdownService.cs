using System.IO;
using System.Text.RegularExpressions;
using Markdig;
using Markdig.Extensions.AutoIdentifiers;
using Umbraco.Docs.Preview.UI.MiscellaneousOurStuff;

namespace Umbraco.Docs.Preview.UI.Services
{
    public class MarkdownService : IMarkdownService
    {
        public const string RegEx = @"\[([^\]]+)\]\(([^)]+)\)"; // wat?

        public string RenderMarkdown(string path)
        {
            var rawMarkdown = File.ReadAllText(path);

            var clean = Regex.Replace(
                rawMarkdown,
                RegEx,
                LinkEvaluator,
                RegexOptions.Singleline | RegexOptions.IgnorePatternWhitespace);

            var pipeline = new MarkdownPipelineBuilder()
                .UseAbbreviations()
                .UseAutoIdentifiers(AutoIdentifierOptions.GitHub)
                .UseCitations()
                .UseCustomContainers()
                .UseDefinitionLists()
                .UseEmphasisExtras()
                .UseFigures()
                .UseFooters()
                .UseFootnotes()
                .UseGridTables()
                .UseMathematics()
                .UseMediaLinks()
                .UsePipeTables()
                .UseYamlFrontMatter()
                .UseListExtras()
                .UseTaskLists()
                .UseDiagrams()
                .UseAutoLinks()
                //.UseSyntaxHighlighter(out SyntaxHighlighterOptions highligther)
                .Build();

            //highligther.AddAlias("json5", Language.Json);

            var transform = Markdown.ToHtml(clean, pipeline);

            return transform;
        }

        private string LinkEvaluator(Match match)
        {
            string mdUrlTag = match.Groups[0].Value;
            string rawUrl = match.Groups[2].Value;

            //Escpae external URLs
            if (rawUrl.StartsWith("http") || rawUrl.StartsWith("https") || rawUrl.StartsWith("ftp"))
                return mdUrlTag;

            //Escape anchor links
            if (rawUrl.StartsWith("#"))
                return mdUrlTag;

            //Correct internal image links
            if (rawUrl.StartsWith("../images/"))
                return mdUrlTag.Replace("../images/", "images/");


            if (rawUrl.EndsWith("index.md"))
                mdUrlTag = mdUrlTag.Replace("/index.md", "/");
            else
                mdUrlTag.TrimEnd('/');

            ////Need to ensure we dont append the image links as they 404 if we add altTemplate
            //if (AppendAltLessonLink && rawUrl.StartsWith("images/") == false)
            //{
            //    return mdUrlTag.Replace(rawUrl, string.Format("{0}?altTemplate=Lesson", rawUrl.EnsureNoDotsInUrl()));
            //}

            return mdUrlTag.Replace(rawUrl, rawUrl.EnsureNoDotsInUrl());
        }
    }
}
