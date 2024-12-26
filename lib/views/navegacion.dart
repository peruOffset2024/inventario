import 'package:flutter/material.dart';
import 'package:tesla/views/animation/animated_align.dart';
import 'package:tesla/views/animation/animated_builder.dart';
import 'package:tesla/views/animation/animated_container.dart';
import 'package:tesla/views/animation/animated_positioned.dart';
import 'package:tesla/views/animation/fade_trasnsition.dart';

class NavegacionApp extends StatelessWidget {
  const NavegacionApp({super.key});

 

  @override
  Widget build(BuildContext context) {
     const Color color= Colors.blue;
    return  Scaffold(
      body: Container(
        color: Colors.grey[400],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
           
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const AnimatedAling()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color:color,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: const ListTile(
                    
                    title: Text('AnimatedAling', textAlign: TextAlign.center),
                    
                  ),
                ),
              ),
              const  SizedBox(height: 15,),
               InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const AnimatedBuilderExample()));
                },
                 child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(10)
                  ),
                   child: const ListTile(
                    title: Text('AnimatedBuilder', textAlign: TextAlign.center),),
                 ),
               ),
               const  SizedBox(height: 15,),
               InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const AnimatedContainerExample()));
                },
                 child: Container(
                  decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(10)
                    ),
                   child: const ListTile(
                    title: Text('Animated Container', textAlign: TextAlign.center),
                    
                    
                                 ),
                 ),
               ),
               const  SizedBox(height: 15,),
               InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const AnimatedPositionedExample()));
                },
                 child: Container(
                  decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(10)
                    ),
                   child: const ListTile(
                    title: Text('Animated Positioned', textAlign: TextAlign.center),
                    
                    
                                 ),
                 ),
               ),
               const  SizedBox(height: 15,),
               InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const FadeTrasnsitionMain()));
                },
                 child: Container(
                  decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(10)
                    ),
                   child: const ListTile(
                    title: Text('FadeTransition', textAlign: TextAlign.center),
                    
                    
                                 ),
                 ),
               ),
               const  SizedBox(height: 15,),
               InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const FadeTrasnsitionMain()));
                },
                 child: Container(
                  decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(10)
                    ),
                   child: const ListTile(
                    title: Text('Hero', textAlign: TextAlign.center),
                    
                    
                                 ),
                 ),
               ),
              

              
            ],
          ),
        ),
      )
    );
  }
}




  

