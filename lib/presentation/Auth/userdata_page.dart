import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../Model/custom_color.dart';
import '../../Widgets/custom_button.dart';
import '../../Widgets/custom_text_form_field.dart';
import '../../Widgets/gradiant_scaffold.dart';
import '../../Widgets/login_button.dart';
import 'login_page.dart';

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({super.key});

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  // validators
  String? validatePhone(value) {
    if (value == null || value.trim().isEmpty) {
      return 'الرجاء إدخال رقم الهاتف';
    }
    final phone = value.trim();

    // يقبل: 01xxxxxxxxx (11 رقم) أو +201xxxxxxxxx (13 رقم)
    final egyptPhoneRegex = RegExp(r'^(?:\+201|01)[0-2,5]{1}[0-9]{8}$');

    if (!egyptPhoneRegex.hasMatch(phone)) {
      return 'الرجاء إدخال رقم صحيح';
    }
    return null;
  }

  final List<String> bloodTypes = [
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "O+",
    "O-",
  ];
  String? selectedType;
  final Map<String, Map<String, List<String>>> locationdata = {
    "القاهره": {
      "مصر الجديده": ["الحجاز", "النزهه", "المرغينى"],
      "المعادى": ["زهراء المعادى", "حدائق المعادى", "كورنيش المعادى"],
    },
    "الدقهليه": {
      "طلخا": ["الروضه", "المنيل", "الطويله", "كفر الطويله"],
      "السنبلاوين": ["أشطر", "بادى", "فيروز", "كفر عبده"],
    },
    "الجيزه": {
      "الهرم": ["الطالبيه", "فيصل", "كرداسه"],
      "أكتوبر": ["الحى الأول", "الحى الخامس", "الحى الحادى عشر"],
    },
  };
  String? selectedGovernorate;
  String? selectedCenter;
  String? selectedVillage;

  @override
  Widget build(BuildContext context) {
    final centers = selectedGovernorate != null
        ? locationdata[selectedGovernorate!]!.keys.toList()
        : [];
    final villages = (selectedGovernorate != null && selectedCenter != null)
        ? locationdata[selectedGovernorate!]![selectedCenter!]!
        : [];

    return GradientScaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                  child: Image.asset(
                    'Assets/images/bloodbag1.png',
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                          "Enter Your Data",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            crossAxisCount: 4,
                          ),
                          itemCount: bloodTypes.length,
                          itemBuilder: (context, index) {
                            final type = bloodTypes[index];
                            final isSelected = selectedType == type;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedType = type;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isSelected
                                      ? Colors.red
                                      : Colors.grey.shade200,
                                  border: Border.all(
                                    color: isSelected
                                        ? Colors.red.shade700
                                        : Colors.red.withOpacity(.4),
                                    width: 2,
                                  ),
                                  boxShadow: isSelected
                                      ? [
                                    BoxShadow(
                                      color:
                                      Colors.red.withOpacity(0.4),
                                      blurRadius: 8,
                                    ),
                                  ]
                                      : [],
                                ),
                                child: Center(
                                  child: Text(
                                    type,
                                    style: TextStyle(
                                      color: isSelected?Colors.white:Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 20),
                        // Phone number TextFormField
                        CustomTextFormField(
                          controller: _phoneController,
                          labelText: 'Phone Number',
                          hintText: '01012345678',
                          prefixIcon: Icons.phone,
                          isPassword: false,
                          keyboardType: TextInputType.phone,
                          validator: validatePhone,
                        ),
                        SizedBox(height: 20),

                        /// Dropdown المحافظات
                        SizedBox(
                          child: DropdownButtonFormField<String>(
                            borderRadius: BorderRadius.circular(5),
                            decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),),
                            hint: Text("أختر المحافظه"),
                            value: selectedGovernorate,
                            items: locationdata.keys
                                .map((gov) => DropdownMenuItem(
                              value: gov,
                              child: Text(gov),
                            ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedGovernorate = value;
                                selectedCenter = null;
                                selectedVillage = null;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 20),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          /// Dropdown المراكز
                          SizedBox(
                            width: 160,
                            child: DropdownButtonFormField<String>(
                              borderRadius: BorderRadius.circular(5),
                              decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),),
                              isExpanded: true,
                              hint: Text("أختر المركز"),
                              value: centers.contains(selectedCenter)
                                  ? selectedCenter
                                  : null,
                              items: centers.map((center) => DropdownMenuItem<String>(
                                value: center,
                                child: Text(center),
                              )).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedCenter = value;
                                  selectedVillage = null;
                                });
                              },
                            ),
                          ),
                          /// Dropdown القرى
                          SizedBox(
                            width: 160,
                            child: DropdownButtonFormField<String>(
                              borderRadius: BorderRadius.circular(5),
                              decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),),
                              isExpanded: true,
                              hint: Text("أختر القريه"),
                              value: villages.contains(selectedVillage)
                                  ? selectedVillage
                                  : null,
                              items: villages
                                  .map((village) => DropdownMenuItem<String>(
                                value: village,
                                child: Text(village),
                              ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedVillage = value;
                                });
                              },
                            ),
                          ),
                        ],),
                        SizedBox(height: 20),

                        if (selectedGovernorate != null &&
                            selectedVillage != null &&
                            selectedCenter != null)
                          Text(
                            "$selectedGovernorate , $selectedCenter , $selectedVillage",
                          ),

                        CustomButton(
                          onPressed: () {},
                          child: Text(
                            "Save",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}