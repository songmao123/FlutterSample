import 'package:flutter/material.dart';

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Friendly Chat',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.lightGreen[800],
        accentColor: Colors.cyan[600],
        fontFamily: 'Acme',
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Friendly Chat',
            // style: TextStyle(fontFamily: 'Lobster'),
          ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        drawer: Builder(
          builder: (context) => _NavigationDrawer(),
        ),
        body: OrientationList(),
      ),
    );
  }
}

class _NavigationDrawer extends StatelessWidget {
  const _NavigationDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Flutter Drawer',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.teal,
            ),
          ),
          ListTile(
            title: Text('Item1'),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: Text('Item2'),
            onTap: () {
              Navigator.of(context).pop();
              final snackBar = SnackBar(
                content: Text('Flutter Snackbar Text.'),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {},
                ),
              );
              Scaffold.of(context).showSnackBar(snackBar);
            },
          ),
        ],
      ),
    );
  }
}

class OrientationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        return GridView.count(
          crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
          children: List.generate(100, (index) {
            return GestureDetector(
              onTap: () {
                _showSnackbar(context);
              },
              child: Container(
                padding: EdgeInsets.only(left: 16.0),
                height: 35.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.star_border),
                    SizedBox(width: 10.0),
                    Text('Item $index'),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }

  void _showSnackbar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Flutter Snackbar Text.'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {},
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
