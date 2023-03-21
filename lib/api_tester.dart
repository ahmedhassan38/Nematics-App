import 'package:flutter/material.dart';
import 'package:nematicsapp/controller/authController.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  var auth = AuthController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Api'),
        centerTitle: true,
        
      ),
      body: Column(
        children: [

          Expanded(
            child: FutureBuilder(
              future: auth.preview(1),
              builder: (context,AsyncSnapshot<dynamic> snapshot){
                return ListTile(
                  title: Text('Preview'),
                  subtitle: Text(
                      snapshot.hasData?snapshot.data.toString():'Not Data Returend'
                  ),
                );
              },
            ),
          ),

          Expanded(
            child: FutureBuilder(
              future: auth.login('abc@gmail.com', '12345678'),
              builder: (context,AsyncSnapshot<dynamic> snapshot){
                if(snapshot.hasData){
                  return ListTile(
                    title: Text('Login'),
                    subtitle: Text(
                        snapshot.hasData?snapshot.data.message.toString():'Not Data Returend'
                    ),
                  );
                }
                else{
                  return ListTile(
                    title: Text('Login'),
                    subtitle: Text(
                        snapshot.hasData?snapshot.data:'Not Data Returend'
                    ),
                  );
                }
              },
            ),
          ),

          Expanded(
            child: FutureBuilder(
              future: auth.register('waheed', 'akhtar','waheedakhtar0078@gmail.com','password','Student'),
              builder: (context,AsyncSnapshot<dynamic> snapshot){
                return ListTile(
                  title: Text('Register'),
                  subtitle: Text(
                      snapshot.hasData?snapshot.data.toString():'Not Data Returend'
                  ),
                );
              },
            ),
          ),

          Expanded(
            child: FutureBuilder(
              future: auth.update('waheed', 'akhtar','waheedakhtar0078@gmail.com','password','Student'),
              builder: (context,AsyncSnapshot<dynamic> snapshot){
                return ListTile(
                  title: Text('Update'),
                  subtitle: Text(
                      snapshot.hasData?snapshot.data.toString():'Not Data Returned'
                  ),
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}
