import 'package:adopt_me/Providers/adoption_provider.dart';
import 'package:adopt_me/Screens/home_views.dart/photo_view.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../main.dart';

class DetailsScreen extends ConsumerWidget {
  final Map<String, dynamic> data;
  const DetailsScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final windoHeight = MediaQuery.of(context).size.height;
    final adoptionPvd = ref.watch(adoptionProvider);
    return Scaffold(
      body: Hero(
        tag: data["name"],
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: ConfettiWidget(
                      numberOfParticles: 50,
                      maxBlastForce: 100,
                      minBlastForce: 20,
                      gravity: 0.7,
                      confettiController: adoptionPvd.controllerCenter,
                      blastDirectionality: BlastDirectionality
                          .explosive, // don't specify a direction, blast randomly
                      shouldLoop:
                          false, // start again as soon as the animation is finished
                      colors: const [
                        Colors.green,
                        Colors.blue,
                        Colors.pink,
                        Colors.orange,
                        Colors.purple
                      ], // manually specify the colors to be used
                      createParticlePath:
                          adoptionPvd.drawStar, // define a custom shape/path.
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PhotoView(imageUrl: data["image"]),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20.0),
                      alignment: Alignment.topCenter,
                      height: windoHeight * 0.45,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            data["image"],
                          ),
                        ),
                      ),
                      child: SafeArea(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data['name'] + "  ⚦",
                            style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: windoHeight * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data['breed'],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            "${data['age'].toString()} year",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(width: 20),
                          const Text(
                            "18.5kgs",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: windoHeight * 0.03),
                      Text(
                        "${data["name"]} will play an essential role in human life and planet earth. Ever since an early time, humans have been using animals for their benefit. Earlier, they came in use for transportation purposes. Further, they also come in use for food, hunting and protection.",
                        textAlign: TextAlign.justify,
                        style: const TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: windoHeight * 0.05),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Adopt Now For:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '\$1800',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: windoHeight * 0.06),
                      data['isAdopted'] == false
                          ? Align(
                              alignment: Alignment.bottomCenter,
                              child: RoundedLoadingButton(
                                controller: adoptionPvd.btnController,
                                borderRadius: 10,
                                onPressed: () {
                                  adoptionPvd.adoptPet(
                                    data["name"],
                                    true,
                                    data["breed"],
                                    data['image'],
                                    data['fromCollection'],
                                  );
                                },
                                child: const Text('Adopt'),
                              ),
                            )
                          : Align(
                              alignment: Alignment.bottomCenter,
                              child: GestureDetector(
                                onTap: () {
                                  const SnackBar snackBar = SnackBar(
                                    content: Text(
                                      "Sorry, we currently don't have him",
                                    ),
                                  );
                                  snackbarKey.currentState
                                      ?.showSnackBar(snackBar);
                                },
                                child: Container(
                                  height: 50,
                                  width: 300,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Center(
                                    child: Text('Adopt'),
                                  ),
                                ),
                              ),
                            ),
                    ],
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
