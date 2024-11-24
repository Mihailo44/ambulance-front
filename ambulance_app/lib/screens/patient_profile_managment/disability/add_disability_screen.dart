import 'package:ambulance_app/generic_widgets/custom_list_tile.dart';
import 'package:ambulance_app/generic_widgets/trauma_type_card.dart';
import 'package:ambulance_app/main.dart';
import 'package:ambulance_app/model/disability.dart';
import 'package:ambulance_app/providers/disability_provider.dart';
import 'package:ambulance_app/providers/patient_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddDisabilityScreen extends ConsumerStatefulWidget {
  const AddDisabilityScreen({super.key});

  @override
  ConsumerState<AddDisabilityScreen> createState() =>
      _AddDisabilityScreenState();
}

class _AddDisabilityScreenState extends ConsumerState<AddDisabilityScreen> {
  final Map<int, bool> isTapped = {};

  @override
  void initState() {
    super.initState();
    _initMap();
  }

  void _addDisabilites() {
    List<Disability> disabilites = [];
    for (var e in isTapped.entries) {
      if (e.value) {
        disabilites.add(ref.read(disabilityProvider)[e.key]);
      }
    }
    ref.read(patientProvider.notifier).addDisabilites(disabilites);
    Navigator.of(context).pop();
  }

  void _onTap(int idx) {
    setState(() {
      isTapped[idx] = !(isTapped[idx] ?? false);
    });
  }

  void _initMap() {
    ref.read(disabilityProvider).forEach((e) {
      isTapped[e.id] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final allDisabilites = ref.read(disabilityProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 255, 249, 234),
        scrolledUnderElevation: 0,
        leading: IconButton(
            iconSize: 32,
            color: Colors.amber,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(9),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(3),
              child: Text(
                "Select Disabilities",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                childAspectRatio: 1.1 / 1,
              ),
              shrinkWrap: true,
              itemCount: allDisabilites.length,
              itemBuilder: (ctx, idx) {

                List<String> name = allDisabilites[idx].name.split("_");
                var result =
                name[0].substring(0, 1) + name[0].substring(1).toLowerCase();
                
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: InkWell(
                    onTap: () {
                      _onTap(idx);
                    },
                    splashColor: const Color.fromARGB(255, 246, 246, 168),
                    borderRadius: BorderRadius.circular(12),
                    child: Card(
                      color: isTapped[idx]!
                          ? const Color.fromARGB(255, 255, 255, 227)
                          : const Color.fromARGB(255, 255, 254, 248),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          alignment: const Alignment(0, 0),
                          child: Text(
                            name.length == 1 ? result : "$result ${name[1].toLowerCase()}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              overflow: TextOverflow.visible,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: isTapped[idx]!
                                  ? const Color.fromARGB(255, 196, 191, 115)
                                  : const Color.fromARGB(255, 2, 41, 108),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 160,
            ),
            Center(
              child: ElevatedButton.icon(
                onPressed: _addDisabilites,
                label: const Text("Add"),
                icon: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
