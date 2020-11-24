import 'package:graphql_flutter/graphql_flutter.dart';

mixin TabMixin {
  int getItemCount(QueryResult result, String type) {
    if (type == "Character")
      return result.data['characters']['results'].length;
    else if (type == "Location")
      return result.data['locations']['results'].length;
    else
      return result.data['episodes']['results'].length;
  }

  bool contains(List<Map<String, dynamic>> ids, String id) {
    for (var element in ids) {
      if (element['id'] == id) return true;
    }
    return false;
  }

  List<Map<String, dynamic>> remove(String id, List localId) {
    List<Map<String, dynamic>> newList = [];
    for (Map<String, dynamic> element in localId) {
      if (element['id'] == id) {
        continue;
      }
      newList.add(element);
    }
    return newList;
  }

  List<Map<String, dynamic>> add(String id, List localId) {
    List<Map<String, dynamic>> newList = [];
    localId.forEach((element) {
      newList.add(element);
    });
    newList.add({'id': id});
    return newList;
  }
}
