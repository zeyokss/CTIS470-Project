// lib/allScreens/home_page.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:flutter_flip_card/flipcard/gesture_flip_card.dart';
import '../models/flashcard.dart';
import '../services/database_service.dart';
import '../services/firestore_service.dart';
import '../example_candidate_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CardSwiperController controller = CardSwiperController();
  final GestureFlipCardController flipController = GestureFlipCardController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<List<Flashcard>>(
          stream: FirestoreService().flashcardStream(),
          builder: (context, fsSnap) {
            if (fsSnap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final cloudCards = fsSnap.data ?? [];
            return FutureBuilder<List<Flashcard>>(
              future: DatabaseService().getFlashcards(),
              builder: (context, dbSnap) {
                if (dbSnap.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final local = dbSnap.data ?? [];
                final localOnly = local.where((c) => c.firestoreId == null);
                final examples = _convertCandidates(candidates);
                final allCards = [...examples, ...localOnly, ...cloudCards];

                if (allCards.isEmpty) {
                  return const Center(child: Text('No flashcards available.'));
                }

                return Column(
                  children: [
                    Expanded(
                      child: CardSwiper(
                        controller: controller,
                        cardsCount: allCards.length,
                        onSwipe: _onSwipe,
                        onUndo: _onUndo,
                        numberOfCardsDisplayed: 2,
                        backCardOffset: const Offset(40, 40),
                        padding: const EdgeInsets.all(24),
                        allowedSwipeDirection: AllowedSwipeDirection.only(
                          up: false, down: false, left: true, right: true,
                        ),
                        cardBuilder: (ctx, index, _, __) {
                          final card = allCards[index];
                          return GestureDetector(
                            onTap: () => flipController.flipcard(),
                            child: GestureFlipCard(
                              enableController: true,
                              controller: flipController,
                              animationDuration: const Duration(milliseconds: 800),
                              frontWidget: _buildFront(card),
                              backWidget: _buildBack(card),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // ← previous
                          FloatingActionButton(
                            onPressed: () {
                              flipController.showFront();
                              controller.undo();
                            },
                            child: const Icon(Icons.keyboard_arrow_left),
                          ),
                          // ○ random
                          FloatingActionButton(
                            onPressed: () {
                              flipController.showFront();
                              final rnd = Random().nextInt(allCards.length);
                              controller.moveTo(rnd);
                            },
                            child: const Icon(Icons.refresh),
                          ),
                          // → next
                          FloatingActionButton(
                            onPressed: () {
                              flipController.showFront();
                              controller.swipe(CardSwiperDirection.right);
                            },
                            child: const Icon(Icons.keyboard_arrow_right),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<bool> _onSwipe(int prev, int? curr, CardSwiperDirection d) async {
    flipController.showFront();
    return true;
  }

  bool _onUndo(int? prev, int curr, CardSwiperDirection d) {
    flipController.showFront();
    return true;
  }

  Widget _buildFront(Flashcard f) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.pinkAccent,
        ),
        child: Center(
          child: Text(
            f.term,
            style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );

  Widget _buildBack(Flashcard f) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.blueAccent,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  f.definition,
                  style: const TextStyle(
                    fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Example: "${f.example}"',
                  style: const TextStyle(
                    fontSize: 16, color: Colors.white70, fontStyle: FontStyle.italic
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );

  List<Flashcard> _convertCandidates(List<ExampleCandidateModel> ex) =>
      ex.map((e) => Flashcard(
            id: null,
            firestoreId: null,
            term: e.word,
            definition: e.definition,
            category: e.category,
            example: e.example,
          )).toList();
}

extension FlipCardReset on GestureFlipCardController {
  void showFront() {
    if (state != null && !state!.isFront) state!.gestureflipCard();
  }
}
