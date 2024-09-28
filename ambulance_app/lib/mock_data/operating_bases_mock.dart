import 'package:ambulance_app/model/address.dart';
import 'package:ambulance_app/model/operating_base.dart';

class MockOperatingBaseService{
  void fillList(List<OperatingBase> list){
    list.addAll([
  OperatingBase(
    id: 1,
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
    id: 2,
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
    id: 3,
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
    id: 4,
    addressId: 104,
    address: Address(
      id: 204,
      country: 'Germany',
      city: 'Berlin',
      street: 'Unter den Linden',
      number: '10',
    ),
  ),
  OperatingBase(
    id: 5,
    addressId: 105,
    address: Address(
      id: 205,
      country: 'France',
      city: 'Paris',
      street: 'Champs-Élysées',
      number: '8',
    ),
  ),
  OperatingBase(
    id: 6,
    addressId: 106,
    address: Address(
      id: 206,
      country: 'Italy',
      city: 'Rome',
      street: 'Via del Corso',
      number: '306',
    ),
  ),
  OperatingBase(
    id: 7,
    addressId: 107,
    address: Address(
      id: 207,
      country: 'Spain',
      city: 'Madrid',
      street: 'Gran Via',
      number: '15',
    ),
  ),
  OperatingBase(
    id: 8,
    addressId: 108,
    address: Address(
      id: 208,
      country: 'Australia',
      city: 'Sydney',
      street: 'George Street',
      number: '22',
    ),
  ),
  OperatingBase(
    id: 9,
    addressId: 109,
    address: Address(
      id: 209,
      country: 'Japan',
      city: 'Tokyo',
      street: 'Shibuya Street',
      number: '55',
    ),
  ),
  OperatingBase(
    id: 10,
    addressId: 110,
    address: Address(
      id: 210,
      country: 'Brazil',
      city: 'Rio de Janeiro',
      street: 'Avenida Atlantica',
      number: '456',
    ),
  ),
]);

  }
  }