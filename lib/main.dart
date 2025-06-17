import 'package:flutter/material.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'dart:ui' as ui;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Form Validation',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white10,
        primarySwatch: Colors.deepOrange,
        inputDecorationTheme: InputDecorationTheme(
          errorStyle: TextStyle(color: Colors.red),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.orangeAccent),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.orangeAccent),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.orangeAccent, width: 2),
          ),
        ),
      ),
      home: const FormValidationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FormValidationScreen extends StatefulWidget {
  const FormValidationScreen({Key? key}) : super(key: key);

  @override
  _FormValidationScreenState createState() => _FormValidationScreenState();
}

class _FormValidationScreenState extends State<FormValidationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _signatureKey = GlobalKey<SignatureState>();

  // Form values
  String fullName = '';
  String dateOfBirth = '';
  String gender = 'Select Gender';
  String age = '';
  double familyMembers = 5.0;
  int rating = 0;
  int stepper = 10;
  bool isEnglish = false;
  bool isHindi = false;
  bool isOther = false;
  bool termsAccepted = false;

  // Error states
  bool nameError = false;
  bool dobError = false;
  bool genderError = false;
  bool termsError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Form Validation'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Full Name Field
                const Text('Full Name'),
                TextFormField(
                  decoration: InputDecoration(
                    errorText: nameError ? 'This field cannot be empty' : null,
                  ),
                  onChanged: (value) {
                    setState(() {
                      fullName = value;
                      nameError = value.isEmpty;
                    });
                  },
                ),
                const SizedBox(height: 16),

                // Date of Birth Field
                const Text('Date of Birth'),
                TextFormField(
                  decoration: InputDecoration(
                    errorText: dobError ? 'This field cannot be empty' : null,
                  ),
                  onChanged: (value) {
                    setState(() {
                      dateOfBirth = value;
                      dobError = value.isEmpty;
                    });
                  },
                ),
                const SizedBox(height: 16),

                // Gender Dropdown
                const Text('Gender'),
                DropdownButtonFormField<String>(
                  value: gender,
                  decoration: InputDecoration(
                    errorText:
                        genderError ? 'This field cannot be empty' : null,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      gender = newValue!;
                      genderError = gender == 'Select Gender';
                    });
                  },
                  items:
                      <String>[
                        'Select Gender',
                        'Male',
                        'Female',
                        'Other',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                ),
                const SizedBox(height: 16),

                // Age Field
                const Text('Age'),
                TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      age = value;
                    });
                  },
                ),
                const SizedBox(height: 16),

                // Number of Family Members Slider
                const Text('Number of Family Members'),
                Slider(
                  value: familyMembers,
                  min: 0.0,
                  max: 10.0,
                  divisions: 10,
                  activeColor: Colors.deepOrangeAccent,
                  inactiveColor: Colors.orangeAccent.withOpacity(0.2),
                  onChanged: (value) {
                    setState(() {
                      familyMembers = value;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [Text('0.0'), Text('8.0'), Text('10.0')],
                ),
                const SizedBox(height: 16),

                // Rating
                const Text('Rating'),
                Row(
                  children: List.generate(5, (index) {
                    return Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            rating = index + 1;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(2),
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.orangeAccent),
                            color:
                                rating > index
                                    ? Colors.orangeAccent.withOpacity(0.2)
                                    : Colors.white,
                          ),
                          child: Center(child: Text('${index + 1}')),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 16),

                // Stepper
                const Text('Stepper'),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (stepper > 0) stepper--;
                        });
                      },
                    ),
                    Text('$stepper'),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          stepper++;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Languages you know
                const Text('Languages you know'),
                Row(
                  children: [
                    Checkbox(
                      value: isEnglish,
                      activeColor: Colors.orangeAccent,
                      onChanged: (bool? value) {
                        setState(() {
                          isEnglish = value!;
                        });
                      },
                    ),
                    const Text('English'),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isHindi,
                      activeColor: Colors.orangeAccent,
                      onChanged: (bool? value) {
                        setState(() {
                          isHindi = value!;
                        });
                      },
                    ),
                    const Text('bla bla bla'),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isOther,
                      activeColor: Colors.orangeAccent,
                      onChanged: (bool? value) {
                        setState(() {
                          isOther = value!;
                        });
                      },
                    ),
                    const Text('Other'),
                  ],
                ),
                const SizedBox(height: 16),

                // Signature
                const Text('Signature'),
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Signature(
                    key: _signatureKey,
                    color: Colors.black,
                    strokeWidth: 2.0,
                    backgroundPainter: null,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      icon: const Icon(Icons.clear, color: Colors.red),
                      label: const Text(
                        'Clear',
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        setState(() {
                          _signatureKey.currentState?.clear();
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Rating Stars
                const Text('Rate this site'),
                Row(
                  children: List.generate(5, (index) {
                    return IconButton(
                      icon: Icon(Icons.star, color: Colors.orangeAccent),
                      onPressed: () {
                        // Handle star rating
                      },
                    );
                  }),
                ),
                const SizedBox(height: 16),

                // Terms and Conditions
                Row(
                  children: [
                    Checkbox(
                      value: termsAccepted,
                      activeColor: Colors.orangeAccent,
                      onChanged: (bool? value) {
                        setState(() {
                          termsAccepted = value!;
                          termsError = !termsAccepted;
                        });
                      },
                    ),
                    const Expanded(
                      child: Text(
                        'I have read and agree to the terms and conditions',
                      ),
                    ),
                  ],
                ),
                if (termsError)
                  const Text(
                    'You must accept terms and conditions to continue',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                const SizedBox(height: 16),

                // Submit and Reset buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          nameError = fullName.isEmpty;
                          dobError = dateOfBirth.isEmpty;
                          genderError = gender == 'Select Gender';
                          termsError = !termsAccepted;

                          if (!nameError &&
                              !dobError &&
                              !genderError &&
                              !termsError) {
                            // Submit form
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Form submitted successfully'),
                              ),
                            );
                          }
                        });
                      },
                      child: const Text('Submit'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors
                                .orange, // Changed from 'primary' to 'backgroundColor'
                      ),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () {
                        // Reset form
                        setState(() {
                          fullName = '';
                          dateOfBirth = '';
                          gender = 'Select Gender';
                          age = '';
                          familyMembers = 5.0;
                          rating = 0;
                          stepper = 10;
                          isEnglish = false;
                          isHindi = false;
                          isOther = false;
                          termsAccepted = false;
                          nameError = false;
                          dobError = false;
                          genderError = false;
                          termsError = false;
                          _signatureKey.currentState?.clear();
                        });
                      },
                      child: const Text('Reset'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.arrow_back), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.circle_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.crop_square), label: ''),
        ],
      ),
    );
  }
}

