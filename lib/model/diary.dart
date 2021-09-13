import 'package:cloud_firestore/cloud_firestore.dart';

class Diary {
  final String? id;
  final String? userId;
  final String? title;
  final String? author;
  final String? photoUrls;
  final Timestamp? entryTime;
  final String? description;

  Diary(
      {this.id,
      this.userId,
      this.title,
      this.author,
      this.photoUrls,
      this.entryTime,
      this.description});

  factory Diary.fromDocument(QueryDocumentSnapshot data) {
    return Diary(
      id: data.id,
      userId: data.get('user_id'),
      author: data.get('author'),
      entryTime: data.get('entry_time'),
      photoUrls: data.get('photo_list'),
      title: data.get('title'),
      description: data.get('description'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'author': author,
      'entry_time': entryTime,
      'photo_list': photoUrls,
      'title': title,
      'description': description
    };
  }
}
