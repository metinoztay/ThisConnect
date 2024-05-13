import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
              child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.1,
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    "lib/assets/images/enter_otp.png",
                    height: screenSize.height * 0.35,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text("Sign Up",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 25)),
                const SizedBox(
                  height: 10,
                ),
                const Text("Create a new account!",
                    style: TextStyle(color: Colors.grey, fontSize: 15)),
                const SizedBox(
                  height: 10,
                ),
                const TextField(
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      hintText: "Name",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: IconButton(
                        onPressed: null,
                        icon: Icon(Icons.person_outline),
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                const TextField(
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      hintText: "Surname",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: IconButton(
                        onPressed: null,
                        icon: Icon(Icons.account_tree_outlined),
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField<String>(
                    isExpanded: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                    iconSize: 24,
                    elevation: 16,
                    hint: const Text("Title"),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    style: const TextStyle(color: Colors.black),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: const [
                      DropdownMenuItem<String>(
                        value: 'One',
                        enabled: false,
                        child:
                            Text('Title', style: TextStyle(color: Colors.grey)),
                      ),
                      DropdownMenuItem<String>(
                          value: 'professor',
                          child: Text(
                            'Professor',
                          )),
                      DropdownMenuItem<String>(
                          value: 'associateprofessor',
                          child: Text('Associate Professor')),
                      DropdownMenuItem<String>(
                          value: 'assistantprofessor',
                          child: Text('Assistant Professor')),
                      DropdownMenuItem<String>(
                          value: 'researchassistant',
                          child: Text('Research Assistant')),
                      DropdownMenuItem<String>(
                          value: 'student', child: Text('Student')),
                      DropdownMenuItem<String>(
                          value: 'other', child: Text('Other')),
                    ]),
                const SizedBox(
                  height: 10,
                ),
                const TextField(
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: IconButton(
                        onPressed: null,
                        icon: Icon(Icons.email_outlined),
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.indigoAccent,
                    shadowColor: Colors.grey.shade300,
                    elevation: 10,
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
