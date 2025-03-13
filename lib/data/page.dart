import 'package:jaspr/jaspr.dart';

class PageInfo extends InheritedComponent {
  final String title;
  final String? shortTitle;
  final String slug;
  final String description;
  final Map<String, Object?> _extraData;

  PageInfo({
    required this.title,
    this.shortTitle,
    required this.slug,
    required this.description,
    Map<String, Object?> extraData = const {},
    required super.child,
  }) : _extraData = extraData;

  Object? operator [](String key) => _extraData[key];

  static PageInfo? maybeOf(BuildContext context) =>
      context.dependOnInheritedComponentOfExactType<PageInfo>();

  static PageInfo of(BuildContext context) => maybeOf(context)!;

  @override
  bool updateShouldNotify(PageInfo oldComponent) => slug != oldComponent.slug;
}
