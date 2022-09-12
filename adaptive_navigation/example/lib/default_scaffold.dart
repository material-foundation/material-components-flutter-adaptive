import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: DefaultScaffoldDemo()));
}

class DefaultScaffoldDemo extends StatefulWidget {
  const DefaultScaffoldDemo({Key? key}) : super(key: key);

  @override
  DefaultScaffoldDemoState createState() => DefaultScaffoldDemoState();
}

class DefaultScaffoldDemoState extends State<DefaultScaffoldDemo> {
  int _destinationCount = 5;
  bool _fabInRail = false;
  bool _fabInPermanentDrawer = false;
  bool _includeBaseDestinationsInMenu = true;

  @override
  Widget build(BuildContext context) {
    return AdaptiveNavigationScaffold(
      selectedIndex: 0,
      destinations: _allDestinations.sublist(0, _destinationCount),
      appBar: AdaptiveAppBar(title: const Text('Default Demo')),
      body: _body(),
      floatingActionButton: AdaptiveFloatingActionButton(
        onPressed: () {},
        isExtended: true,
        label: const Text('Compose'),
        icon: const Icon(Icons.add),
      ),
      drawerHeader: const DrawerHeader(
        child: FlutterLogo(),
      ),
      permanentDrawerFooter: _permanentDrawerFooter(),
      navigationRailTrailing: _navigationRailTrailing(),
      fabInRail: _fabInRail,
      fabInPermanentDrawer: _fabInPermanentDrawer,
      includeBaseDestinationsInMenu: _includeBaseDestinationsInMenu,
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('''
          This is the default behavior of the AdaptiveNavigationScaffold.
          It switches between bottom navigation, navigation rail, and a permanent drawer.
          Resize the window to switch between the navigation types.
          '''),
          const SizedBox(height: 40),
          Slider(
            min: 2,
            max: _allDestinations.length.toDouble(),
            divisions: _allDestinations.length - 2,
            value: _destinationCount.toDouble(),
            label: _destinationCount.toString(),
            onChanged: (value) {
              setState(() {
                _destinationCount = value.round();
              });
            },
          ),
          const Text('Destination Count'),
          const SizedBox(height: 40),
          Switch(
            value: _fabInRail,
            onChanged: (value) {
              setState(() {
                _fabInRail = value;
              });
            },
          ),
          const Text('fabInRail'),
          const SizedBox(height: 40),
          Switch(
            value: _fabInPermanentDrawer,
            onChanged: (value) {
              setState(() {
                _fabInPermanentDrawer = value;
              });
            },
          ),
          const Text('fabInPermanentDrawer'),
          const SizedBox(height: 40),
          Switch(
            value: _includeBaseDestinationsInMenu,
            onChanged: (value) {
              setState(() {
                _includeBaseDestinationsInMenu = value;
              });
            },
          ),
          const Text('includeBaseDestinationsInMenu'),
          const SizedBox(height: 40),
          ElevatedButton(
            child: const Text('BACK'),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
    );
  }

  Widget _navigationRailTrailing() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: CircleAvatar(child: Icon(Icons.person)),
          ),
        ],
      ),
    );
  }

  Widget _permanentDrawerFooter() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const CircleAvatar(child: Icon(Icons.person)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Joe',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(
                  'Sign out',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

const _allDestinations = [
  AdaptiveScaffoldDestination(
    title: 'Alarm',
    icon: Icons.alarm,
    /// Optional parameter to use for navigation
    path: '/alarm',
  ),
  AdaptiveScaffoldDestination(title: 'Book', icon: Icons.book),
  AdaptiveScaffoldDestination(title: 'Cake', icon: Icons.cake),
  AdaptiveScaffoldDestination(title: 'Directions', icon: Icons.directions),
  AdaptiveScaffoldDestination(title: 'Email', icon: Icons.email),
  AdaptiveScaffoldDestination(title: 'Favorite', icon: Icons.favorite),
  AdaptiveScaffoldDestination(title: 'Group', icon: Icons.group),
  AdaptiveScaffoldDestination(title: 'Headset', icon: Icons.headset),
  AdaptiveScaffoldDestination(title: 'Info', icon: Icons.info),
];
