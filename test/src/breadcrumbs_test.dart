import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_breadcrumbs/simple_breadcrumbs.dart';

void main() {
  testWidgets('Correct path returned on navigate click', (tester) async {
    final myTestFinder = find.textRange.ofSubstring('my');
    final textTestFinder = find.textRange.ofSubstring('test');
    final textPathFinder = find.textRange.ofSubstring('path');

    const path = 'my/test/path';
    late String actual;

    String myExpected = 'my';
    String testExpected = 'my/test';
    String pathExpected = 'my/test/path';

    final testWidget = MaterialApp(
      home: Breadcrumbs(
        breadcrumbs: path.split('/').map(
              (s) => Breadcrumb(
                label: s,
                path: s,
              ),
            ),
        onNavigate: (path) => actual = path,
        textStyle: const TextStyle(fontFamily: 'Roboto'),
        dividerStyle: const TextStyle(fontFamily: 'Roboto'),
        selectedStyle: const TextStyle(fontFamily: 'Roboto'),
      ),
    );

    await tester.pumpWidget(testWidget);

    // Assert
    await tester.tapOnText(myTestFinder);
    expect(actual, myExpected);

    await tester.tapOnText(textTestFinder);
    expect(actual, testExpected);

    await tester.tapOnText(textPathFinder);
    expect(actual, pathExpected);
  });

  testWidgets('Renders Correctly with all styles applied', (tester) async {
    // Arrange
    await tester.binding.setSurfaceSize(const Size(200, 50));

    final Future<ByteData> font = rootBundle.load('fonts/Roboto-Regular.ttf');

    final FontLoader fontLoader = FontLoader('Roboto')..addFont(font);
    await fontLoader.load();

    final testWidget = MaterialApp(
      home: Breadcrumbs(
        breadcrumbs: 'example/with/all/parameters'.split('/').map(
              (s) => Breadcrumb(
                label: s,
                path: s,
              ),
            ),
        onNavigate: (_) {},
        divider: ' > ',
        capitalize: true,
        pathConnector: '<',
        textStyle: const TextStyle(
          fontFamily: 'Roboto',
          color: Colors.red,
        ),
        dividerStyle: const TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w200,
          color: Colors.yellow,
          fontSize: 12,
        ),
        selectedStyle: const TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      ),
    );

    // Act
    await tester.pumpWidget(testWidget);

    // Assert
    expect(find.byType(Breadcrumbs),
        matchesGoldenFile('golden_files/breadcrumbs_styled.png'));

    await tester.binding.setSurfaceSize(null);
  });
}
