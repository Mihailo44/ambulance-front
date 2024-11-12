import 'package:ambulance_app/generic_widgets/custom_list_tile.dart';
import 'package:ambulance_app/main.dart';
import 'package:ambulance_app/model/users/patient.dart';
import 'package:ambulance_app/navigation/provider.dart';
import 'package:ambulance_app/screens/allergy/add_allergy_screen.dart';
import 'package:ambulance_app/screens/allergy/allergy_details_screen.dart';
import 'package:ambulance_app/screens/details/disease_details_screen.dart';
import 'package:ambulance_app/util/buildFormatedTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:ui' as ui;

class MedicalInfoScreen extends ConsumerStatefulWidget {
  const MedicalInfoScreen({required this.patient, super.key});
  final Patient patient;

  @override
  ConsumerState<MedicalInfoScreen> createState() => _MedicalInfoScreenState();
}

class _MedicalInfoScreenState extends ConsumerState<MedicalInfoScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late Patient patient;
  bool _showButtons = false;
  double _rotationAngle = 0; // Unique key value to trigger reanimation

  void _rotateIcon() {
    setState(() {
      _rotationAngle += 0.5; // Increment the key to trigger the rotation animation
    });
  }

  @override
  void initState() {
    super.initState();
    patient = widget.patient;
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _scrollToBottom() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInCirc);
  }

  void _toggleButtons() {
    setState(() {
      _showButtons = !_showButtons;
    });
  }

  void _addAllergy(){
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const AddAllergyScreen()));
  }

  void _addDisease(){

  }

  void _addOperation(){}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromARGB(255, 255, 251, 240),
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
                ref.read(appBarVisibilityProvider.notifier).toggleVisibility();
                Navigator.of(context).pop();
              }
            }),
        title: Text(
          "Medical Information",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Scrollbar(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        buildFormattedTextField(
                            context, "Blood Type", patient.bloodType),
                        buildFormattedTextField(
                            context, "Gender", patient.gender)
                      ],
                    ),
                    buildFormattedTextField(context, "Past Operations", ""),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: patient.pastOperations?.split(',').length,
                        itemBuilder: (ctx, idx) {
                          final operation =
                              patient.pastOperations?.split(',')[idx].trim();
                          return CustomListTile(
                            title: operation!,
                            onPressed: () {},
                            mode: Mode.none,
                          );
                        }),
                    const SizedBox(
                      height: 12,
                    ),
                    buildFormattedTextField(context, "Allergies", ""),
                    patient.alergies.isEmpty
                        ? const Text("No alergies")
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: patient.alergies.length,
                            itemBuilder: (ctx, idx) {
                              return CustomListTile(
                                title: patient.alergies[idx].allergen,
                                onPressed: () {
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (ctx) => AllergyDetailsScreen(
                                          allergy: patient.alergies[idx]));
                                },
                                mode: Mode.display,
                              );
                            }),
                    const SizedBox(
                      height: 12,
                    ),
                    buildFormattedTextField(context, "Diseases", ""),
                    patient.diseases.isEmpty
                        ? const Text("No diseases")
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: patient.diseases.length,
                            itemBuilder: (ctx, idx) {
                              return CustomListTile(
                                title: patient.diseases[idx].name,
                                onPressed: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (ctx) => DiseaseDetailsScreen(
                                        disease: patient.diseases[idx]),
                                  );
                                },
                                mode: Mode.display,
                              );
                            }),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 46),
              child: ElevatedButton.icon(
                style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                      backgroundColor:
                          const WidgetStatePropertyAll(Colors.amber),
                      minimumSize:
                          const WidgetStatePropertyAll(ui.Size(75, 75)),
                      foregroundColor:
                          const WidgetStatePropertyAll(Colors.white),
                    ),
                onPressed: () {
                  _rotateIcon();
                  _toggleButtons();
                },
                label: TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 250),
                    tween: Tween<double>(begin: 0, end: _rotationAngle),
                    builder: (context, angle, child) {
                      return Transform.rotate(
                        angle: angle * 3.1416 * 2,
                        child: child,
                      );
                    },
                    child: const Icon(
                      Icons.add,
                      size: 34,
                    ),    
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              bottom: 140,
              child: AnimatedOpacity(
                opacity: _showButtons ? 1 : 0,
                duration: const Duration(milliseconds: 300),
                child: Column(
                  children: [
                    ElevatedButton.icon(
                      onPressed: (){
                        _toggleButtons();
                        _addAllergy();
                      },
                      label: const Text("Add Allergy"),
                      icon: const Icon(Icons.add),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton.icon(
                      onPressed: (){
                        _toggleButtons();
                        _addDisease();
                      },
                      label: const Text("Add Disease"),
                      icon: const Icon(Icons.add),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton.icon(
                      onPressed: (){
                        _toggleButtons();
                        _addOperation();
                      },
                      label: const Text("Add Operation"),
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.small(
        onPressed: _scrollToBottom,
        backgroundColor: const Color.fromARGB(255, 255, 247, 224),
        foregroundColor: Colors.amber,
        child: const Icon(Icons.arrow_downward),
      ),
    );
  }
}
