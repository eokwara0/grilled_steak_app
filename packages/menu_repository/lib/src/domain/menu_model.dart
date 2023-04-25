import 'package:equatable/equatable.dart';

class Menu extends Equatable {
  final String _id;
  final String? _userId;
  final String? _title;
  final String? _summary;
  final String? _content;

  const Menu({
    required String id,
    String? userId,
    String? title,
    String? summary,
    String? content,
  })  : _id = id,
        _userId = userId,
        _title = title,
        _summary = summary,
        _content = content;

  copyWith({
    String? userId,
    String? title,
    String? summary,
    String? content,
  }) {
    return Menu(
      id: _id,
      title: title ?? _title,
      userId: userId ?? userId,
      content: content ?? content,
      summary: summary ?? _summary,
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': _userId,
        'title': _title,
        'summary': _summary,
        'content': _content,
      };

  static fromJson(Map<dynamic, dynamic> data) {
    return Menu(
      id: '${data['_id']}',
      userId: '${data['_userId']}',
      title: '${data['_title']}',
      summary: '${data['_summary']}',
      content: '${data['_content']}',
    );
  }

  @override
  List<Object?> get props => [
        _id,
        _userId,
        _title,
        _summary,
        _content,
      ];
}
