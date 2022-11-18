import 'package:flutter/material.dart';
import 'package:ecommerce_app/widgtes/appbar_widgets.dart';

List<String> label = [
  'MY STORE',
  'ORDERS',
  'EDIT PROFILE',
  'MANAGE PRODUCTS',
  'BALANCE',
  'STATSTICS'
];
List<IconData> icons = [
  Icons.store,
  Icons.shop_2_outlined,
  Icons.edit,
  Icons.settings_applications,
  Icons.attach_money,
  Icons.show_chart,
];

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppbarTitle(
          title: 'Dashboard',
        ),
        actions: [
          IconButton(
            //onPressed: ,
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: GridView.count(
            mainAxisSpacing: 50,
            crossAxisSpacing: 50,
            crossAxisCount: 2,
            children: List.generate(6, (index) {
              return Card(
                elevation: 20,
                shadowColor: Colors.purpleAccent.shade200,
                color: Colors.blueGrey.withOpacity(0.7),
                child: Column(children: [
                  Icon(
                    icons[index],
                    size: 50,
                    color: Colors.yellowAccent,
                  ),
                  Text(
                    label[index],
                    style: const TextStyle(
                      fontFamily: 'Acme',
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.yellowAccent,
                      letterSpacing: 2,
                    ),
                  )
                ]),
              );
            })),
      ),
    );
  }
}
