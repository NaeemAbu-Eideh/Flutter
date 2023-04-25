import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return  MaterialApp(
       home: CeaserCipher(),

    );
  }

}


class CeaserCipher extends StatefulWidget{
   State<StatefulWidget> createState(){
     return Frame();
   }

}

class Frame extends State<CeaserCipher>{
  String x = "";
  String? group = "";
  int key = 0;
  Random rand = new Random();
  @override
  void initState() {
    Random rand = new Random();
    key = rand.nextInt(1000) % 26;
    if(key == 0)key+=1;
    super.initState();
  }
  TextEditingController  textname = new TextEditingController();
  TextEditingController  resultname = new TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: Text("Ceaser cipher"),),
        drawer: Drawer(),
        body: ListView(

              children: [
                Column(
                  children:  [
                    Container(
                      child: TextField(

                        decoration:  InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:  BorderSide(
                              width: 3,
                            ),

                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:  BorderSide(
                                width: 3,

                              )
                          ),
                          labelText: "enter a text: ",

                        ),
                        controller: textname,


                      ),
                      padding: EdgeInsets.all(20),

                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Radio(value: "Encryption", groupValue: group, onChanged: (val){
                                    setState(() {
                                      group = val;
                                    });
                                  }),
                                ),
                                Text("Encryption")
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Radio(value: "Decryption", groupValue: group, onChanged: (val){
                                    setState(() {
                                      group = val;
                                    });
                                  }),
                                ),
                                Text("Decryption")
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 300,top: 100),
                       child: Text("key = ${key}",style: TextStyle(fontSize: 20),),
                    ),
                    Container(
                      child: TextField(

                        decoration:  InputDecoration(
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:  BorderSide(
                              width: 3,
                            ),

                          ),
                          labelText: "Result: ",
                           enabled: false,

                        ),
                        controller: resultname,


                      ),
                      padding: EdgeInsets.only(left: 10,top: 100,right: 10,bottom: 100),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 50,left: 10),
                      child: Row(

                        children: [
                          Container(padding: EdgeInsets.all(10),
                            child: ElevatedButton(onPressed: (){
                            setState(() {
                              x = textname.text;
                              if(group == "Encryption"){
                                String ciphertext = "";
                                for(int i=0;i<x.length;i++){

                                  if(x.codeUnitAt(i) >= "A".codeUnitAt(0) && x.codeUnitAt(i) <= "Z".codeUnitAt(0)){
                                    int y = (x.codeUnitAt(i)) - 65;
                                    y  += key;
                                    y += 65;
                                    ciphertext += String.fromCharCode(y);
                                  }
                                  else if(x.codeUnitAt(i) >= "a".codeUnitAt(0) && x.codeUnitAt(i) <= "z".codeUnitAt(0)){
                                    int y = (x.codeUnitAt(i)) - 97;
                                    y  = (y+key) % 26;
                                    y += 97;
                                    ciphertext += String.fromCharCode(y);
                                  }
                                  else{
                                    ciphertext += x[i];
                                  }
                                }
                                resultname.text = ciphertext;
                              }
                              else if(group == "Decryption"){
                                String plaintext = "";
                                for(int i=0;i<x.length;i++){
                                  if(x.codeUnitAt(i) >= "A".codeUnitAt(0) && x.codeUnitAt(i) <= "Z".codeUnitAt(0)){
                                    int y = x.codeUnitAt(i) - 65;
                                    y = y-key;
                                    y += 25;
                                    y%=25;
                                    y+=65;
                                    plaintext += String.fromCharCode(y);
                                  }
                                  else if(x.codeUnitAt(i) >= "a".codeUnitAt(0) && x.codeUnitAt(i) <= "z".codeUnitAt(0)){
                                    int y = x.codeUnitAt(i) - 97;
                                    y = y-key;
                                    y += 26;
                                    y%=26;

                                    y+=97;
                                    plaintext += String.fromCharCode(y);
                                  }
                                  else{
                                    plaintext += x[i];
                                  }
                                }
                                resultname.text = plaintext;
                              }
                            });

                          }, child: Text("OK"),

                          ),
                          ),
                          Container(
                            child: ElevatedButton(
                              onPressed: (){
                            setState(() {
                              textname.text = "";
                              resultname.text= "";
                            });
                          }, child: Text("Clear")),
                            padding: EdgeInsets.all(10),
                          ),
                          Container(
                            child: ElevatedButton(onPressed: (){
                            if(group == "Decryption")
                                 textname.text = resultname.text;
                          }, child: Text("Get text")),
                            padding: EdgeInsets.all(10),
                          ),
                          Container(
                            child: ElevatedButton(onPressed: (){
                              setState(() {
                                key = rand.nextInt(1000)%26;
                                if(key == 0)key+=1;
                              });
                            }, child: Text("setKey")),
                            padding: EdgeInsets.all(10),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
        )
    );


  }
}
