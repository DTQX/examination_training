import 'package:examination_training/model/paper.dart';

List<Paper> mockPs = List.generate(10, (index) => Paper(
  'p_id_$index',
  'title_$index',
  2020,
  'math',
  List.generate(10, (index) => Question(
    'q_id_$index',
    'q_title_$index',
    'q_desc_$index',
    'images/p1.png',
  ))
));

Future<List<Paper>> getMockPaper() {
  return Future<List<Paper>>.value(mockPs);
}
