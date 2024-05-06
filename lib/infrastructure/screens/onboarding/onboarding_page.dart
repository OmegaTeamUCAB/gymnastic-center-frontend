import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:gymnastic_center/presentation/utils/onboarding_items.dart';
import 'package:gymnastic_center/infrastructure/screens/home/main_screen.dart';
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final controller = OnboardingItems();
  final pageController = PageController();

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: isLastPage? getStarted() : Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            //Skip Button
            TextButton(
                onPressed: ()=>pageController.jumpToPage(controller.items.length-1),
                child: const Text("Skip")),

            //Indicator
            SmoothPageIndicator(
                controller: pageController,
                count: controller.items.length,
                onDotClicked: (index)=> pageController.animateToPage(index,
                    duration: const Duration(milliseconds: 600), curve: Curves.easeIn),
                effect: const WormEffect(
                  dotHeight: 12,
                  dotWidth: 12,
                // activeDotColor: LinearGradient,
                ),
            ),

            //Next Button
            TextButton(
                onPressed: ()=>pageController.nextPage(
                    duration: const Duration(milliseconds: 600), curve: Curves.easeIn),
                child: const Text("Next")),


          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: PageView.builder(
            onPageChanged: (index)=> setState(()=> isLastPage = controller.items.length-1 == index),
            itemCount: controller.items.length,
            controller: pageController,
            itemBuilder: (context,index){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(controller.items[index].image),
                  const SizedBox(height: 15),
                  Text(controller.items[index].title,
                    style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 15),
                  Text(controller.items[index].descriptions,
                      style: const TextStyle(color: Colors.grey,fontSize: 17), textAlign: TextAlign.center),
                ],
              );

        }),
      ),
    );
  }


 Widget getStarted(){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: const Color.fromARGB(255, 163, 37, 185)

      ),
      width: MediaQuery.of(context).size.width * .2,
      height: 50,
      child: TextButton(
          onPressed: (){
           // final pres = await SharedPreferences.getInstance();
           // pres.setBool("onboarding", true);

            //After we press get started button this onboarding value become true
            // same key
           // if(!mounted)return;
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainScreen()));
          },
          child: const Text("Get started",style: TextStyle(color: Colors.white),)),
    );

 }
}