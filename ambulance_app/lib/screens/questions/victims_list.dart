import 'package:ambulance_app/generic_widgets/custom_list_tile.dart';
import 'package:ambulance_app/main.dart';
import 'package:ambulance_app/model/users/unregistered_user.dart';
import 'package:ambulance_app/screens/questions/add_patient_screen.dart';
import 'package:ambulance_app/util/snackbar.dart';
import 'package:flutter/material.dart';

class VictimList extends StatefulWidget {
  const VictimList({super.key});

  @override
  State<VictimList> createState() => _VictimListState();
}

class _VictimListState extends State<VictimList> {
  final List<String> patients = [];
  final List<UnregisteredUser> unregistered = [];

  @override
  void initState() {
    super.initState();
    patients.add("P1");
    patients.add("P2");
  }

  void _addPatient(String patient) {
    if (patient.isNotEmpty) {
      setState(() {
        patients.add(patient);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: width < 550
          ? Column(children: [
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                    minimumSize: const Size(160, 75),
                    backgroundColor: const Color.fromARGB(255, 255, 99, 88),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      patients.add("me");
                      //TODO umesto me staviti username
                    });
                    showModalBottomSheet(
                      context: context,
                      builder: (ctx) => const Text("Write your address"),
                    );
                  },
                  child: const Text(
                    "Send Ambulance For Me",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                    minimumSize: const Size(160, 75),
                    backgroundColor: const Color.fromARGB(255, 255, 99, 88),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => AddPatientScreen(onAddPatient: _addPatient))
                    );
                    // showModalBottomSheet(
                    //   useSafeArea: true,
                    //   backgroundColor: const Color.fromARGB(255, 249, 249, 243),
                    //   shape: const BeveledRectangleBorder(
                    //   borderRadius: BorderRadius.all(Radius.zero)),
                    //   isScrollControlled: true,
                    //   context: context,
                    //   builder: (ctx) => AddPatientScreen(
                    //     onAddPatient: _addPatient,
                    //   ),
                    // );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text(
                    "Add Other Patient",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  "Patients",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Expanded(
                child: patients.isEmpty ? const Text("No patients") : Scrollbar(
                  thickness: 7,
                  child: ListView.builder(
                    itemCount: patients.length,
                    itemBuilder: (ctx, idx) {
                      return Dismissible(
                        key: Key(patients[idx]),
                        child: CustomListTile(
                          title: patients[idx],
                          onPressed: () {
                            setState(() {
                              patients.remove(patients[idx]);
                            });
                          },
                          whoCalled: Screen.victimsScreen,
                        ),
                        onDismissed: (direction) {
                          setState(() {
                            patients.remove(patients[idx]);
                          });
                        },
                      );
                    },
                  ),
                ),
              ),
              //TODO MOZDA NEKO POLJE ZA NEKU NAPOMENU ko boluje od cega
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 35, 12, 12),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                    minimumSize: const Size(180, 70),
                    backgroundColor: const Color.fromARGB(255, 44, 47, 255),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    if (patients.isEmpty) {
                      showSnackBar(context, "Add patients first");
                    }
                  },
                  icon: const Icon(Icons.send),
                  label: const Text(
                    "Send Request",
                  ),
                ),
              )
            ])
          : Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.fromLTRB(30,10,30,10),
                            minimumSize: const Size(160, 75),
                            backgroundColor:
                                const Color.fromARGB(255, 255, 99, 88),
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              patients.add("me");
                              //TODO umesto me staviti username
                            });
                            showModalBottomSheet(
                              context: context,
                              builder: (ctx) =>
                                  const Text("Write your address"),
                            );
                          },
                          child: const Text(
                            "I Need Ambulance",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(20),
                            minimumSize: const Size(160, 75),
                            backgroundColor:
                                const Color.fromARGB(255, 255, 99, 88),
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              backgroundColor:
                                  const Color.fromARGB(255, 249, 249, 243),
                              shape: const BeveledRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.zero)),
                              isScrollControlled: true,
                              context: context,
                              builder: (ctx) => AddPatientScreen(
                                onAddPatient: _addPatient,
                              ),
                            );
                          },
                          icon: const Icon(Icons.add),
                          label: const Text(
                            "Add Other Patient",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 12),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.fromLTRB(35, 20, 35, 20),
                            minimumSize: const Size(180, 75),
                            backgroundColor:
                                const Color.fromARGB(255, 44, 47, 255),
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            if (patients.isEmpty) {
                              showSnackBar(context, "Add patients first");
                            }
                          },
                          icon: const Icon(Icons.send),
                          label: const Text(
                            "Send Ambulance",
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          "Patients",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      
                      Expanded(
                        child: Scrollbar(
                          thickness: 7,
                          child: ListView.builder(
                            itemCount: patients.length,
                            itemBuilder: (ctx, idx) {
                              return Dismissible(
                                key: Key(patients[idx]),
                                child: CustomListTile(
                                  title: patients[idx],
                                  onPressed: () {
                                    setState(() {
                                      patients.remove(patients[idx]);
                                    });
                                  },
                                  whoCalled: Screen.victimsScreen,
                                ),
                                onDismissed: (direction) {
                                  setState(() {
                                    patients.remove(patients[idx]);
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}