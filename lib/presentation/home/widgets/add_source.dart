import 'package:flutter/material.dart';

class AddSource extends StatelessWidget {
  const AddSource({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        //color: Colors.deepPurple[400],
        border: Border.all(color: Colors.deepPurple),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Add Source',
            style: TextStyle(
                color: Colors.deepPurple, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Text(
            '+',
            style: TextStyle(color: Colors.deepPurple, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
