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
  TextEditingController  username = new TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(),
        drawer: Drawer(),
        body:  Column(
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
                controller: username,


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
              child: Row(
                children: [
                  Container(
                    child: Text("Result : ",style: TextStyle(fontSize: 20),),
                    padding: EdgeInsets.only(left: 10,top: 200,right: 10,bottom: 100),
                  ),
                  Container(
                    child: Text("${x}",style: TextStyle(fontSize: 20),),
                    padding: EdgeInsets.only(left: 10,top: 200,right: 10,bottom: 100),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 100,left: 200),
              child: Row(

                children: [
                  Container(padding: EdgeInsets.all(10),child: ElevatedButton(onPressed: (){
                    setState(() {
                      x = username.text;
                      if(group == "Encryption"){
                         String ciphertext = "";
                         for(int i=0;i<x.length;i++){

                            if(x.codeUnitAt(i) >= "A".codeUnitAt(0) && x.codeUnitAt(i) <= "Z".codeUnitAt(0)){
                               int y = (x.codeUnitAt(i)) - 65;
                               y  += 3;
                               y += 65;
                               ciphertext += String.fromCharCode(y);
                            }
                            else if(x.codeUnitAt(i) >= "a".codeUnitAt(0) && x.codeUnitAt(i) <= "z".codeUnitAt(0)){
                              int y = (x.codeUnitAt(i)) - 97;
                              y  = (y+3) % 26;
                              y += 97;
                              ciphertext += String.fromCharCode(y);
                            }
                            else{
                              ciphertext += x[i];
                            }
                         }
                         x = ciphertext;
                      }
                      else if(group == "Decryption"){
                          String plaintext = "";
                          for(int i=0;i<x.length;i++){
                            if(x.codeUnitAt(i) >= "A".codeUnitAt(0) && x.codeUnitAt(i) <= "Z".codeUnitAt(0)){
                                int y = x.codeUnitAt(i) - 65;
                                y = y-3;
                                y += 25;
                                y%=25;
                                y+=65;
                                plaintext += String.fromCharCode(y);
                            }
                            else if(x.codeUnitAt(i) >= "a".codeUnitAt(0) && x.codeUnitAt(i) <= "z".codeUnitAt(0)){
                              int y = x.codeUnitAt(i) - 97;
                              y = y-3;
                              y += 25;
                              y%=25;

                              y+=97;
                              plaintext += String.fromCharCode(y);
                            }
                            else{
                              plaintext += x[i];
                            }
                          }
                          x = plaintext;
                      }
                    });

                  }, child: Text("OK")),
                  ),
                  Container( child: ElevatedButton(onPressed: (){}, child: Text("Clear")),
                    padding: EdgeInsets.all(10),
                  ),

                ],
              ),
            )



          ],
        )

    );


  }
}
