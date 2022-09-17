import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:handknitted/config/strings.dart';
import 'config/fonts.dart';

void main() {

  CounterController _controller=Get.put(CounterController());

  WidgetsFlutterBinding.ensureInitialized();
  //این قسمت اپ رو در حالت عمودی فقط برامون باز میکنه
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  runApp(GetMaterialApp(
    theme: ThemeData(fontFamily: FontFamily.iransans),
    debugShowCheckedModeBanner: false,
    title: Strings.AppTitle,
    home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text(Strings.AppName),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){
              SystemNavigator.pop();
          },
            icon: Icon(
                Icons.power_settings_new
            ),
            color: Colors.red,
          ),
        ],
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: Colors.grey.withOpacity(0.4),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("فروش",style: TextStyle(fontSize: 20),),
                              const Spacer(flex: 1,),
                              Obx(() => Text(_controller.foroshPrice.toStringAsFixed(2).toString(),style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("دستمزد",style: TextStyle(fontSize: 20),),
                              const Spacer(flex: 1,),
                              Obx(() => Text(_controller.dastMozd.toStringAsFixed(2).toString(),style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("قیمت خام",style: TextStyle(fontSize: 20),),
                              const Spacer(flex: 1,),
                              Obx(() =>
                                  Text(_controller.gheymatKham.toStringAsFixed(2).toString(),style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 2,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    onChanged: (_){
                      _controller.calc();
                    },
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.ltr,
                    controller: _controller.vaznController,
                    decoration: InputDecoration(
                      label:Text("وزن"),
                      hintText: "می توانید از اعداد اعشاری و صحیح استفاده کنید",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    onChanged: (_){
                      _controller.calc();
                    },
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.ltr,
                    controller: _controller.priceController,
                    decoration: InputDecoration(
                        label:Text("قیمت نخ"),
                        hintText: "می توانید از اعداد  صحیح استفاده کنید",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    onChanged: (_){
                      _controller.calc();
                    },
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.ltr,
                    controller: _controller.percentController,
                    decoration: InputDecoration(
                        label:Text("ضریب"),
                        hintText: "می توانید از اعداد اعشاری و صحیح استفاده کنید",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  )
  );
}


class CounterController extends GetxController {

  TextEditingController vaznController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController percentController = TextEditingController();

  var gheymatKham = 0.0.obs;
  var dastMozd = 0.0.obs;
  var foroshPrice = 0.0.obs;

  calc(){
    if(percentController.text.isNotEmpty && vaznController.text.isNotEmpty && priceController.text.isNotEmpty &&  double.parse(vaznController.text) > 0 && double.parse(priceController.text) > 0 && double.parse(percentController.text) > 0){
      gheymatKham(double.parse(vaznController.text) * double.parse(priceController.text));
      foroshPrice(double.parse(vaznController.text) * double.parse(priceController.text) * double.parse(percentController.text));
      dastMozd((double.parse(vaznController.text) * double.parse(priceController.text) * double.parse(percentController.text)) - (double.parse(vaznController.text) * double.parse(priceController.text)));
    }
    update();
  }

}
