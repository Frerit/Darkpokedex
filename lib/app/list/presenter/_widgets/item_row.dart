import 'package:flutter/material.dart';

class ItemRow extends StatelessWidget {
  const ItemRow({Key? key, required this.left, required this.right})
      : super(key: key);

  final String left;
  final String right;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            left,
            style: const TextStyle(fontSize: 11),
          ),
          Text(
            right,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
