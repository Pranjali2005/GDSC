import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'bmi_calculator_page.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({super.key});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  String? _selectedGender;
  String _selectedAgeGroup = '';
  bool _isLoading = false;

  late AnimationController _controller;
  late Animation<Color?> _gradientAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _gradientAnimation = ColorTween(
      begin: const Color(0xFF43CEA2), // teal
      end: const Color(0xFF185A9D), // purple/blue
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BMICalculatorPage(
          userName: _nameController.text,
          userAge: int.parse(_ageController.text),
          userGender: _selectedGender ?? 'Not specified',
        ),
      ),
    );
  }

  void _autoSelectAgeGroup() {
    final age = int.tryParse(_ageController.text);
    if (age != null && age >= 6) {
      setState(() {
        _selectedAgeGroup = age >= 18 ? 'Adult 👩‍🦳👨‍🦳' : 'Child 👶';
      });
    } else {
      setState(() {
        _selectedAgeGroup = '';  // Reset if age is less than 6
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _gradientAnimation.value!,
                  _gradientAnimation.value!.withOpacity(0.85),
                  Colors.white.withOpacity(0.2),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: child,
          );
        },
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(36),
              gradient: const LinearGradient(
                colors: [Colors.teal, Colors.purpleAccent],
              ),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(30),
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 24),
                        Text(
                          'Tell Us About Yourself',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 5,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'This helps us personalize your experience',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.lightBlueAccent,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),

                        // Name Field
                        TextFormField(
                          controller: _nameController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                          ],
                          decoration: InputDecoration(
                            labelText: 'Full Name',
                            labelStyle: const TextStyle(color: Colors.teal),
                            prefixIcon: const Icon(Icons.person_outline, color: Colors.teal),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.3),
                            errorStyle: TextStyle(color: Colors.red[200]),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                              return 'Only alphabetic characters allowed';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Gender Dropdown
                        DropdownButtonFormField<String>(
                          value: _selectedGender,
                          decoration: InputDecoration(
                            labelText: 'Gender',
                            labelStyle: const TextStyle(color: Colors.purple),
                            prefixIcon: const Icon(Icons.people_outline, color: Colors.purple),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.3),
                          ),
                          items: const [
                            DropdownMenuItem(
                                value: 'Male',
                                child: Text('Male', style: TextStyle(color: Colors.indigo))),
                            DropdownMenuItem(
                                value: 'Female',
                                child: Text('Female', style: TextStyle(color: Colors.pink))),
                            DropdownMenuItem(
                                value: 'Other',
                                child: Text('Other', style: TextStyle(color: Colors.deepOrange))),
                            DropdownMenuItem(
                                value: 'Prefer not to say',
                                child: Text('Prefer not to say',
                                    style: TextStyle(color: Colors.grey))),
                          ],
                          onChanged: (value) => setState(() => _selectedGender = value),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select your gender';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Age Field
                        TextFormField(
                          controller: _ageController,
                          decoration: InputDecoration(
                            labelText: 'Age',
                            labelStyle: const TextStyle(color: Colors.green),
                            prefixIcon:
                            const Icon(Icons.calendar_today_outlined, color: Colors.green),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.3),
                            errorStyle: TextStyle(color: Colors.red[200]),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                          onChanged: (value) => _autoSelectAgeGroup(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your age';
                            }
                            final age = int.tryParse(value);
                            if (age == null) {
                              return 'Invalid age format';
                            }
                            if (age < 6) {
                              return 'Minimum age is 6';
                            }
                            if (age > 120) {
                              return 'Please enter valid age';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Age Group Display Box
                        AnimatedSwitcher(
                          duration: const Duration(seconds: 1),
                          child: Container(
                            key: ValueKey<String>(_selectedAgeGroup),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Colors.orangeAccent, Colors.deepOrange],
                              ),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                _selectedAgeGroup.isNotEmpty
                                    ? 'Age Group: $_selectedAgeGroup'
                                    : 'Enter age to determine group',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Continue Button
                        ElevatedButton(
                          onPressed: _isLoading ? null : _submit,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            backgroundColor: const Color(0xFF42A5F5),
                            foregroundColor: Colors.white,
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            minimumSize: const Size(double.infinity, 60),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          )
                              : const Text(
                            'Continue to BMI Calculator',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
