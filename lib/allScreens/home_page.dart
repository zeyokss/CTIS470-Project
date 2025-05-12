/* lib/allScreens/home_page.dart */
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:flutter_flip_card/flipcard/gesture_flip_card.dart';
import '../models/flashcard.dart';
import '../services/database_service.dart';
import '../example_candidate_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CardSwiperController controller = CardSwiperController();
  final GestureFlipCardController cong = GestureFlipCardController();

  Future<List<Flashcard>> _getAllFlashcards() async {
    List<Flashcard> candidateFlashcards = candidates
        .map((candidate) => Flashcard(
              term: candidate.word,
              definition: candidate.definition,
              category: candidate.category,
              example: candidate.example,
            ))
        .toList();
    List<Flashcard> dbFlashcards = await DatabaseService().getFlashcards();
    return [...candidateFlashcards, ...dbFlashcards];
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool _onSwipe(int previousIndex, int? currentIndex, CardSwiperDirection direction) {
    // Reset card to front if needed.
    cong.showFront();
    return true;
  }

  bool _onUndo(int? previousIndex, int currentIndex, CardSwiperDirection direction) {
    debugPrint('The card $currentIndex was undone from the ${direction.name}');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<Flashcard>>(
          future: _getAllFlashcards(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final flashcards = snapshot.data!;
            return Column(
              children: [
                Flexible(
                  child: CardSwiper(
                    controller: controller,
                    cardsCount: flashcards.length,
                    onSwipe: _onSwipe,
                    onUndo: _onUndo,
                    numberOfCardsDisplayed: 2,
                    backCardOffset: const Offset(40, 40),
                    padding: const EdgeInsets.all(24.0),
                    allowedSwipeDirection: AllowedSwipeDirection.only(
                      up: false,
                      down: false,
                      left: true,
                      right: true,
                    ),
                    cardBuilder: (context, index, horizontalThresholdPercentage, verticalThresholdPercentage) {
                      final flashcard = flashcards[index];
                      return GestureDetector(
                        onTap: () {
                          cong.flipcard();
                        },
                        child: GestureFlipCard(
                          enableController: true,
                          controller: cong,
                          animationDuration: const Duration(milliseconds: 800),
                          frontWidget: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.pinkAccent,
                              ),
                              child: Center(
                                child: Text(
                                  flashcard.term,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          backWidget: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.blueAccent,
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      flashcard.definition,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Example: "${flashcard.example}"',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white70,
                                        fontStyle: FontStyle.italic,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        onPressed: () => controller.swipe(CardSwiperDirection.left),
                        child: const Icon(Icons.keyboard_arrow_left),
                      ),
                      FloatingActionButton(
                        onPressed: controller.undo,
                        child: const Icon(Icons.rotate_left),
                      ),
                      FloatingActionButton(
                        onPressed: () => controller.swipe(CardSwiperDirection.right),
                        child: const Icon(Icons.keyboard_arrow_right),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

extension FlipCardReset on GestureFlipCardController {
  void showFront() {
    if (state != null && !state!.isFront) {
      state!.gestureflipCard();
    }
  }
}
