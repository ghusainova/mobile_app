class CreditBrandResponse {
  List<String> content;
  CreditBrandResponse({
    this.content = const [],
  });

  factory CreditBrandResponse.fromJson(Map<dynamic, dynamic> json) {
    return CreditBrandResponse(
      content: List<String>.from(json['content'] ?? []),
    );
  }
}
