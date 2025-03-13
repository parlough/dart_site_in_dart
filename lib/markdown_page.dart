import 'dart:io';

import 'package:fbh_front_matter/fbh_front_matter.dart' as fm;
import 'package:jaspr/server.dart';
import 'package:liquify/liquify.dart';
import 'package:markdown/markdown.dart';

import 'data/page.dart';
import 'layouts/default.dart';

class MarkdownPage extends AsyncStatelessComponent {
  const MarkdownPage({required this.path});

  final String path;

  @override
  Stream<Component> build(BuildContext context) async* {
    final file = File(path);
    final content = await file.readAsString();

    final document = fm.parse(content);
    final frontMatter = <String, Object?>{
      for (final entry in document.data.entries)
        entry.key as String: entry.value,
    };
    final layout = frontMatter['layout'] ??= 'default';

    final template = Template.parse(
      document.content!,
      data: {
        'page': {'url': path},
      },
    );

    final html = markdownToHtml(template.render(clearBuffer: true));

    final child = raw(html);
    yield PageInfo(
      title: frontMatter['title'] as String,
      slug: path,
      description: frontMatter['description'] as String,
      child: switch (layout) {
        _ => DefaultLayout(content: child),
      },
    );
  }
}
