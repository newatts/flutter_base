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
  bool currentSource = true;
  int _offset = 10;
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
    final int _offSetInitial = 10;
    final int _offSetNew = 30;
    // final _offSetNew2 = 40;

    final _itemExtent = 100.0; //height of each container/card
    final generatedList = List.generate(50, (index) => 'Item $index');

    print('offset is');
    print(_offset);

    print('offset');
    print(_offset);
    print('in scaffold');

    return Scaffold(
      body: CustomScrollView(
        ///

        /*   controller: ScrollController(
            initialScrollOffset: _itemExtent *
                _offset), //  //sets starting point, as multiple of the height of the containers/cards
        */
        /*  controller: ScrollController(
            initialScrollOffset: _offset == null
                ? _itemExtent * _offSetInitial
                : (_offset != _offSetInitial
                    ? _itemExtent * _offSetNew
                    : _itemExtent * _offSetNew2)),
           */
        controller:
            ScrollController(initialScrollOffset: _itemExtent * _offset),
/*
         if {
      print('in if');
      _offset = _offSetInitial;
      controller:
      ScrollController(initialScrollOffset: _itemExtent * _offset);
    } else {
      print('in else');
      _offset = _offSetNew;
      controller:
      ScrollController(initialScrollOffset: _itemExtent * _offset); //
    } */
        //
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
      floatingActionButton: FloatingActionButton(
        //corner button for user to scroll to...
        child: Icon(Icons.arrow_upward), //visual button.

        /*    //reloads the page
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyApp()),
          );
        }, */

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

        onPressed: () {
          print('button pressed b');

          setState(() {
            _offset = _offSetNew;
          });
        },
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
