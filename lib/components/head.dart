import 'dart:math';

import 'package:jaspr/jaspr.dart';

import '../config.dart';
import '../data/page.dart';

class Head extends StatelessComponent {
  const Head({super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final page = PageInfo.of(context);
    var desc = page.description;
    desc = desc.replaceAll('\n', ' ').substring(0, min(desc.length, 160));

    yield head([
      meta(attributes: {'charset': 'UTF-8'}),
      meta(attributes: {'http-equiv': 'x-ua-compatible', 'content': 'ie=edge'}),
      meta(
        attributes: {
          'name': 'viewport',
          'content': 'width=device-width, initial-scale=1.0',
        },
      ),
      meta(attributes: {'name': 'description', 'content': desc}),
      DomComponent(
        tag: 'title',
        children: [
          text('${page.shortTitle ?? page.title} | ${siteConfig.title}'),
        ],
      ),
      link(
        href:
            'https://fonts.googleapis.com/css2?family=Google+Sans:wght@400;500;700&display=swap',
        rel: 'stylesheet',
      ),
      link(
        href:
            'https://fonts.googleapis.com/css2?family=Google+Sans+Display:wght@400&display=swap',
        rel: 'stylesheet',
      ),
      link(
        href:
            'https://fonts.googleapis.com/css2?family=Google+Sans+Mono:wght@400;500;700&display=swap',
        rel: 'stylesheet',
      ),
      link(
        href:
            'https://fonts.googleapis.com/css2?family=Google+Sans+Text:wght@400;500;700&display=swap',
        rel: 'stylesheet',
      ),
      link(
        href:
            'https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0',
        rel: 'stylesheet',
      ),
      link(rel: 'stylesheet', href: '/assets/css/main.css'),
    ]);
  }
}
