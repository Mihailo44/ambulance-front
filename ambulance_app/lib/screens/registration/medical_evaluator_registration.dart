
import 'package:ambulance_app/screens/tables/all_operating_bases.dart';
import 'package:flutter/material.dart';

class MedicalEvaluatorRegistration extends StatefulWidget {

  const MedicalEvaluatorRegistration({Key? key}):super(key: key);

  @override
  _MedicalEvaluatorRegistrationState createState() => _MedicalEvaluatorRegistrationState();

}

class _MedicalEvaluatorRegistrationState extends State<MedicalEvaluatorRegistration>{
  final _formKey = GlobalKey<FormState>();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  //* role je zakucan na Med Eval

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText
  }){
    return 
    TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
      validator: (value) => _validateField(value,labelText),
    );
  }

  String? _validateField(String? value,String labelText){
    if(value == null || value.isEmpty){
      return "$labelText is required";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FractionallySizedBox(
        widthFactor: 0.7,
        child: Center(
            
            child: Form(
            key: _formKey,
          child: Column(
            children: [
              const SizedBox(height:15.0),
              _buildTextFormField(controller: _firstnameController, labelText: "Firstname"),
              const SizedBox(height: 15.0,),
              _buildTextFormField(controller: _lastnameController, labelText: "Lastname"),
              const SizedBox(height: 15.0,),
              _buildTextFormField(controller: _passwordController, labelText: "Password"),
              const SizedBox(height: 15.0,),
              _buildTextFormField(controller: _dateOfBirthController, labelText: "Date Of Birth"),
              const SizedBox(height: 15.0,),
              ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AllOperatingBases()));
                }, 
                child: const Text("Pick an operating base")
              ),
            ],
          ) 
        ),
      ),
      ),
    ) ;
  }

}