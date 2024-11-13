import 'package:ambulance_app/model/address.dart';
import 'package:ambulance_app/model/operating_base.dart';

class MockOperatingBaseService{
  void fillList(List<OperatingBase> list){
    list.addAll([
  OperatingBase(
    id: "6ed9a5be-794a-49e6-86b7-8af8a18a35b0",
    addressId: 101,
    address: Address(
      id: 201,
      country: 'USA',
      city: 'New York',
      street: '5th Avenue',
      number: '101',
    ),
  ),
  OperatingBase(
    id: "2",
    addressId: 102,
    address: Address(
      id: 202,
      country: 'Canada',
      city: 'Toronto',
      street: 'Bay Street',
      number: '202',
    ),
  ),
  OperatingBase(
    id: "3",
    addressId: 103,
    address: Address(
      id: 203,
      country: 'UK',
      city: 'London',
      street: 'Baker Street',
      number: '221B',
    ),
  ),
  OperatingBase(
    id: "4",
    addressId: 104,
    address: Address(
      id: 204,
      country: 'Germany',
      city: 'Berlin',
      street: 'Unter den Linden',
      number: '10',
    ),
  ),
]);

  }
  }