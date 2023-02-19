import 'package:flutter/material.dart';

class CustomerOrderModel extends StatelessWidget {
  final dynamic order;
  const CustomerOrderModel({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.yellow),
            borderRadius: BorderRadius.circular(15)),
        child: ExpansionTile(
          title: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Container(
              constraints: const BoxConstraints(
                  maxHeight: 80, maxWidth: double.infinity),
              child: Row(
                children: [
                  Container(
                    constraints:
                        const BoxConstraints(maxHeight: 80, maxWidth: 80),
                    child: Image.network(order['orderimage']),
                  ),
                  Flexible(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        order['ordername'],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(('₹') +
                                (order['orderprice'].toStringAsFixed(2))),
                            Text(('x ') + (order['orderqty'].toString()))
                          ],
                        ),
                      )
                    ],
                  ))
                ],
              ),
            ),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [const Text('See more..'), Text(order['deliverystatus'])],
          ),
          children: [
            Container(
              // height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: order['deliverystatus'] == 'delivered'
                      ? Colors.brown.withOpacity(0.2)
                      : Colors.yellow.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(('Name: ') + (order['custname']),
                          style: const TextStyle(fontSize: 15)),
                      Text(('Phone No: ') + (order['phone']),
                          style: const TextStyle(fontSize: 15)),
                      Text(('Email address: ') + (order['email']),
                          style: const TextStyle(fontSize: 15)),
                      Text(('Address: ') + (order['address']),
                          style: const TextStyle(fontSize: 15)),
                      Row(
                        children: [
                          const Text(('Payment status: '),
                              style: TextStyle(fontSize: 15)),
                          Text((order['paymentstatus']),
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.purple)),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(('Delivery status: '),
                              style: TextStyle(fontSize: 15)),
                          Text((order['deliverystatus']),
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.green)),
                        ],
                      ),
                      order['deliverystatus'] == 'shipping'
                          ? Text(
                              ('Estimated Delivery Date: ') +
                                  (order['deliverydate']),
                              style: const TextStyle(fontSize: 15))
                          : const Text(''),
                      order['deliverystatus'] == 'delivered' &&
                              order['orderreview'] == false
                          ? TextButton(
                              onPressed: () {},
                              child: const Text('Write Review'))
                          : const Text(''),
                      order['deliverystatus'] == 'delivered' &&
                              order['orderreview'] == true
                          ? Row(
                              children: const [
                                Icon(
                                  Icons.check,
                                  color: Colors.blue,
                                ),
                                Text(
                                  'Review Added',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontStyle: FontStyle.italic),
                                )
                              ],
                            )
                          : const Text('')
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
