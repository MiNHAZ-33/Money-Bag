// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:moneybook/domain/app/user_profile.dart';
import 'package:moneybook/presentation/home/widgets/add_source.dart';
import 'package:moneybook/presentation/home/widgets/cash_box.dart';

class TopPart extends StatelessWidget {
  final UserProfile profile;
  const TopPart({
    Key? key,
    required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hello ${profile.name}",
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const Text(
            "List of sources",
            style: TextStyle(
              fontSize: 20,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 7,
                mainAxisSpacing: 2,
                childAspectRatio: 2,
                crossAxisCount: 3),
            itemCount: profile.sources.length + 1,
            itemBuilder: (context, index) {
              if (index == profile.sources.length) {
                return const AddSource();
              } else {
                return CashBox(profile.sources[index]);
              }
            },
          ),
        ],
      ),
    );
  }
}
