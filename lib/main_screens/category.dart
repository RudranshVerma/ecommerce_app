import 'package:ecommerce_app/categories/Women_categ.dart';
import 'package:ecommerce_app/main_screens/home.dart';
import 'package:flutter/material.dart';

List<ItemData> items = [
  ItemData(label: 'men'),
  ItemData(label: 'women'),
  ItemData(label: 'shoes'),
  ItemData(label: 'bags'),
  ItemData(label: 'electronics'),
  ItemData(label: 'accessories'),
  ItemData(label: 'home&garden'),
  ItemData(label: 'kids'),
  ItemData(label: 'beauty'),
];

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final PageController _pageController = PageController();
  @override
  void initState() {
    // when we switch to any other tab the page view switches to intial category but the tab is not  for this we use initstate
    for (var element in items) {
      element.isSelected = false;
    }
    setState(() {
      items[0].isSelected = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          elevation: 0, backgroundColor: Colors.white, title: FakeSearch()),
      body: Stack(children: [
        Positioned(bottom: 0, left: 0, child: sideNavigator(size)),
        Positioned(bottom: 0, right: 0, child: categView(size))
      ]),
    );
  }

  Widget sideNavigator(Size size) {
    return SizedBox(
      height: size.height * 0.8,
      width: size.width * 0.2,
      child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // on tapping the any category the page view text animate
                _pageController.animateToPage(index,
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.bounceInOut);
                /*for (var element in items) {
                  element.isSelected = false;
                }
                setState(() {
                  items[index].isSelected = true;
                });*/
              },
              child: Container(
                  color: items[index].isSelected == true
                      ? Colors.white
                      : Colors.grey.shade300,
                  height: 100,
                  child: Center(child: Text(items[index].label))),
            );
          }),
    );
  }

  Widget categView(Size size) {
    return Container(
      height: size.height * 0.8,
      width: size.width * 0.8,
      color: Colors.white,
      child: PageView(
        // when we scroll the page the tab is changed on left
        controller: _pageController,
        onPageChanged: (value) {
          for (var element in items) {
            element.isSelected = false;
          }
          setState(() {
            items[value].isSelected = true;
          });
        },
        scrollDirection: Axis.vertical,
        children: const [
          Center(child: Text('men category')),
          WomenCategory(),
          Center(child: Text('shoes category')),
          Center(child: Text('bags category')),
          Center(child: Text('electronics category')),
          Center(child: Text('accessories category')),
          Center(child: Text('home and garden category')),
          Center(child: Text('kids category')),
          Center(child: Text('beauty category')),
        ],
      ),
    );
  }
}

class ItemData {
  String label;
  bool isSelected;
  ItemData({required this.label, this.isSelected = false});
}
