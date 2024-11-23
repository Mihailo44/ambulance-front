import 'package:ambulance_app/generic_widgets/custom_list_tile.dart';
import 'package:ambulance_app/generic_widgets/my_dialog.dart';
import 'package:ambulance_app/main.dart';
import 'package:ambulance_app/model/users/patient.dart';
import 'package:ambulance_app/navigation/provider.dart';
import 'package:ambulance_app/providers/patient_provider.dart';
import 'package:ambulance_app/screens/allergy/add_allergy_screen.dart';
import 'package:ambulance_app/screens/allergy/allergy_details_screen.dart';
import 'package:ambulance_app/screens/disability/add_disability_screen.dart';
import 'package:ambulance_app/screens/disability/disability_details_screen.dart';
import 'package:ambulance_app/screens/disease/add_disease_screen.dart';
import 'package:ambulance_app/screens/disease/disease_details_screen.dart';
import 'package:ambulance_app/screens/operation/add_operation_screen.dart';
import 'package:ambulance_app/screens/operation/operation_details_screen.dart';
import 'package:ambulance_app/util/buildFormatedTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:ui' as ui;

class MedicalInfoScreen extends ConsumerStatefulWidget {
  const MedicalInfoScreen({super.key});

  @override
  ConsumerState<MedicalInfoScreen> createState() => _MedicalInfoScreenState();
}

class _MedicalInfoScreenState extends ConsumerState<MedicalInfoScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late Patient patient;
  bool _showButtons = false;
  double _rotationAngle = 0;
  final List<String> _bloodTypes = [
    "A-",
    "A+",
    "B-",
    "B+",
    "AB+",
    "AB-",
    "O+",
    "O-"
  ];
  String? _selectedBloodType = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _rotateIcon() {
    setState(() {
      if (!_showButtons) {
        _rotationAngle += 0.5;
      } else {
        _rotationAngle = -0.5;
      }
    });
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

  void _addAllergy() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const AddAllergyScreen()));
  }

  void _addDisease() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const AddDiseaseScreen()));
  }

  void _addOperation() {
    FocusScope.of(context).unfocus();
    showModalBottomSheet(
        isDismissible: false,
        context: context,
        builder: (ctx) {
          return const AddOperationScreen();
        });
  }

  void _addDisability() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const AddDisabilityScreen()));
  }

  Future<bool?> _confirmBloodtypeModal() async {
    bool? result = await showDialog<bool>(
        context: context,
        builder: (ctx) {
          return const MyDialog();
        });

    return result;
  }

  void _changeBloodType() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return SizedBox(
            height: 320,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  const Text("Choose blood type"),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: DropdownButtonFormField<String>(
                        hint: const Text("Blood type"),
                        items: [
                          for (final b in _bloodTypes)
                            DropdownMenuItem(
                                value: b,
                                child: Text(
                                  b,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ))
                        ],
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedBloodType = value;
                          });
                        }),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        var nav = Navigator.of(context);
                        bool? result = await _confirmBloodtypeModal();

                        if (result == true) {
                          ref
                              .read(patientProvider.notifier)
                              .updateBloodType(_selectedBloodType!);
                        }

                        nav.pop();
                      },
                      child: const Text("Save changes"))
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final patient = ref.watch(patientProvider);

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
                ref.read(appBarVisibilityProvider.notifier).toggleVisibility();
                Navigator.of(context).pop();
              }
            }),
        title: Text(
          "Medical Information",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: Container(
        constraints:
            BoxConstraints(minHeight: MediaQuery.of(context).size.height),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
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
                          InkWell(
                            onTap: _changeBloodType,
                            child: buildFormattedTextField(
                                context, "Blood Type", patient!.bloodType),
                          ),
                          buildFormattedTextField(
                              context, "Gender", patient.gender),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (ctx) => DisabilityDetailsScreen(
                                      disabilites: patient.disabilites.toList()));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 4, 10, 15),
                              child: SizedBox(
                                height: 62,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Disabilities",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: patient.disabilites.isEmpty
                                          ? [
                                              const SizedBox.shrink()
                                            ]
                                          : [
                                              ...patient.disabilites.map((e) {
                                                final isFirst = patient.disabilites.toList().indexOf(e) == 0;
                                                return Padding(
                                                  padding: isFirst ? const EdgeInsets.all(0) : const EdgeInsets.only(left: 5),
                                                  child: Image.asset(
                                                    e.iconUrl,
                                                    width: 28,
                                                    height: 28,
                                                    color:
                                                        const Color.fromARGB(255, 21, 21, 21),
                                                  ),
                                                );
                                              }),
                                            ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      buildFormattedTextField(context, "Past Operations", ""),
                      patient.pastOperations == null ||
                              patient.pastOperations!.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text("No operations"),
                            )
                          : ListView.builder(
                              reverse: true,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  patient.pastOperations?.split(',').length,
                              itemBuilder: (ctx, idx) {
                                final operation = patient.pastOperations
                                    ?.split(',')[idx]
                                    .trim();
                                if (operation!.isEmpty) return null;
                                return CustomListTile(
                                  title: operation,
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (ctx) =>
                                            OperationDetailsScreen(
                                              name: operation,
                                            ));
                                  },
                                  mode: Mode.display,
                                );
                              }),
                      const SizedBox(
                        height: 12,
                      ),
                      buildFormattedTextField(context, "Allergies", ""),
                      patient.alergies.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text("No alergies"),
                            )
                          : ListView.builder(
                              reverse: true,
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
                                        allergy: patient.alergies[idx],
                                      ),
                                    );
                                  },
                                  mode: Mode.display,
                                );
                              }),
                      const SizedBox(
                        height: 12,
                      ),
                      buildFormattedTextField(context, "Diseases", ""),
                      patient.diseases.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text("No diseases"),
                            )
                          : ListView.builder(
                              reverse: true,
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
                                        disease: patient.diseases[idx],
                                      ),
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
              Visibility(
                visible: _showButtons,
                child: AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  bottom: 140,
                  child: AnimatedOpacity(
                    opacity: _showButtons ? 1 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Column(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
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
                          onPressed: () {
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
                          onPressed: () {
                            _toggleButtons();
                            _addDisability();
                          },
                          label: const Text("Add Disability"),
                          icon: const Icon(Icons.add),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
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
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.small(
        onPressed: _scrollToBottom,
        backgroundColor: const Color.fromARGB(255, 201, 200, 197),
        foregroundColor: Colors.white,
        child: const Icon(Icons.arrow_downward),
      ),
    );
  }
}