// Custom BottomNavigationBarItem to match the design
class BottomNavigationItem extends BottomNavigationBarItem {
  BottomNavigationItem({required IconData icon, required String label})
    : super(icon: Icon(icon), label: label);
}

// Signature pad widget
class Signature extends StatefulWidget {
  final Color color;
  final double strokeWidth;
  final CustomPainter? backgroundPainter;

  const Signature({
    Key? key,
    required this.color,
    required this.strokeWidth,
    required this.backgroundPainter,
  }) : super(key: key);

  @override
  SignatureState createState() => SignatureState();
}

class SignatureState extends State<Signature> {
  List<Offset?> _points = <Offset?>[];

  void clear() {
    setState(() {
      _points.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (DragUpdateDetails details) {
        setState(() {
          RenderBox? referenceBox = context.findRenderObject() as RenderBox?;
          if (referenceBox != null) {
            Offset localPosition = referenceBox.globalToLocal(
              details.globalPosition,
            );
            _points.add(localPosition);
          }
        });
      },
      onPanEnd: (DragEndDetails details) => _points.add(null),
      child: CustomPaint(
        painter: SignaturePainter(
          points: _points,
          strokeColor: widget.color,
          strokeWidth: widget.strokeWidth,
          backgroundPainter: widget.backgroundPainter,
        ),
        size: Size.infinite,
      ),
    );
  }
}

class SignaturePainter extends CustomPainter {
  final List<Offset?> points;
  final Color strokeColor;
  final double strokeWidth;
  final CustomPainter? backgroundPainter;

  SignaturePainter({
    required this.points,
    required this.strokeColor,
    required this.strokeWidth,
    this.backgroundPainter,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (backgroundPainter != null) {
      backgroundPainter!.paint(canvas, size);
    }

    Paint paint =
        Paint()
          ..color = strokeColor
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      } else if (points[i] != null && points[i + 1] == null) {
        canvas.drawPoints(ui.PointMode.points, [points[i]!], paint);
      }
    }
  }

  @override
  bool shouldRepaint(SignaturePainter oldDelegate) => true;
}
