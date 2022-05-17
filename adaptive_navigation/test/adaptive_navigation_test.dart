import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:adaptive_navigation/adaptive_navigation.dart';

void main() {
  const _allDestinations = [
    AdaptiveScaffoldDestination(title: 'Alarm', icon: Icons.alarm),
    AdaptiveScaffoldDestination(title: 'Book', icon: Icons.book),
    AdaptiveScaffoldDestination(title: 'Cake', icon: Icons.cake),
    AdaptiveScaffoldDestination(title: 'Directions', icon: Icons.directions),
    AdaptiveScaffoldDestination(title: 'Email', icon: Icons.email),
    AdaptiveScaffoldDestination(title: 'Favorite', icon: Icons.favorite),
    AdaptiveScaffoldDestination(title: 'Group', icon: Icons.group),
    AdaptiveScaffoldDestination(title: 'Headset', icon: Icons.headset),
    AdaptiveScaffoldDestination(title: 'Info', icon: Icons.info),
  ];
  testWidgets('Adaptive Navigation test', (WidgetTester tester) async {
    const mediumWindowSize = Size(960, 1000);
    tester.binding.window.physicalSizeTestValue = mediumWindowSize;
    tester.binding.window.devicePixelRatioTestValue = 1.0;

    await tester.pumpWidget(
      MaterialApp(
        home: AdaptiveNavigationScaffold(
          selectedIndex: 0,
          destinations: _allDestinations,
          appBar: AdaptiveAppBar(title: const Text('Default Demo')),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {},
          ),
          body: Container(
            color: Colors.green,
          ),
        ),
      ),
    );
    expect(find.byType(AdaptiveNavigationScaffold), findsOneWidget);
  });
  testWidgets('Adaptive App Bar leading icon axis test',
      (WidgetTester tester) async {
    const xlargeWindowSize = Size(1920, 1080);
    tester.binding.window.physicalSizeTestValue = xlargeWindowSize;
    tester.binding.window.devicePixelRatioTestValue = 1.0;

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: false),
        home: AdaptiveNavigationScaffold(
          selectedIndex: 0,
          destinations: _allDestinations,
          appBar: AdaptiveAppBar(
            title: const Text('Default Demo'),
            leading: const Icon(
              Icons.more_vert,
              key: Key('target'),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {},
          ),
          body: Container(
            color: Colors.green,
          ),
          navigationTypeResolver: (context) {
            return NavigationType.rail;
          },
        ),
      ),
    );

    expect(
      tester.getCenter(find.byKey(const Key('target'))).dx,
      tester.getCenter(find.byIcon(Icons.alarm)).dx,
    );
  });

  testWidgets('Adaptive App Bar leading icon axis test with Material3',
      (WidgetTester tester) async {
    const xlargeWindowSize = Size(1920, 1080);
    tester.binding.window.physicalSizeTestValue = xlargeWindowSize;
    tester.binding.window.devicePixelRatioTestValue = 1.0;

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: AdaptiveNavigationScaffold(
          selectedIndex: 0,
          destinations: _allDestinations,
          appBar: AdaptiveAppBar(
            leadingWidth: 80,
            title: const Text('Default Demo'),
            leading: const Icon(
              Icons.more_vert,
              key: Key('target'),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {},
          ),
          body: Container(
            color: Colors.green,
          ),
          navigationTypeResolver: (context) {
            return NavigationType.rail;
          },
        ),
      ),
    );

    expect(
      tester.getCenter(find.byKey(const Key('target'))).dx,
      tester.getCenter(find.byIcon(Icons.alarm)).dx,
    );
  });
}
