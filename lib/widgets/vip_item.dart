import 'package:flutter/material.dart';

import '../vip/vip_page.dart';

class VipItem extends StatelessWidget {
  final String type;
  final String itemName;
  final String weeklyPrice;
  final String monthlyPrice;
  const VipItem({
    super.key,
    required this.itemName,
    required this.type,
    required this.monthlyPrice,
    required this.weeklyPrice,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VipPage(
              sectionId: type,
              itemName: itemName,
              type: type,
              weeklyPrice: weeklyPrice,
              monthlyPrice: monthlyPrice,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color.fromARGB(195, 0, 0, 0),
            border: Border.all(
              color: Colors.amber,
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  itemName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
