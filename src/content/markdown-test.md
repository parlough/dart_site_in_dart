---
title: Markdown extension index
description: >-
  An index of extra Markdown syntax and features used on the Dash sites
  that'd we like to ensure keep working.
---

## Definition lists

Term one
: Definition of the first term.

Term two
: Multi-line definition of
  the second term.

Term three
: First definition of the third term.
: Second definition of the third term.

## Asides

:::note
A normal note.
:::

:::note Different title
A normal note, but with a custom title.
:::

:::tip
An aside with a tip.
:::

:::recommend
An aside that makes a recommendation.
:::

:::important
An important aside.
:::

:::warning
An aside that warns about something.
:::

:::secondary
An aside with no title.
:::

:::version-note
An aside with a version note, often about changes in language versions.
:::

:::flutter-note
An aside that discusses something specific to Flutter.
:::

## Level 2 headers

Level 2 headers should show up in the TOC.

### Level 3 headers

Level 3 headers should show up in the TOC.

#### Level 4 headers

Level 4-6 headers should not show up in the TOC.

## Attribute modification

Can add HTML attributes inline, including classes and IDs,
such as to spans **like this one**{:.important-text}.

### Change header IDs {:#change-slug}

Can change the fragment/slug of a header by changing the ID.

### Hide header from TOC {:.no_toc}

Can hide a header from the TOC by adding the `no_toc` class.

## Code blocks

### Titles and filenames

Specified titles will show up above code blocks.

```dart title="main.dart"
void main() {
  print('Hello world!');
}
```

### Custom classes

Can add tags to style the code block.

```dart tag=fails-sa
var String fail = 'I fail static analysis :(';
```

### Line highlighting

Can highlight a single line or a range of lines.

```dart highlightLines=2
void main() {
  print('This line should be highlighted!');
}
```

### Span highlighting

Can highlight spans within a line:

```dart
void main() {
  print([!7 % 4!]);
}
```

### Embed DartPad

When the language is `dartpad`, the snippet should be rendered in
the format expected by the DartPad injection tool.

```dartpad theme="dark"
void main() {
  print('Render me as a DartPad embed please!');
}
```
