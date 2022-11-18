import 'package:flutter/material.dart';

class WomenCategory extends StatelessWidget {
  const WomenCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(30.0),
          child: Text(
            'Women',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 1.5),
          ),
        ),
        Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.68,
              child: GridView.count(
                mainAxisSpacing: 25,
                crossAxisSpacing: 15,
                crossAxisCount: 3,
                children: List.generate(12, (index) {
                  return SizedBox(
                    // color: Colors.blue,
                    height: 50,
                    width: 50,
                    child: Image(
                      image: AssetImage(
                          'images/women/woman$index.jpg'), //'images/women/woman0.jpg'
                    ),
                  );
                }),
              ),
            ),
            Text('shirt')
          ],
        )
      ],
    );
  }
}
