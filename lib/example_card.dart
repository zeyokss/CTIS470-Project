import 'package:flipera/example_candidate_model.dart';
import 'package:flutter/material.dart';

class ExampleCard extends StatelessWidget {
  final ExampleCandidateModel candidate;

  const ExampleCard(
    this.candidate, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.cyan,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16), // Added padding for better spacing
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Centers the text vertically
        crossAxisAlignment: CrossAxisAlignment.center, // Centers the text horizontally
        children: [
          Text(
            candidate.word,
            style: const TextStyle(
              fontFamily: "Montserrat",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            textAlign: TextAlign.center, // Centers the text inside the widget
          ),
          const SizedBox(height: 8),
          Text(
            candidate.type,
            style: const TextStyle(
              fontFamily: "Montserrat",
              color: Colors.white,
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            candidate.category,
            style: const TextStyle(color: Colors.white,
              fontFamily: "Montserrat",
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            candidate.definition,
            style: const TextStyle(color: Colors.white,
              fontFamily: "Montserrat",
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            candidate.example,
            style: const TextStyle(color: Colors.white,
              fontFamily: "Montserrat",
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
