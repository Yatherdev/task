import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String uid;
  final String firstName;

  final String secondName;

  final String email;

  final String phone;

  final String bloodType;

  final String governorate;

  final String village;

  final String center;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  UserData(
      {
    required this.uid,
    required this.phone,
    required this.email,
    required this.bloodType,
    required this.firstName,
    required this.secondName,
    required this.governorate,
    required this.center,
    required this.village,
    this.createdAt,
    this.updatedAt,

      });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      "firstName" : firstName ,
      "secondName" : secondName,
      "phone": phone,
      "email" :email,
      "bloodType" : bloodType,
      "governorate":governorate,
      "center":center,
      "village":village
    };
    if (createdAt != null ) map["createdAt"] = Timestamp.fromDate(createdAt!);
    if ( updatedAt != null ) map ["updatedAt"] = Timestamp.fromDate(updatedAt!);
    return map ;
  }
  // factory constructor = بيسمح ننشئ object من Map (اللي جاي من Firestore)
  factory UserData.fromMap(Map<String, dynamic> map, {String? docId}) {
    Timestamp? createdTs = map['createdAt'] as Timestamp?;
    Timestamp? updatedTs = map['updatedAt'] as Timestamp?;

    return UserData(
      uid: docId ?? (map['uid'] as String? ?? ''), // لو docId مش مبعوت ناخده من الماب
      email: map['email'] as String? ?? '',        // لو مش موجود نحط قيمة فاضية
      phone: map['phone'] as String? ?? '',
      governorate: map['governorate'] as String? ?? '',
      bloodType: map['bloodType'] as String? ?? '',
      firstName: map ['firstName'] as String? ?? '',
      secondName: map ['secondName'] as String? ?? '',
      center: map ['center'] as String? ?? '',
      village: map ['village'] as String? ?? '',
      createdAt: createdTs?.toDate(), // ?.toDate() عشان نتجنب null error
      updatedAt: updatedTs?.toDate(),
    );
  }

  // إنشاء object من DocumentSnapshot على طول (بدون Map)
  factory UserData.fromSnapshot(DocumentSnapshot snap) {
    // لو snap.data() = null نحط Map فاضية
    final data = snap.data() as Map<String, dynamic>? ?? {};
    // نستخدم fromMap ونبعثله الـ snap.id كـ uid
    return UserData.fromMap(data, docId: snap.id);
  }

  // دالة copyWith بتديك نسخة جديدة من الـ object مع تعديل قيم معينة
  // مفيدة عشان الكلاس immutable (final fields)
  UserData copyWith({
    String? email,
    String? phone,
    String? bloodType,
    String? firstName,
    String? secondName,
    String? governorate,
    String? center,
    String? village,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserData(
      uid: uid, // uid ثابت مينفعش يتغير
      email: email ?? this.email, // لو مبعوت جديد استخدمه، غير كده استخدم القديم
      phone: phone ?? this.phone,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      bloodType: bloodType ?? this.bloodType,
      firstName: firstName ?? this.firstName,
      secondName: secondName ?? this.secondName,
      governorate: governorate ?? this.governorate,
      center: center ?? this.center,
      village: village ?? this.village,
    );
  }

  // override toString = لو عملت print للـ object هيتعرض بشكل منظم
  @override
  String toString() {
    return 'UserProfile('
        'uid: $uid,'
        ' email: $email,'
        ' phone: $phone,'
        ' governorate: $governorate,'
        ' createdAt: $createdAt,'
        ' updatedAt: $updatedAt)'
      'firs tName: $firstName'
      'second Name: $secondName'
      'center: $center'
      'village:$village'
      'bloodType:$bloodType'
    ;
  }
}

