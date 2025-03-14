import 'package:jaspr/server.dart';

import '../components/head.dart';
import '../data/page.dart';

class DefaultLayout extends StatelessComponent {
  const DefaultLayout({required this.content});

  final Component content;

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final page = PageInfo.of(context);
    yield html(
      attributes: {'lang': 'en'},
      [
        const Head(),
        body([
          a(id: 'skip', href: '#site-content-title', [
            text('Skip to main content'),
          ]),
          main_(id: 'page-content', [
            article(classes: 'content', [
              div(id: 'site-content-title', [
                h1([text(page.title)]),
              ]),
              content,
            ]),
          ]),
        ]),
      ],
    );
  }
}
