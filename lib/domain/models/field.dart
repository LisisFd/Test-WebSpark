/// Stores a [row] matrix in bool
class Field {
  List<bool> row = [];

  Field(String fields) {
    fields.split('').forEach((char) {
      row.add(char == '.');
    });
  }
}
