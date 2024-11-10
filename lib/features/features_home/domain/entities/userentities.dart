

import 'package:hive_flutter/hive_flutter.dart';
part 'userentities.g.dart';


@HiveType(typeId: 1)
class UserEntities{
 @HiveField(0)
 late int page;
 @HiveField(1)
 late int perPage;
 @HiveField(2)
 late int totalPages;
 @HiveField(3)
 late List<UserDataEntities> data;

 UserEntities(this.page, this.perPage, this.totalPages, this.data);
}



@HiveType(typeId: 2)
class UserDataEntities{
 @HiveField(0)
 late int id;
 @HiveField(1)
 late String email;
 @HiveField(2)
 late String firstName;
 @HiveField(3)
 late String lastName;
 @HiveField(4)
 late String avatar;

 UserDataEntities(this.id, this.email, this.firstName, this.lastName,this.avatar);

 @override
 bool operator ==(Object other) =>
     identical(this, other) ||
         other is UserDataEntities &&
             runtimeType == other.runtimeType &&
             id == other.id &&
             email == other.email;

 @override
 int get hashCode => id.hashCode ^ email.hashCode;

 @override
 String toString() => 'ReposEntities(id: $id, name: $email)';
}