import 'package:flutter/material.dart';
import 'package:devpace/const.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> listItems = [];
  static const double minHeightLogo = ProgramsConst.MIN_HEIGHT_LOGO;
  static const int countColumnItemList = ProgramsConst.COUNT_COLUMN_ITEM_LIST;
  static const double paddingItemList = ProgramsConst.PADDING_ITEM_LIST;
  static const double aspectRatioItemList = ProgramsConst.ASPECT_RATIO_ITEM_LIST;
  void _addItem() {
    setState(() {
      listItems.add('Items ${listItems.length}');
    });
  }

  void _removeItem() {
    setState(() {
      if (listItems.isNotEmpty) {
        listItems.removeLast();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraint) {
        final double maxWidth = constraint.maxWidth;
        final double maxHeight = constraint.maxHeight;
        final int countRow = (listItems.length / countColumnItemList).ceil();
        final double heightItemList = ((maxWidth - ((countColumnItemList + 1) * paddingItemList))/countColumnItemList)
            /aspectRatioItemList * countRow +
            (countRow >= 2 ? (countRow - 1) * paddingItemList : 0.0) + paddingItemList*2.0;
        final double logoHeight = maxHeight - (listItems.isEmpty?0.0:heightItemList);
        return SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              SizedBox(
                width: maxWidth,
                height: maxHeight.clamp(minHeightLogo, logoHeight < minHeightLogo ? minHeightLogo:logoHeight),
                child: const Logo(),
              ),
              SizedBox(
                width: maxWidth,
                height: listItems.isEmpty? 0:heightItemList.toDouble(),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  primary: false,
                  padding: const EdgeInsets.all(paddingItemList),
                  itemCount: listItems.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: paddingItemList,
                    crossAxisSpacing: paddingItemList,
                    childAspectRatio: aspectRatioItemList,
                    crossAxisCount: countColumnItemList,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Item(name: listItems[index]);
                  },
                ),
              ),
            ],
          ),
        );
      }),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _removeItem,
            child: const Icon(Icons.delete),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: _addItem,
            child: const Icon(Icons.star),
          ),
        ],
      ),
    );
  }
}

class Item extends StatelessWidget {
  final String name;
  const Item({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Center(
        child: Text(
          name,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(ProgramsConst.MARGIN_LOGO),
      child: Center(child: Image.asset(ProgramsConst.IMAGE_PATH_LOGO)),
    );
  }
}
