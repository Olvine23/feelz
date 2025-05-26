import 'package:dummmyfeelz/services/gemini_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class FeelzScreen extends StatefulWidget {
  const FeelzScreen({super.key});

  @override
  State<FeelzScreen> createState() => _FeelzScreenState();
}

class _FeelzScreenState extends State<FeelzScreen> {
  final TextEditingController _controller = TextEditingController();
 final GeminiService geminiService = GeminiService();

  
   String? aiResponse;
  bool isLoading = false;

  Future<void> fetchResponse(String prompt) async {

    await geminiService.getResponse(prompt).then((response) {
      print(response);
      setState(() {
        aiResponse = response;
        isLoading = false;
      });
    });
    
    // await Future.delayed(Duration(seconds: 2)); // Placeholder for Gemini call
    // setState(() {
    //   aiResponse = "You're stronger than you think — this too shall pass.";
    //   isLoading = false;
    // });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDE7F6), // Lavender
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
            child: ListView(
            children: [
              Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                BoxShadow(
                  color: Colors.deepPurple.withOpacity(0.08),
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                Text("Feelz",
                  style: GoogleFonts.pacifico(
                    fontSize: 36,
                    color: Colors.deepPurple,
                  )).animate().fadeIn(duration: 600.ms),
                SizedBox(height: 30),
                Text("How are you feeling today?",
                  style: GoogleFonts.lato(
                    fontSize: 20,
                    color: Colors.deepPurple.shade700,
                  )).animate().fadeIn(duration: 800.ms),
                SizedBox(height: 40),
                TextField(
                  style:TextStyle() ,
                  maxLines: null,
                  controller: _controller,
                  decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your emotion',
                  hintText: 'e.g. happy, sad, anxious',
                  ),
                  onSubmitted: (value) {
                  setState(() {
                    isLoading = true;
                    aiResponse = null; // Clear previous response
                  });
                  fetchResponse(value);
                  },
                ).animate().fadeIn(duration: 800.ms),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      setState(() {
                        isLoading = true;
                        aiResponse = null; // Clear previous response
                      });
                      fetchResponse(_controller.text);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Text("Get Response",
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      color: Colors.white,
                    )),
                ).animate().fadeIn(duration: 800.ms),
                // Lottie.asset(
                //   'assets/lotti/loading.json',    ),

                  SizedBox(height: 20),
                if (isLoading)
                 Lottie.asset('assets/lotti/loading.json',
                  // width: 100,
                  // height: 100,
                  repeat: true,
                  animate: true,)
                else if (aiResponse != null)
                  Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    aiResponse!,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    color: Colors.black87,
                    ),
                  ).animate().fadeIn(duration: 1000.ms),
                  ),
                ],
              ),
              ),
            ],
            ),
          ),
        ),
      );
  
  }
}