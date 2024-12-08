import 'package:ambulance_app/generic_widgets/custom_list_tile.dart';
import 'package:ambulance_app/main.dart';
import 'package:ambulance_app/model/users/unregistered_user.dart';
import 'package:ambulance_app/providers/ambulance_request_provider.dart';
import 'package:ambulance_app/screens/questions/add_patient_screen.dart';
import 'package:ambulance_app/screens/questions/location_dialog_screen.dart';
import 'package:ambulance_app/util/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VictimList extends ConsumerStatefulWidget {
  const VictimList({super.key});

  @override
  ConsumerState<VictimList> createState() => _VictimListState();
}

class _VictimListState extends ConsumerState<VictimList> {
  final List<String> _patients = [];
  final List<UnregisteredUser> unregistered = [];

  void _chooseLocation(){
    ref.read(ambulanceRequestProvider.notifier).setRegisteredPatientsIDs(_patients);
    ref.read(ambulanceRequestProvider.notifier).setUnregisteredPatients(unregistered);
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const LocationDialogScreen()));
  }

  @override
  void initState() {
    super.initState();
  }

  void _addPatient(String patient) {
    if (patient.isNotEmpty) {
      setState(() {
        _patients.add(patient);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 253, 253, 247),
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
      body: width < 550
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 5,
                      width: width,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(20),
                          minimumSize: const Size(160, 75),
                          backgroundColor:
                              const Color.fromARGB(255, 255, 99, 88),
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            //TODO umesto me staviti username
                            if (!_patients.contains("me")) {
                              _patients.add("me");
                            }
                          });
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
                          backgroundColor:
                              const Color.fromARGB(255, 255, 99, 88),
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) =>
                                  AddPatientScreen(onAddPatient: _addPatient)));
                        },
                        icon: const Icon(Icons.add),
                        label: const Text(
                          "Add Other Patient",
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Text(
                        "Patients",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: _patients.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.fromLTRB(2, 50, 2, 0),
                              child: Text("No patients"))
                          : Scrollbar(
                              thickness: 7,
                              child: ListView.builder(
                                itemCount: _patients.length,
                                itemBuilder: (ctx, idx) {
                                  return Dismissible(
                                    key: Key(_patients[idx]),
                                    child: CustomListTile(
                                      title: _patients[idx],
                                      onPressed: () {
                                        setState(() {
                                          _patients.remove(_patients[idx]);
                                        });
                                      },
                                      mode: Mode.delete,
                                    ),
                                    onDismissed: (direction) {
                                      setState(() {
                                        _patients.remove(_patients[idx]);
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(20),
                        minimumSize: const Size(180, 70),
                        backgroundColor:
                            const Color.fromARGB(255, 7, 154, 180),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        if (_patients.isEmpty) {
                          showSnackBar(context, "Add patients first");
                        }else{
                          _chooseLocation();
                        }
                        
                      },
                      icon: const Icon(Icons.location_on_sharp),
                      label: const Text(
                        "Add Location",
                      ),
                    ),
                    const SizedBox(height: 40,),
                  ]),
            )
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
                            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                            minimumSize: const Size(160, 75),
                            backgroundColor:
                                const Color.fromARGB(255, 255, 99, 88),
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _patients.add("me");
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
                            if (_patients.isEmpty) {
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
                            itemCount: _patients.length,
                            itemBuilder: (ctx, idx) {
                              return Dismissible(
                                key: Key(_patients[idx]),
                                child: CustomListTile(
                                  title: _patients[idx],
                                  onPressed: () {
                                    setState(() {
                                      _patients.remove(_patients[idx]);
                                    });
                                  },
                                  mode: Mode.delete,
                                ),
                                onDismissed: (direction) {
                                  setState(() {
                                    _patients.remove(_patients[idx]);
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
