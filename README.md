# Dart site experiment

Experimenting with building the Dart programming language (dart.dev)
site and documentation with mostly Dart.

If you're interested in helping with this exploration,
consider working on one of the tasks outlined below.
Any help is appreciated, and I'm excited to see what we can build together!

## Work to be done

### Tasks and questions that need to be completed or resolved

- Decide on the location for assets, such as images, JS files, etc.
  Consider if this should be different if they might be processed?

- Somehow access page descriptions when generating routes.

- Keep existing site styling with sass functional
  - ~~Set up sass compilation so we can use our existing styles.~~
  - ~~Preferably can integrate with the development/serving workflow.~~
  - Use `expanded` format with a source map during development,
    then `compressed` without source map when deploying to production.

- Support (most of) the Markdown features we already do
  - Share configuration across site and enable each used syntax.
  - Add support for [definition list][] syntax.
  - Enable adding HTML attributes (IDs, classes, etc.) to elements.
    - We use `{:}` for wrapping this, such as `{:#some-id .some-class}`,
      but not supporting the `:` is fine if necessary.
  - Automatically add self-anchors to `h2` and `h3` elements.
  - Support fenced container syntax opened by `:::`,
    at least for the admonitions/alerts we use, that look like:

    ```markdown
    :::note This is the title of the note
    The contents of the note.
    :::
    ```

  - It might make sense to implement a custom Markdown renderer,
    by implementing `NodeVisitor` and using Jaspr's HTML DSL.
    That way can integrate custom components more easily.

- Configure Liquid with the extra filters and shortcodes we need
  or migrate our usages away from them.

- Fenced code block configuration
  - Can specify title with `title="<title>"`.
  - Can highlight lines with `highlightLine=<range>`.
  - Can add tags(classes) to the code block for styling.
  - Can add DartPad embed framing when language specifier is `dartpad`.
    Generated HTML should match what's expected by [`inject_dartpad`][].

- Syntax highlighting
  - Implement syntax highlighting for fenced Markdown code blocks for
    all supported languages.
  - If needed, can use highlightjs derivative or similar for now,
    but it will result in worse highlighting than currently with [Shiki][].
  - Can highlight spans in code blocks with `[! !]` wrapped around.
    It's ok to assume these highlight spans close in the same line as they open.

- Generate the contents of the sidenav with the active items specified
  based on the existing `sidenav.yml` format, or with minor modifications.
  - https://github.com/dart-lang/site-www/blob/main/src/_data/sidenav.yml
  - A page should be able to opt out of the inline sidenav,
    such as the homepage.

- Generate "On this page" TOC based off the `h2` and `h3` headers on each page.
  - This should at least cover Markdown headers.
  - Pages should be able to opt out of having a TOC.

- Generate breadcrumbs for pages which haven't disabled them based
  on their parent directories and the short-titles of their index pages.

- Determine how we want to handle multiple pages based off one set of data.
  The initial use case are the `/tools/linter-rules/<rule_id>` pages.

- Figure out how to best keep existing `.html` pages or migrate them to Jaspr.

- Generate a `sitemap.xml` based on all routes that haven't disabled it.

- Generate a `robots.txt` file, with different contents
  depending on if deploying to production or not.

- Inject a `page.lastModified` data into each page based on `git` or file data.

- Make site data files (such as `keywords.yml`) accessible from templates.
  - Either can load them or can use Dart structures as the data source.

- Figure out how to best handle passthrough files, like `/f/packages/http.json`
  and `resources/language/spec/versions/DartLangSpec-v2.10.pdf`.
  If it's not too clean, we could create a dedicated `public` folder in `web/`.

- Determine how we want to use client Jaspr components from Markdown.
  If we need a separate registration step for now, that's fine.

- Ensure existing JS code for interactivity keeps working.

[definition list]: https://www.markdownguide.org/extended-syntax/#definition-lists
[`inject_dartpad`]: https://github.com/dart-lang/site-shared/tree/main/pkgs/inject_dartpad

### Nice to have changes or functionality

- Inject and communicate using a WebSocket when serving docs during development.
  When the viewed page has changed,
  force a reload or add some sort of "outdated" indicator.

- [Shiki][]-like syntax highlighter based on TextMate grammars.
  - We would need to convert Oniguruma regular expressions to
    Dart regular expressions.
  - Could directly port [oniguruma-parser][] and [oniguruma-to-es][],
    but might end up needing [dart-lang/sdk#54175][] for full functionality.

- Use analyzer for syntax highlighting Dart that analyzes cleanly,
  and fall back to TextMate-based for others.

- Post-processing step that minifies the generated HTML content.

- Convert some interactive handling from JS to Dart/Jaspr, such as
  searching and filtering on the linter rules and glossary pages.

- Simpler templating engine or perhaps [Markdoc][].

[Shiki]: https://github.com/shikijs/shiki
[oniguruma-parser]: https://github.com/slevithan/oniguruma-parser
[oniguruma-to-es]: https://github.com/slevithan/oniguruma-to-es
[dart-lang/sdk#54175]: https://github.com/dart-lang/sdk/issues/54175
[Markdoc]: https://markdoc.dev/

## Contributing

All contributions are welcome, even if not fully complete
as this is an in-progress experiment.
Feel free to open up work-in-progress or incompleted PRs,
as they can provide vital insight and spark interesting conversations.

### Running

For now, you can serve the site with the following command.

```
dart run jaspr_cli:jaspr serve
```

You need to reload pages manually after making changes.
Do document, report, or fix any changes that aren't visible after a reload.

### Building

For now, you can build the site with the following command.

```
dart run jaspr_cli:jaspr build
```

This will build the site output in to the `/build/jaspr` directory.

### Staging

The main channel is automatically built and deployed to https://dartdocs.dev/.
