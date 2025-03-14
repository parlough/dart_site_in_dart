import 'package:path/path.dart' as path;

final SiteConfig siteConfig = SiteConfig._();

final class SiteConfig {
  SiteConfig._();

  String get title => 'Dart';

  String get description => 'Dart documentation site.';

  String get contentRoot => path.join('src', 'content');
}
