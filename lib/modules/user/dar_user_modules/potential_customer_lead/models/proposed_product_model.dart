class ResponceProposedProduct {
  int? id;
  String? productName;

  ResponceProposedProduct({this.id, this.productName});

  ResponceProposedProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['productName'];
  }
}
