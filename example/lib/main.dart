import 'package:flutter/material.dart';
import 'package:simple_breadcrumbs/simple_breadcrumbs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const _BreadcrumbsView(),
    );
  }
}

class _BreadcrumbsView extends StatelessWidget {
  const _BreadcrumbsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Breadcrumbs(
            breadcrumbs: 'example/with/no/parameters'.split('/').map(
                  (s) => Breadcrumb(
                    label: s,
                    path: s,
                  ),
                ),
            onNavigate: (path) => _navigate(context, path),
          ),
          Breadcrumbs(
            breadcrumbs: 'example/with/all/parameters'.split('/').map(
                  (s) => Breadcrumb(
                    label: s,
                    path: s,
                  ),
                ),
            onNavigate: (path) => _navigate(context, path),
            divider: ' > ',
            textStyle: const TextStyle(
              color: Colors.red,
            ),
            dividerStyle: const TextStyle(
              fontWeight: FontWeight.w200,
              color: Colors.yellow,
              fontSize: 12,
            ),
            selectedStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _navigate(BuildContext context, String path) => Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => Scaffold(
            appBar: AppBar(title: Text(path)),
            body: Center(
              child: TextButton(
                child: const Text('pop'),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ),
      );
}
