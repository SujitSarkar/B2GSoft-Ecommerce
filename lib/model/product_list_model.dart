import 'dart:convert';

ProductListModel productListModelFromJson(String str) => ProductListModel.fromJson(json.decode(str));

class ProductListModel {
  ProductListModel({
    this.data,
    this.success,
  });

  final Data? data;
  final bool? success;

  factory ProductListModel.fromJson(Map<String?, dynamic> json) => ProductListModel(
    data: Data.fromJson(json["data"]),
    success: json["success"],
  );
}

class Data {
  Data({
    this.info,
    this.category,
    this.shop,
    this.brand,
    this.productSection,
  });

  final Info? info;
  final List<Category>? category;
  final Brand? shop;
  final Brand? brand;
  final List<ProductSection>? productSection;

  factory Data.fromJson(Map<String?, dynamic> json) => Data(
    info: Info.fromJson(json["info"]),
    category: List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
    shop: Brand.fromJson(json["shop"]),
    brand: Brand.fromJson(json["brand"]),
    productSection: List<ProductSection>.from(json["productSection"].map((x) => ProductSection.fromJson(x))),
  );
}

class Brand {
  Brand({
    this.title,
    this.items,
  });

  final String? title;
  final List<Category>? items;

  factory Brand.fromJson(Map<String?, dynamic> json) => Brand(
    title: json["title"],
    items: List<Category>.from(json["items"].map((x) => Category.fromJson(x))),
  );
}

class Category {
  Category({
    this.active,
    this.id,
    this.name,
    this.image,
    this.slug,
  });

  final bool? active;
  final String? id;
  final String? name;
  final String? image;
  final String? slug;

  factory Category.fromJson(Map<String?, dynamic> json) => Category(
    active: json["active"],
    id: json["_id"],
    name: json["name"],
    image: json["image"],
    slug: json["slug"],
  );

}

class Info {
  Info({
    this.firstBanner,
    this.secondBanner,
    this.thirdBanner,
    this.badge,
    this.deliveryChargeInsideDhaka,
    this.deliveryChargeOutsideDhaka,
    this.appVersionCode,
    this.appVersionName,
    this.androidUpdateMandatory,
    this.iosUpdateMandatory,
    this.appStoreUrl,
    this.playStoreUrl,
    this.id,
    this.name,
    this.email,
    this.phone,
    this.aboutUs,
    this.address,
    this.facebook,
    this.instagram,
    this.logo,
    this.invoiceLogo,
    this.sliders,
    this.footerLogo,
    this.topLogo,
    this.termsPrivacyAbout,
    this.firstOrderDiscount,
  });

  final String? firstBanner;
  final String? secondBanner;
  final String? thirdBanner;
  final bool? badge;
  final int? deliveryChargeInsideDhaka;
  final int? deliveryChargeOutsideDhaka;
  final String? appVersionCode;
  final String? appVersionName;
  final bool? androidUpdateMandatory;
  final bool? iosUpdateMandatory;
  final String? appStoreUrl;
  final String? playStoreUrl;
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? aboutUs;
  final String? address;
  final String? facebook;
  final String? instagram;
  final String? logo;
  final String? invoiceLogo;
  final List<Category>? sliders;
  final String? footerLogo;
  final String? topLogo;
  final TermsPrivacyAbout? termsPrivacyAbout;
  final int? firstOrderDiscount;

  factory Info.fromJson(Map<String?, dynamic> json) => Info(
    firstBanner: json["firstBanner"],
    secondBanner: json["secondBanner"],
    thirdBanner: json["thirdBanner"],
    badge: json["badge"],
    deliveryChargeInsideDhaka: json["deliveryChargeInsideDhaka"],
    deliveryChargeOutsideDhaka: json["deliveryChargeOutsideDhaka"],
    appVersionCode: json["appVersionCode"],
    appVersionName: json["appVersionName"],
    androidUpdateMandatory: json["androidUpdateMandatory"],
    iosUpdateMandatory: json["iosUpdateMandatory"],
    appStoreUrl: json["appStoreUrl"],
    playStoreUrl: json["playStoreUrl"],
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    aboutUs: json["aboutUs"],
    address: json["address"],
    facebook: json["facebook"],
    instagram: json["instagram"],
    logo: json["logo"],
    invoiceLogo: json["invoiceLogo"],
    sliders: List<Category>.from(json["sliders"].map((x) => Category.fromJson(x))),
    footerLogo: json["footerLogo"],
    topLogo: json["topLogo"],
    termsPrivacyAbout: TermsPrivacyAbout.fromJson(json["termsPrivacyAbout"]),
    firstOrderDiscount: json["firstOrderDiscount"],
  );
}

class TermsPrivacyAbout {
  TermsPrivacyAbout({
    this.termsAndCondition,
    this.privacyPolicy,
    this.aboutUs,
  });

  final String? termsAndCondition;
  final String? privacyPolicy;
  final String? aboutUs;

  factory TermsPrivacyAbout.fromJson(Map<String?, dynamic> json) => TermsPrivacyAbout(
    termsAndCondition: json["termsAndCondition"],
    privacyPolicy: json["privacyPolicy"],
    aboutUs: json["aboutUs"],
  );
}

class ProductSection {
  ProductSection({
    this.title,
    this.items,
    this.slug,
  });

  final String? title;
  final List<Item>? items;
  final String? slug;

  factory ProductSection.fromJson(Map<String?, dynamic> json) => ProductSection(
    title: json["title"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    slug: json["slug"],
  );
}

class Item {
  Item({
    this.brand,
    this.price,
    this.buyingPrice,
    this.currentStock,
    this.id,
    this.name,
    this.variations,
    this.description,
    this.thumbnail,
    this.slug,
    this.sku,
  });

  final Category? brand;
  final int? price;
  final int? buyingPrice;
  final int? currentStock;
  final String? id;
  final String? name;
  final List<Variation>? variations;
  final String? description;
  final String? thumbnail;
  final String? slug;
  final String? sku;

  factory Item.fromJson(Map<String?, dynamic> json) => Item(
    brand: Category.fromJson(json["brand"]),
    price: json["price"],
    buyingPrice: json["buyingPrice"],
    currentStock: json["currentStock"],
    id: json["_id"],
    name: json["name"],
    variations: List<Variation>.from(json["variations"].map((x) => Variation.fromJson(x))),
    description: json["description"],
    thumbnail: json["thumbnail"],
    slug: json["slug"],
    sku: json["sku"],
  );
}

class Variation {
  Variation({
    this.value1,
    this.value2,
    this.discountType,
    this.discountAmount,
    this.image,
    this.regularPrice,
    this.buyingPrice,
    this.maxPrice,
    this.minPrice,
    this.stock,
    this.id,
  });

  final String? value1;
  final String? value2;
  final int? discountType;
  final int? discountAmount;
  final List<String>? image;
  final int? regularPrice;
  final int? buyingPrice;
  final int? maxPrice;
  final int? minPrice;
  final int? stock;
  final String? id;

  factory Variation.fromJson(Map<String?, dynamic> json) => Variation(
    value1: json["value1"],
    value2: json["value2"],
    discountType: json["discountType"],
    discountAmount: json["discountAmount"],
    image: List<String>.from(json["image"].map((x) => x)),
    regularPrice: json["regularPrice"],
    buyingPrice: json["buyingPrice"],
    maxPrice: json["maxPrice"],
    minPrice: json["minPrice"],
    stock: json["stock"],
    id: json["_id"],
  );
}
