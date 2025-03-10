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
  {"id": "1", "name": "国語", "teacherId": "1"},
  {"id": "2", "name": "数学", "teacherId": "1"},
  {"id": "3", "name": "理科", "teacherId": "1"},
  {"id": "4", "name": "社会", "teacherId": "1"},
  {"id": "5", "name": "英語", "teacherId": "1"}
];
