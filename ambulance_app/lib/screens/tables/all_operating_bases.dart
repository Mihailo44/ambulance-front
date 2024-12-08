import 'package:ambulance_app/generic_widgets/custom_list_tile.dart';
import 'package:ambulance_app/main.dart';
import 'package:ambulance_app/mock_data/operating_bases_mock.dart';
import 'package:ambulance_app/model/operating_base.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:searchable_listview/searchable_listview.dart';

class AllOperatingBases extends StatefulWidget {
  @override
  _AllOperatingBasesState createState() => _AllOperatingBasesState();
}

class _AllOperatingBasesState extends State<AllOperatingBases> {
  List<OperatingBase> bases = [];
  final mockService = MockOperatingBaseService();

  @override
  void initState() {
    super.initState();
    mockService.fillList(bases);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FractionallySizedBox(
          widthFactor: 0.8,
          child: SearchableList<OperatingBase>(
            initialList: bases,
            itemBuilder: (OperatingBase operatingBase) => RowItem(
              operatingBase: operatingBase,
              onAddPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Confirmation"),
                      content: const Text("Are you sure you want to proceed?"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pop(); // Close the dialog on Confirm
                            context.pop(operatingBase);
                          },
                          child: const Text("Confirm"),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            errorWidget: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error,
                  color: Colors.red,
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Error while fetching bases')
              ],
            ),
            filter: (value) => bases
                .where(
                  (element) =>
                      element.address.street.toLowerCase().contains(value),
                )
                .toList(),
            inputDecoration: InputDecoration(
              labelText: "Search Bases",
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.blue,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RowItem extends StatelessWidget {
  final OperatingBase operatingBase;
  final VoidCallback onAddPressed;

  const RowItem({required this.operatingBase, required this.onAddPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: CustomListTile<OperatingBase>(
              item: operatingBase,
              title: operatingBase.address.street,
              subtitle: operatingBase.address.number,
              iconData: Icons.add,
              onPressed: onAddPressed,
              mode: Mode.create,
            ),
          ),
        ],
      ),
    );
  }
}
