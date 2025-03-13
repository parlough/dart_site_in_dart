import 'package:jaspr/jaspr.dart';

class LintPage extends StatelessComponent {
  final Object? lintInfo;

  const LintPage(this.lintInfo);

  @override
  Iterable<Component> build(BuildContext context) {
    return [header([])];
  }
}
