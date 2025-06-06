class DragModel {
  DragModel({required this.id, required this.title});

  final String id;
  final String title;

  int mount = 0;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! DragModel) return false;
    return id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
