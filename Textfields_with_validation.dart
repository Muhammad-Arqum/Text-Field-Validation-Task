import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

void main() => runApp(TextFieldsValidationApp());

class TextFieldsValidationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TextFieldsValidationScreen(),
    );
  }
}

class TextFieldsValidationScreen extends StatefulWidget {
  @override
  _TextFieldsValidationScreenState createState() =>
      _TextFieldsValidationScreenState();
}

class _TextFieldsValidationScreenState
    extends State<TextFieldsValidationScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _name, _email, _cnic, _contact, _address, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Form with Validation")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Name is required';
                  if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value))
                    return 'Only letters allowed';
                  return null;
                },
                onSaved: (value) => _name = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) =>
                    value != null && EmailValidator.validate(value)
                        ? null
                        : 'Enter a valid email',
                onSaved: (value) => _email = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'CNIC'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.length != 13)
                    return 'CNIC must be exactly 13 digits';
                  if (!RegExp(r'^\d+$').hasMatch(value))
                    return 'Only digits allowed';
                  return null;
                },
                onSaved: (value) => _cnic = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contact Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.length < 10 || value.length > 12) {
                    return 'Contact number must be 10-12 digits';
                  }
                  return null;
                },
                onSaved: (value) => _contact = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) =>
                    value!.isEmpty ? 'Address cannot be empty' : null,
                onSaved: (value) => _address = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  if (!RegExp(
                          r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$')
                      .hasMatch(value)) {
                    return 'Password must include letters, numbers, and symbols';
                  }
                  return null;
                },
                onSaved: (value) => _password = value,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Form Submitted')));
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
