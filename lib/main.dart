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
  double _offset = 0;
  double _offset1 = 0;
  double _offset2 = 49;
  //final itemKey = GlobalKey();
  final _itemExtent = 100.0; //height of each container/card
  late bool _initFlag;
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

  void _changeOffset() {
    print('here');

    // WidgetsBinding.instance.addPostFrameCallback((_) =>
    setState(() {
      _initFlag = false;
      _offset = _offset2;

      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
    });
  }

// [SliverAppBar]s are typically used in [CustomScrollView.slivers], which in
// turn can be placed in a [Scaffold.body].

  //design specifics for jumping to the index
  @override
  void initState() {
    _offset =
        _offset1; //the inital starting point for the list - prob best to set to zero.
    _initFlag = true;
    super.initState();
  }
  //end of design parameters.

//main screen design
  @override
  Widget build(BuildContext context) {
//

    final generatedList = List.generate(500, (index) => 'Item $index');

    print('offset is');
    print(_offset);

    print('initFlag');
    print(_initFlag);

    _initFlag == true ? _offset = _offset1 : _offset = _offset2;

    print('offset now is');
    print(_offset);
    print('in scaffold');

    return Scaffold(
      body: CustomScrollView(
        controller:
            ScrollController(initialScrollOffset: _itemExtent * _offset),
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
          //
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
      floatingActionButton: FloatingActionButton(
        //corner button for user to scroll to...
        child: Icon(Icons.arrow_upward), //visual button.
        // onPressed: _changeOffset,

        //reloads the page
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyApp()),
          );
        },

//suppose to reload, but does not seem too...
        /*   onPressed: () => {
                _offset = _offSetNew,
                print(
                    'button pressed a'), //do something with the variables declared elsewhere
                print(_offset),
                setState(() {}),
                print(
                    'button pressed b'), //do something with the variables declared elsewhere
                print(_offset),
              } */

        ///end of reloading page to return to the top....
      ),

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
