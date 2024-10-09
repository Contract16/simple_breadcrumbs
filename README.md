A small widget to implement breadcrumbs into a flutter app

## Features

- Pass in path to view
- Customise text, separator and selected text styles
- Set `maxLines`
- Set `overflow`
- Defaults to common format

## Usage

Minimum required:
```dart
List<Breadcrumb> breadcrumbItems = 'example/with/no/parameters'.split('/').map(
        (s) => Breadcrumb(
        label: s,
        path: s,
    );

final breadcrumbs = Breadcrumbs(
    breadcrumbs: breadcrumbItems,
    ),
    onNavigate: (path) => _navigate(context, path),
);
```