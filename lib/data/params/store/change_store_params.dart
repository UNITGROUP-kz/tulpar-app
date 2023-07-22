class ChangeStoreParams {
  final String name;
  final String? description;

  ChangeStoreParams({
    required this.name,
    this.description,
  });

  toData() {
    final data = {
      'name': name,
    };

    if(description != null) {
      data.addAll({'description': description ?? ''});
    }

    return data;
  }

}