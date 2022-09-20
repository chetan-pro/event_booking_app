import 'package:flutter/material.dart';




class Example extends StatefulWidget {




  const Example({ Key? key }) : super(key: key);





  @override
  State<Example> createState() => _ExampleState();
  
}

class _ExampleState extends State<Example> {



// ignore: prefer_typing_uninitialized_variables
var textColor;

late ScrollController _scrollController;
//----------
@override
void initState() {
  // ignore: todo
  // TODO: implement initState
  super.initState();

  _scrollController = ScrollController()
    ..addListener(() {
      setState(() {
        textColor = _isSliverAppBarExpanded ? Colors.white : Colors.amber;
      });
    });
}
//----------
bool get _isSliverAppBarExpanded {
  return _scrollController.hasClients &&
      _scrollController.offset > (200 - kToolbarHeight);
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: CustomScrollView(
         controller: _scrollController,
    slivers: <Widget>[
      //2
      SliverAppBar(
        pinned: true,snap: false,floating: false,
        expandedHeight: 250.0,
        flexibleSpace: FlexibleSpaceBar(
          title: Text('Goa', textScaleFactor: 1, style: TextStyle(color: textColor),),
          // background: Image.asset(
          //   'assets/images/beach.png',
          //   fit: BoxFit.fill,
          // ),
        ),
      ),
      //3
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (_, int index) {
            return ListTile(
              leading: Container(
                  padding: const EdgeInsets.all(8),
                  width: 100,
                  child: const Placeholder()),
              title: Text('Place ${index + 1}', textScaleFactor: 2),
            );
          },
          childCount: 20,
        ),
      ),
    ],
  ),

    );
  }
}