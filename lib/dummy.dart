import "dart:convert" as convert;

String searchDummyList(
  String id,
  String column,
  List<Map<String, dynamic>> list,
) {
  var item = <String, dynamic>{};
  for (var m in list) {
    if (m[column] == id) item = m;
  }
  return convert.json.encode(item);
}

String fetchDummyList(
  List<String> idList,
  String column,
  List<Map<String, dynamic>> list,
) {
  var itemList = [];
  for (var id in idList) {
    for (var m in list) {
      if (m[column] == id) itemList.add(m);
    }
  }
  var map = {"data": itemList};
  return convert.json.encode(map);
}

List<Map<String, dynamic>> dummyUserList = [
  {
    "id": "1",
    "name": "教師テスト",
    "role": "教師",
    "roomIdList": ["1", "3", "4"]
  },
  {
    "id": "2",
    "name": "生徒テスト",
    "role": "生徒",
    "roomIdList": ["2", "4"]
  },
];

List<Map<String, dynamic>> dummyRoomList = [
  {"id": "1", "name": "授業１", "teacherId": "1"},
  {"id": "2", "name": "授業２", "teacherId": "1"},
  {"id": "3", "name": "授業３", "teacherId": "1"},
  {"id": "4", "name": "授業４", "teacherId": "1"},
];
