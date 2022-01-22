/*
* 今回の課題アプリではレスポンシブデザインの表示部分にフォーカスしたいのでデータは永続化させない
*
* */

//途中で更新するのでfinalにしてはいけない
List<Task> baseTaskList = [
  Task(
    id: 1,
    title: "年末調整",
    detail: "これをちゃんとやらないと源泉税過大徴収になってしまう。住宅ローン控除もやっておかないと住民税で考慮してくれない。",
    limitDateTime: DateTime(2021, 12, 31),
    isImportant: true,
    isFinished: false,
  ),
  Task(
    id: 2,
    title: "住民税支払い",
    detail: "6〜11月分：12/10まで、12月〜5月分：6/10まで",
    limitDateTime: DateTime(2021, 12, 10),
    isImportant: true,
    isFinished: false,
  ),
  Task(
    id: 3,
    title: "アプリリニューアルリリース",
    detail: "・MVVM化\n・単語一覧をPageView化\n・単語DB更新できるように\n・デザインをもう少し格好良く",
    limitDateTime: DateTime(2021, 10, 31),
    isImportant: false,
    isFinished: false,
  ),
  Task(
    id: 4,
    title: "A社と打ち合わせ",
    detail: "同社内研修プログラムの件について（＠先方会議室）。こちらからは資料持参不要。",
    limitDateTime: DateTime(2021, 9, 15),
    isImportant: false,
    isFinished: false,
  ),
  Task(
    id: 5,
    title: "クレーム対応",
    detail: "B様から寄せられたXX講座に関するクレームの件。謝罪とともにレクチャー動画の更新もすること。",
    limitDateTime: DateTime(2021, 8, 17),
    isImportant: true,
    isFinished: false,
  ),
  Task(
    id: 6,
    title: "先月分の会計仕訳",
    detail: "8月分の経費精算も忘れずに。",
    limitDateTime: DateTime(2021, 9, 10),
    isImportant: false,
    isFinished: false,
  ),
];

//コンストラクタとcopyWithだけあればいい
class Task {
  final int id;
  final String title;
  final String detail;
  final DateTime limitDateTime;
  final bool isImportant;
  final bool isFinished;

//<editor-fold desc="Data Methods">

  const Task({
    required this.id,
    required this.title,
    required this.detail,
    required this.limitDateTime,
    required this.isImportant,
    required this.isFinished,
  });

  Task copyWith({
    int? id,
    String? title,
    String? detail,
    DateTime? limitDateTime,
    bool? isImportant,
    bool? isFinished,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      detail: detail ?? this.detail,
      limitDateTime: limitDateTime ?? this.limitDateTime,
      isImportant: isImportant ?? this.isImportant,
      isFinished: isFinished ?? this.isFinished,
    );
  }
}
