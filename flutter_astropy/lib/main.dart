import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

void main() {
  runApp(const AstropyApp());
}

class AstropyApp extends StatelessWidget {
  const AstropyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Astropy Flutter',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    CoordinatesScreen(),
    UnitsScreen(),
    HelpScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Astropy Core'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () => _onItemTapped(2),
            tooltip: 'Open Help',
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Coordinates',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.straighten),
            label: 'Units',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: 'Help',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }
}

class CoordinatesScreen extends StatelessWidget {
  const CoordinatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Coordinates Calculator Screen',
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Coordinate Transformation',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'RA (hours)',
                hintText: 'e.g. 10.6847',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Dec (degrees)',
                hintText: 'e.g. 41.2687',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Convert to Galactic'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UnitsScreen extends StatelessWidget {
  const UnitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Units Conversion Screen',
      child: const Center(
        child: Text('Units & Quantities Module coming soon!'),
      ),
    );
  }
}

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Text(
            'Astropy Flutter Help',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 10),
          HelpItem(
            title: 'Coordinates',
            description: 'Learn how to convert between different celestial coordinate systems.',
            assetPath: 'assets/help/coordinates.txt',
          ),
          HelpItem(
            title: 'Units',
            description: 'Working with physical units and quantities in astronomy.',
            assetPath: 'assets/help/units.txt',
          ),
          const HelpItem(
            title: 'Accessibility',
            description: 'This app is designed to be accessible to all users, including support for screen readers and high contrast modes.',
          ),
        ],
      ),
    );
  }
}

class HelpItem extends StatelessWidget {
  final String title;
  final String description;
  final String? assetPath;

  const HelpItem({
    super.key,
    required this.title,
    required this.description,
    this.assetPath,
  });

  void _showHelpDialog(BuildContext context) async {
    String content = description;
    if (assetPath != null) {
      try {
        content = await DefaultAssetBundle.of(context).loadString(assetPath!);
      } catch (e) {
        content = "Error loading help file: $e";
      }
    }

    if (!context.mounted) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(child: Text(content)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(description),
        leading: const Icon(Icons.info_outline),
        onTap: () => _showHelpDialog(context),
      ),
    );
  }
}
