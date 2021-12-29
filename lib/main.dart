import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  //final itemKey = GlobalKey();
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;
// [SliverAppBar]s are typically used in [CustomScrollView.slivers], which in
// turn can be placed in a [Scaffold.body].

  //design specifics for jumping to the index
  @override
  void initState() {
    super.initState();
  }
  //end of design parameters.

//main screen design
  @override
  Widget build(BuildContext context) {
//
    final _itemExtent = 56.0;
    final generatedList = List.generate(500, (index) => 'Item $index');

//
    return Scaffold(
      body: CustomScrollView(
        ///
        controller: ScrollController(initialScrollOffset: _itemExtent * 401),

        ///
        slivers: <Widget>[
          SliverAppBar(
            pinned:
                _pinned, //the original code allows the user to choose how it appears...
            snap: _snap, //see below to disable or leave enabled.
            floating: _floating,
            backgroundColor: Colors.teal[800],
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.fadeTitle,
                StretchMode.blurBackground,
              ],
              title: Text('Horizons'),
              background: DecoratedBox(
                position: DecorationPosition.foreground,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors: <Color>[Colors.teal[800]!, Colors.transparent],
                  ),
                ),
                child: FlutterLogo(),

                /* Image.network(
                      headerImage,
                      fit: BoxFit.cover,
                    ), */
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
              child: Center(
                child: Text('Scroll to see the SliverAppBar in effect.'),
              ),
            ),
          ),
          //        SliverList(
          ///
          SliverFixedExtentList(
            itemExtent: _itemExtent, // I'm forcing item heights
            ///
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  color: index.isOdd ? Colors.white : Colors.black12,
                  height: 100.0,
                  child: Center(
                    child: //Text('$index', textScaleFactor: 5),
                        ////
                        Text(
                      generatedList[index],
                      style: TextStyle(fontSize: 20.0),
                      ////
                    ),
                  ),
                );
              },
              childCount:
                  generatedList.length, // 200, //the limit of builds of index
            ),
          ),
        ],
      ),
      //flating action button, set for jumping to the top (zero) or what ever you choose.
      /*  floatingActionButton: FloatingActionButton(
        //corner button for user to scroll to...
        child: Icon(Icons.arrow_upward), //visual button.
        onPressed: () => scrollToItem(
            0), 
      ), */

      //buttom navigation bar, if dispalyed
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: OverflowBar(
            overflowAlignment: OverflowBarAlignment.center,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('pinned'),
                  Switch(
                    onChanged: (bool val) {
                      setState(() {
                        _pinned = val;
                      });
                    },
                    value: _pinned,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('snap'),
                  Switch(
                    onChanged: (bool val) {
                      setState(() {
                        _snap = val;
                        // Snapping only applies when the app bar is floating.
                        _floating = _floating || _snap;
                      });
                    },
                    value: _snap,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('floating'),
                  Switch(
                    onChanged: (bool val) {
                      setState(() {
                        _floating = val;
                        _snap = _snap && _floating;
                      });
                    },
                    value: _floating,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
