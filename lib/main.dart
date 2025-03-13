import 'package:jaspr/server.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:watcher/watcher.dart';

import 'content.dart';

import 'jaspr_options.dart';

bool watcherInitialized = false;

void main() async {
  // Initializes the server environment with the generated default options.
  Jaspr.initializeApp(options: defaultJasprOptions);
  _configureLiquid();

  // Only initialize the directory watcher the first run.
  if (!watcherInitialized) {
    final contentWatcher = DirectoryWatcher(
      'src',
      pollingDelay: const Duration(milliseconds: 500),
    );
    contentWatcher.events.listen((event) {
      // If a content file was added or remove, regenerate routes.
      if (event.type == ChangeType.ADD || event.type == ChangeType.REMOVE) {
        _runSite();
      }
    });

    watcherInitialized = true;
  }

  _runSite();
}

void _runSite() async {
  final routes = await loadRoutes();

  runApp(Router(routes: routes));
}

void _configureLiquid() {}
