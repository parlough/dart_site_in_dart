import 'dart:io';

import 'package:jaspr_router/jaspr_router.dart';
import 'package:path/path.dart' as path;

import 'config.dart';
import 'markdown_page.dart';

Future<List<RouteBase>> loadRoutes() async {
  final customRoutes = await _loadCustomRoutes();
  final contentRoutes = await _loadMarkdownRoutes();
  return [...customRoutes, ...contentRoutes];
}

Future<List<RouteBase>> _loadCustomRoutes() async {
  return [];
}

Future<List<RouteBase>> _loadRoutesFromMarkdown(
  Directory dir, [
  String parentPath = '',
  bool isTopLevel = true,
]) async {
  Route? index;
  final routes = <RouteBase>[];

  final hasIndex = File(path.join(dir.path, 'index.md')).existsSync();

  for (final entry in dir.listSync()) {
    final entryBasename = path.basename(entry.path);
    final entryExtension = path.extension(entry.path);

    if (entryBasename.startsWith('_')) continue;
    if (entryBasename == 'get-dart') continue;

    if (entry is File && entryExtension == '.md') {
      final isIndex = entryBasename == 'index.md';
      final route = Route(
        path:
            (isTopLevel ? '/' : '') +
            (isIndex
                ? parentPath
                : ((hasIndex || parentPath.isEmpty ? '' : '$parentPath/') +
                    entryBasename.replaceFirst('.md', ''))),
        builder: (context, state) => MarkdownPage(path: entry.path),
      );
      if (isIndex) {
        index = route;
      } else {
        routes.add(route);
      }
    }
    if (entry is Directory) {
      final subRoutes = await _loadRoutesFromMarkdown(
        entry,
        (isTopLevel ? '/' : '') +
            (hasIndex
                ? entryBasename
                : parentPath.isNotEmpty
                ? '$parentPath/$entryBasename'
                : entryBasename),
        false,
      );
      routes.addAll(subRoutes);
    }
  }

  if (isTopLevel) {
    return [if (index != null) index, ...routes];
  }

  if (index != null) {
    return [Route(path: index.path, builder: index.builder, routes: routes)];
  } else {
    return routes;
  }
}

Future<List<RouteBase>> _loadMarkdownRoutes() async {
  final contentDirectory = Directory(siteConfig.contentRoot);
  if (!await contentDirectory.exists()) {
    return [];
  }

  return _loadRoutesFromMarkdown(contentDirectory);
}

// Future<List<RouteBase>> loadLintRoutes() async {
//   final rulesFile = File('src/_data/linter_rules.json');
//   if (!rulesFile.existsSync()) {
//     throw StateError('The ${rulesFile.path} file is missing!');
//   }
//
//   final lints = jsonDecode(rulesFile.readAsStringSync()) as List<Object?>;
//   return [
//     for (final lint in lints.cast<Map<String, Object?>>())
//       Route(
//         path: '/tools/linter-rules/${lint['name']}',
//         builder: (context, state) => LintPage(line),
//       ),
//   ];
// }
