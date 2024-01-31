class ProductData {
  ProductData({
    required this.orderType,
    required this.orderCount,
  });
  final String orderType;
  final int orderCount;

}

class PersonDetail {
  PersonDetail({
    required this.name,
    required this.address,
    required this.number,
    required this.data,
  });

  final String name;
  final String address;
  final String number;
  final ProductData data;
}

  List<PersonDetail> dummyPersonList = [
    PersonDetail(
      name: 'Vijay Kumar',
      address: '2947 Western Road, Santa Area 184697',
      number: '+91 933333333333',
      data: ProductData(orderType: 'Failed', orderCount: 1),
    ),
    PersonDetail(
      name: 'Vijay Kumar',
      address: '2947 Western Road, Santa Area 184697',
      number: '+91 9333333333336',
      data: ProductData(orderType: 'Delivery', orderCount: 10),
    ),
    PersonDetail(
      name: 'Vijay Kumar',
      address: '456 Oak Brazil',
      number: '+91 9333333333336',
      data: ProductData(orderType: 'Replacement', orderCount: 2),
    ),
    PersonDetail(
      name: 'John Doe',
      address: '123 Main St',
      number: '+91 933333333333',
      data: ProductData(orderType: 'Failed', orderCount: 1),
    ),
    PersonDetail(
      name: 'Jane Smith',
      address: '456 Oak Ave',
      number: '+91 9333333333336',
      data: ProductData(orderType: 'Delivery', orderCount: 10),
    ),
    PersonDetail(
      name: 'Rahul Sen',
      address: '456 Oak Brazil',
      number: '+91 9333333333336',
      data: ProductData(orderType: 'Replacement', orderCount: 2),
    ),
    PersonDetail(
      name: 'John Doe',
      address: '123 Main St',
      number: '+91 933333333333',
      data: ProductData(orderType: 'Failed', orderCount: 1),
    ),
    PersonDetail(
      name: 'Jane Smith',
      address: '456 Oak Ave',
      number: '+91 9333333333336',
      data: ProductData(orderType: 'Delivery', orderCount: 10),
    ),
    PersonDetail(
      name: 'Rahul Sen',
      address: '456 Oak Brazil',
      number: '+91 9333333333336',
      data: ProductData(orderType: 'Replacement', orderCount: 2),
    ),
  ];


