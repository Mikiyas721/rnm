mixin FormatterMixin{
  String getDate(String dateTime){
    return dateTime.split('T')[0];
  }
}