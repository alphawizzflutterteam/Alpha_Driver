// To parse this JSON data, do
//
//     final orderDetailModelNew = orderDetailModelNewFromJson(jsonString);

import 'dart:convert';

OrderDetailModelNew orderDetailModelNewFromJson(String str) =>
    OrderDetailModelNew.fromJson(json.decode(str));

String orderDetailModelNewToJson(OrderDetailModelNew data) =>
    json.encode(data.toJson());

class OrderDetailModelNew {
  bool status;
  String message;
  Data data;

  OrderDetailModelNew({
    required this.status,
    required this.message,
    required this.data,
  });

  factory OrderDetailModelNew.fromJson(Map<String, dynamic> json) =>
      OrderDetailModelNew(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  int orderId;
  String customerName;
  String customerMobile;
  String orderStatus;
  ShippingAddress shippingAddress;
  List<Detail> detail;
  List<dynamic> orderHistory;
  PriceDetail2 priceDetail;

  Data({
    required this.orderId,
    required this.customerName,
    required this.customerMobile,
    required this.orderStatus,
    required this.shippingAddress,
    required this.detail,
    required this.orderHistory,
    required this.priceDetail,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        orderId: json["order_id"],
        customerName: json["customer_name"],
        customerMobile: json["customer_mobile"],
        orderStatus: json["order_status"],
        shippingAddress: ShippingAddress.fromJson(json["shipping_address"]),
        detail:
            List<Detail>.from(json["detail"].map((x) => Detail.fromJson(x))),
        orderHistory: List<dynamic>.from(json["order_history"].map((x) => x)),
        priceDetail: PriceDetail2.fromJson(json["price_detail"]),
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "customer_name": customerName,
        "customer_mobile": customerMobile,
        "order_status": orderStatus,
        "shipping_address": shippingAddress.toJson(),
        "detail": List<dynamic>.from(detail.map((x) => x.toJson())),
        "order_history": List<dynamic>.from(orderHistory.map((x) => x)),
        "price_detail": priceDetail.toJson(),
      };
}

class Detail {
  int id;
  List<CategoryId> categoryIds;
  int userId;
  Shop shop;
  String name;
  String slug;
  List<String> images;
  List<ColorImage> colorImage;
  String thumbnail;
  int brandId;
  String unit;
  int minQty;
  int featured;
  String refundable;
  int variantProduct;
  List<dynamic> attributes;
  List<dynamic> choiceOptions;
  List<Variation> variation;
  String weight;
  int published;
  String unitPrice;
  String specialPrice;
  String purchasePrice;
  int tax;
  String taxType;
  String taxModel;
  String taxAmount;
  int discount;
  String discountType;
  int currentStock;
  int minimumOrderQty;
  int freeShipping;
  String createdAt;
  String updatedAt;
  int status;
  int featuredStatus;
  String metaTitle;
  String metaDescription;
  String metaImage;
  int requestStatus;
  String shippingCost;
  int multiplyQty;
  String code;
  int reviewsCount;
  List<dynamic> rating;
  List<dynamic> tags;
  List<dynamic> translations;
  String shareLink;
  List<dynamic> reviews;
  List<ColorsFormatted> colorsFormatted;
  bool isFavorite;
  bool isCart;
  int cartId;
  String manufacturingDate;
  String madeIn;
  String warranty;
  String useCoinsWithAmount;
  String amountAfterCoinUse;
  int itemId;

  Detail({
    required this.id,
    required this.categoryIds,
    required this.userId,
    required this.shop,
    required this.name,
    required this.slug,
    required this.images,
    required this.colorImage,
    required this.thumbnail,
    required this.brandId,
    required this.unit,
    required this.minQty,
    required this.featured,
    required this.refundable,
    required this.variantProduct,
    required this.attributes,
    required this.choiceOptions,
    required this.variation,
    required this.weight,
    required this.published,
    required this.unitPrice,
    required this.specialPrice,
    required this.purchasePrice,
    required this.tax,
    required this.taxType,
    required this.taxModel,
    required this.taxAmount,
    required this.discount,
    required this.discountType,
    required this.currentStock,
    required this.minimumOrderQty,
    required this.freeShipping,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.featuredStatus,
    required this.metaTitle,
    required this.metaDescription,
    required this.metaImage,
    required this.requestStatus,
    required this.shippingCost,
    required this.multiplyQty,
    required this.code,
    required this.reviewsCount,
    required this.rating,
    required this.tags,
    required this.translations,
    required this.shareLink,
    required this.reviews,
    required this.colorsFormatted,
    required this.isFavorite,
    required this.isCart,
    required this.cartId,
    required this.manufacturingDate,
    required this.madeIn,
    required this.warranty,
    required this.useCoinsWithAmount,
    required this.amountAfterCoinUse,
    required this.itemId,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        categoryIds: List<CategoryId>.from(
            json["category_ids"].map((x) => CategoryId.fromJson(x))),
        userId: json["user_id"],
        shop: Shop.fromJson(json["shop"]),
        name: json["name"],
        slug: json["slug"],
        images: List<String>.from(json["images"].map((x) => x)),
        colorImage: List<ColorImage>.from(
            json["color_image"].map((x) => ColorImage.fromJson(x))),
        thumbnail: json["thumbnail"],
        brandId: json["brand_id"],
        unit: json["unit"],
        minQty: json["min_qty"],
        featured: json["featured"],
        refundable: json["refundable"],
        variantProduct: json["variant_product"],
        attributes: List<dynamic>.from(json["attributes"].map((x) => x)),
        choiceOptions: List<dynamic>.from(json["choice_options"].map((x) => x)),
        variation: List<Variation>.from(
            json["variation"].map((x) => Variation.fromJson(x))),
        weight: json["weight"],
        published: json["published"],
        unitPrice: json["unit_price"]!,
        specialPrice: json["special_price"],
        purchasePrice: json["purchase_price"],
        tax: json["tax"],
        taxType: json["tax_type"],
        taxModel: json["tax_model"],
        taxAmount: json["tax_amount"],
        discount: json["discount"],
        discountType: json["discount_type"],
        currentStock: json["current_stock"],
        minimumOrderQty: json["minimum_order_qty"],
        freeShipping: json["free_shipping"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        status: json["status"],
        featuredStatus: json["featured_status"],
        metaTitle: json["meta_title"],
        metaDescription: json["meta_description"],
        metaImage: json["meta_image"],
        requestStatus: json["request_status"],
        shippingCost: json["shipping_cost"],
        multiplyQty: json["multiply_qty"],
        code: json["code"],
        reviewsCount: json["reviews_count"],
        rating: List<dynamic>.from(json["rating"].map((x) => x)),
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
        translations: List<dynamic>.from(json["translations"].map((x) => x)),
        shareLink: json["share_link"],
        reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
        colorsFormatted: List<ColorsFormatted>.from(
            json["colors_formatted"].map((x) => ColorsFormatted.fromJson(x))),
        isFavorite: json["is_favorite"],
        isCart: json["is_cart"],
        cartId: json["cart_id"],
        manufacturingDate: json["manufacturing_date"],
        madeIn: json["made_in"],
        warranty: json["warranty"],
        useCoinsWithAmount: json["use_coins_with_amount"],
        amountAfterCoinUse: json["amount_after_coin_use"],
        itemId: json["item_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_ids": List<dynamic>.from(categoryIds.map((x) => x.toJson())),
        "user_id": userId,
        "shop": shop.toJson(),
        "name": name,
        "slug": slug,
        "images": List<dynamic>.from(images.map((x) => x)),
        "color_image": List<dynamic>.from(colorImage.map((x) => x.toJson())),
        "thumbnail": thumbnail,
        "brand_id": brandId,
        "unit": unit,
        "min_qty": minQty,
        "featured": featured,
        "refundable": refundable,
        "variant_product": variantProduct,
        "attributes": List<dynamic>.from(attributes.map((x) => x)),
        "choice_options": List<dynamic>.from(choiceOptions.map((x) => x)),
        "variation": List<dynamic>.from(variation.map((x) => x.toJson())),
        "weight": weight,
        "published": published,
        "unit_price": unitPrice,
        "special_price": specialPrice,
        "purchase_price": purchasePrice,
        "tax": tax,
        "tax_type": taxType,
        "tax_model": taxModel,
        "tax_amount": taxAmount,
        "discount": discount,
        "discount_type": discountType,
        "current_stock": currentStock,
        "minimum_order_qty": minimumOrderQty,
        "free_shipping": freeShipping,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "status": status,
        "featured_status": featuredStatus,
        "meta_title": metaTitle,
        "meta_description": metaDescription,
        "meta_image": metaImage,
        "request_status": requestStatus,
        "shipping_cost": shippingCost,
        "multiply_qty": multiplyQty,
        "code": code,
        "reviews_count": reviewsCount,
        "rating": List<dynamic>.from(rating.map((x) => x)),
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "translations": List<dynamic>.from(translations.map((x) => x)),
        "share_link": shareLink,
        "reviews": List<dynamic>.from(reviews.map((x) => x)),
        "colors_formatted":
            List<dynamic>.from(colorsFormatted.map((x) => x.toJson())),
        "is_favorite": isFavorite,
        "is_cart": isCart,
        "cart_id": cartId,
        "manufacturing_date": manufacturingDate,
        "made_in": madeIn,
        "warranty": warranty,
        "use_coins_with_amount": useCoinsWithAmount,
        "amount_after_coin_use": amountAfterCoinUse,
        "item_id": itemId,
      };
}

class CategoryId {
  String id;
  int position;

  CategoryId({
    required this.id,
    required this.position,
  });

  factory CategoryId.fromJson(Map<String, dynamic> json) => CategoryId(
        id: json["id"],
        position: json["position"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "position": position,
      };
}

class ColorImage {
  String color;
  String imageName;

  ColorImage({
    required this.color,
    required this.imageName,
  });

  factory ColorImage.fromJson(Map<String, dynamic> json) => ColorImage(
        color: json["color"],
        imageName: json["image_name"],
      );

  Map<String, dynamic> toJson() => {
        "color": color,
        "image_name": imageName,
      };
}

class ColorsFormatted {
  String name;
  String code;

  ColorsFormatted({
    required this.name,
    required this.code,
  });

  factory ColorsFormatted.fromJson(Map<String, dynamic> json) =>
      ColorsFormatted(
        name: json["name"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
      };
}

class Shop {
  String id;
  String sellerId;
  String name;
  String address;
  String contact;
  String image;
  String bottomBanner;
  String vacationStartDate;
  String vacationEndDate;
  String vacationNote;
  int vacationStatus;
  int temporaryClose;
  String createdAt;
  String updatedAt;
  String rating;
  String followers;
  String isVerified;
  String isFollowing;
  String banner;

  Shop({
    required this.id,
    required this.sellerId,
    required this.name,
    required this.address,
    required this.contact,
    required this.image,
    required this.bottomBanner,
    required this.vacationStartDate,
    required this.vacationEndDate,
    required this.vacationNote,
    required this.vacationStatus,
    required this.temporaryClose,
    required this.createdAt,
    required this.updatedAt,
    required this.rating,
    required this.followers,
    required this.isVerified,
    required this.isFollowing,
    required this.banner,
  });

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        id: json["id"],
        sellerId: json["seller_id"],
        name: json["name"],
        address: json["address"],
        contact: json["contact"],
        image: json["image"],
        bottomBanner: json["bottom_banner"],
        vacationStartDate: json["vacation_start_date"],
        vacationEndDate: json["vacation_end_date"],
        vacationNote: json["vacation_note"],
        vacationStatus: json["vacation_status"],
        temporaryClose: json["temporary_close"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        rating: json["rating"],
        followers: json["followers"],
        isVerified: json["is_verified"],
        isFollowing: json["is_following"],
        banner: json["banner"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "seller_id": sellerId,
        "name": name,
        "address": address,
        "contact": contact,
        "image": image,
        "bottom_banner": bottomBanner,
        "vacation_start_date": vacationStartDate,
        "vacation_end_date": vacationEndDate,
        "vacation_note": vacationNote,
        "vacation_status": vacationStatus,
        "temporary_close": temporaryClose,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "rating": rating,
        "followers": followers,
        "is_verified": isVerified,
        "is_following": isFollowing,
        "banner": banner,
      };
}

class Variation {
  String type;
  String price;
  String sku;
  int qty;

  Variation({
    required this.type,
    required this.price,
    required this.sku,
    required this.qty,
  });

  factory Variation.fromJson(Map<String, dynamic> json) => Variation(
        type: json["type"],
        price: json["price"]!,
        sku: json["sku"],
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "price": price,
        "sku": sku,
        "qty": qty,
      };
}

class PriceDetail2 {
  String subtotal;
  String itemPrice;
  String discount;
  String deliveryFee;
  String tax;
  String total;

  PriceDetail2({
    required this.subtotal,
    required this.itemPrice,
    required this.discount,
    required this.deliveryFee,
    required this.tax,
    required this.total,
  });

  factory PriceDetail2.fromJson(Map<String, dynamic> json) => PriceDetail2(
        subtotal: json["subtotal"]!,
        itemPrice: json["item_price"],
        discount: json["discount"],
        deliveryFee: json["delivery_fee"],
        tax: json["tax"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "subtotal": subtotal,
        "item_price": itemPrice,
        "discount": discount,
        "delivery_fee": deliveryFee,
        "tax": tax,
        "total": total,
      };
}

class ShippingAddress {
  String id;
  String customerId;
  String contactPersonName;
  String addressType;
  String address;
  String address1;
  String city;
  String zip;
  String phone;
  String altPhone;
  String createdAt;
  String updatedAt;
  String state;
  String country;
  String latitude;
  String longitude;
  String isBilling;

  ShippingAddress({
    required this.id,
    required this.customerId,
    required this.contactPersonName,
    required this.addressType,
    required this.address,
    required this.address1,
    required this.city,
    required this.zip,
    required this.phone,
    required this.altPhone,
    required this.createdAt,
    required this.updatedAt,
    required this.state,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.isBilling,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        id: json["id"],
        customerId: json["customer_id"],
        contactPersonName: json["contact_person_name"],
        addressType: json["address_type"],
        address: json["address"],
        address1: json["address1"],
        city: json["city"],
        zip: json["zip"],
        phone: json["phone"],
        altPhone: json["alt_phone"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        state: json["state"],
        country: json["country"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        isBilling: json["is_billing"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "contact_person_name": contactPersonName,
        "address_type": addressType,
        "address": address,
        "address1": address1,
        "city": city,
        "zip": zip,
        "phone": phone,
        "alt_phone": altPhone,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "state": state,
        "country": country,
        "latitude": latitude,
        "longitude": longitude,
        "is_billing": isBilling,
      };
}
