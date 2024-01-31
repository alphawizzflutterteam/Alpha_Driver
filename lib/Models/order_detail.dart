class PriceDetail {
  final String subTotal;
  final String itemPrice;
  final String discount;
  final String deliveryFee;
  final String tax;
  final String total;

  PriceDetail(this.subTotal, this.itemPrice, this.discount, this.deliveryFee,
      this.tax, this.total);
}

class ProductDetail {
  final int id;
  final String name;
  final String price;

  ProductDetail(this.id, this.name, this.price);
}
