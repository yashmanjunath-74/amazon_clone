import 'package:flutter/material.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({super.key});

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 10, top: 15),
          child: const Text(
            'Deal  of the day',
            style: TextStyle(fontSize: 20),
          ),
        ),
        Image.network(
          'https://images.samsung.com/in/smartphones/galaxy-s25-ultra/buy/product_color_jetBlack_PC.png?imbypass=true',
          height: 235,
          fit: BoxFit.fitHeight,
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 15),
          child: Row(children: const [
            Text('₹'),
            SizedBox(width: 5),
            Text(
              '70000',
              style: TextStyle(fontSize: 18),
            ),
          ]),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
          child: const Text(
            'Samsung',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                'https://images.samsung.com/is/image/samsung/p6pim/in/2501/gallery/in-galaxy-s25-s938-sm-s938bakcins-544703062?imbypass=true',
                fit: BoxFit.fitWidth,
                width: 100,
              ),
              Image.network(
                'https://images.samsung.com/is/image/samsung/p6pim/in/2501/gallery/in-galaxy-s25-s938-sm-s938bakcins-544703027?imbypass=true',
                fit: BoxFit.fitWidth,
                width: 100,
              ),
              Image.network(
                'https://images.samsung.com/is/image/samsung/p6pim/in/2501/gallery/in-galaxy-s25-s938-sm-s938bakcins-544703030?imbypass=true',
                fit: BoxFit.fitWidth,
                width: 100,
              ),
              Image.network(
                'https://images.samsung.com/is/image/samsung/p6pim/in/2501/gallery/in-galaxy-s25-s938-sm-s938bakcins-544703028?imbypass=true',
                fit: BoxFit.fitWidth,
                width: 100,
              ),
              Image.network(
                'https://images.samsung.com/is/image/samsung/p6pim/in/2501/gallery/in-galaxy-s25-s938-sm-s938bakcins-544703029?imbypass=true',
                fit: BoxFit.fitWidth,
                width: 100,
              ),
              Image.network(
                'https://images.samsung.com/is/image/samsung/p6pim/in/2501/gallery/in-galaxy-s25-s938-sm-s938bakcins-544703031?imbypass=true',
                fit: BoxFit.fitWidth,
                width: 100,
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.symmetric(
            vertical: 15,
          ).copyWith(left: 15),
          child: Text(
            'see all ',
            style: TextStyle(color: Colors.cyan[800]),
          ),
        )
      ],
    );
  }
}
