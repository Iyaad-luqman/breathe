import 'package:breathe/home.dart';
import 'package:breathe/registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
          void login() async {try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        User? user = userCredential.user;

        if (user != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .update({
            'lastLogin': FieldValue.serverTimestamp(),
          });
        }

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
        // The user signed in successfully, navigate to your app's main screen here.
      } on FirebaseAuthException catch (e) {
        void showRegistrationFailedDialog(BuildContext context) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Login Failed'),
                content: Text('Incorrect Username or Password'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      }
    }
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      width: double.infinity,
      child: Container(
        // login6n1 (2:143)
        padding: EdgeInsets.fromLTRB(30 * fem, 84 * fem, 29 * fem, 89 * fem),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromARGB(246, 208, 200, 211),
          // borderRadius: BorderRadius.circular(50*fem),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              'assets/images/Login.png',
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: SizedBox(
                height: 40 * fem,
              ),
            ),
            Container(
              // welcomebackgladtoseeyouagainfs (2:181)
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 38 * fem, 43 * fem),
              constraints: BoxConstraints(
                maxWidth: 279 * fem,
              ),
              child: Text(
                'Welcome back! Glad to see you, Again!',
                style: SafeGoogleFont(
                  'Urbanist',
                  decoration: TextDecoration.none,
                  fontSize: 30 * ffem,
                  fontWeight: FontWeight.w700,
                  height: 1.3 * ffem / fem,
                  letterSpacing: -0.3 * fem,
                  color: Color(0xffe4edff),
                ),
              ),
            ),
            Container(
              // enteryouremailinputwZf (2:177)
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 23 * fem),
              width: double.infinity,
              decoration: BoxDecoration(
                
              ),
              child: Material(
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    
                    contentPadding: EdgeInsets.fromLTRB(
                        18 * fem, 18 * fem, 18 * fem, 19 * fem),
                    hintText: 'Enter your Email',
                    hintStyle: TextStyle(color: Color(0xff8390a1)),
                  ),
                  style: SafeGoogleFont(
                    'Urbanist',
                    decoration: TextDecoration.none,
                    fontSize: 15 * ffem,
                    fontWeight: FontWeight.w500,
                    height: 1.25 * ffem / fem,
                    color: Color.fromARGB(255, 251, 250, 250),
                  ),
                ),
              ),
            ),
            Container(
              // enteryourpasswordinputnaH (2:171)
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 22 * fem),
              width: double.infinity,
              decoration: BoxDecoration(
                
              ),
              child: Material(
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.fromLTRB(
                        18 * fem, 18 * fem, 18 * fem, 19 * fem),
                    hintText: 'Enter your password',
                    hintStyle: TextStyle(color: Color(0xff8390a1)),
                  ),
                  style: SafeGoogleFont(
                    'Urbanist',
                    decoration: TextDecoration.none,
                    fontSize: 15 * ffem,
                    fontWeight: FontWeight.w500,
                    height: 1.25 * ffem / fem,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ),
            Container(
              // forgotpasswordS93 (2:170)
              margin:
                  EdgeInsets.fromLTRB(221 * fem, 0 * fem, 0 * fem, 30 * fem),
              child: Text(
                'Forgot Password?',
                textAlign: TextAlign.right,
                style: SafeGoogleFont(
                  'Urbanist',
                  decoration: TextDecoration.none,
                  fontSize: 14 * ffem,
                  fontWeight: FontWeight.w600,
                  height: 1.2 * ffem / fem,
                  color: Color(0xffb4b4b4),
                ),
              ),
            ),
            Container(
              // loginbuttonwLh (2:167)
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 35 * fem),
              child: TextButton(
                onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(builder: (context) => S4()),
                          //   );
                  login();
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: Container(
                  width: double.infinity,
                  height: 56 * fem,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 0, 0, 0),
                    borderRadius: BorderRadius.circular(26 * fem),
                  ),
                  child: Center(
                    child: Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: SafeGoogleFont(
                        'Urbanist',
                        decoration: TextDecoration.none,
                        fontSize: 15 * ffem,
                        fontWeight: FontWeight.w600,
                        height: 1.2 * ffem / fem,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              // loginwithLtd (2:146)
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 62 * fem),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // loginwithUzq (2:163)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 0 * fem, 22 * fem),
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // line1q4h (2:165)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 2 * fem, 0 * fem, 0 * fem),
                          width: 112 * fem,
                          height: 1 * fem,
                          decoration: BoxDecoration(
                            color: Color(0xffe8ecf4),
                          ),
                        ),
                        SizedBox(
                          width: 12 * fem,
                        ),
                        Text(
                          // orloginwithMHw (2:164)
                          'Or Login with',
                          style: SafeGoogleFont(
                            'Urbanist',
                            decoration: TextDecoration.none,
                            fontSize: 14 * ffem,
                            fontWeight: FontWeight.w600,
                            height: 1.2 * ffem / fem,
                            color: Color(0xff6a707c),
                          ),
                        ),
                        SizedBox(
                          width: 12 * fem,
                        ),
                        Container(
                          // line2T65 (2:166)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 2 * fem, 0 * fem, 0 * fem),
                          width: 111 * fem,
                          height: 1 * fem,
                          decoration: BoxDecoration(
                            color: Color(0xffe8ecf4),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // autogroupgfmpawP (8w6CmeEs3kKzhKBq1BGFmP)
                    width: double.infinity,
                    height: 56 * fem,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // facebookbuttoniXo (2:155)
                          padding: EdgeInsets.fromLTRB(
                              44 * fem, 16 * fem, 49 * fem, 16 * fem),
                          height: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffe8ecf4)),
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(8 * fem),
                          ),
                          child: Center(
                            // facebookic3KB (2:157)
                            child: SizedBox(
                              width: 12 * fem,
                              height: 24 * fem,
                              child: Image.asset(
                                'assets/images/Login.png',
                                width: 12 * fem,
                                height: 24 * fem,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8 * fem,
                        ),
                        Container(
                          // googlebuttonhuX (2:147)
                          padding: EdgeInsets.fromLTRB(38.18 * fem, 16.18 * fem,
                              43.18 * fem, 16.18 * fem),
                          height: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffe8ecf4)),
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(8 * fem),
                          ),
                          child: Center(
                            // googleicpjF (2:149)
                            child: SizedBox(
                              width: 23.64 * fem,
                              height: 23.64 * fem,
                              child: Image.asset(
                                'assets/images/googleic.png',
                                width: 23.64 * fem,
                                height: 23.64 * fem,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8 * fem,
                        ),
                        Container(
                          // applebuttonYfF (2:159)
                          padding: EdgeInsets.fromLTRB(
                              39.43 * fem, 15 * fem, 44.45 * fem, 14.99 * fem),
                          height: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffe8ecf4)),
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(8 * fem),
                          ),
                          child: Center(
                            // cibapplefUy (2:161)
                            child: SizedBox(
                              width: 21.12 * fem,
                              height: 26.01 * fem,
                              child: Image.asset(
                                'assets/images/cib-apple.png',
                                width: 21.12 * fem,
                                height: 26.01 * fem,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // donthaveanaccountregisternowb7 (2:145)
              margin: EdgeInsets.fromLTRB(9 * fem, 0 * fem, 0 * fem, 0 * fem),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Registration()),
                  );
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: SafeGoogleFont(
                      'Poppins',
                      fontSize: 15 * ffem,
                      fontWeight: FontWeight.w600,
                      height: 1.4 * ffem / fem,
                      letterSpacing: 0.15 * fem,
                      color: Color(0xffffffff),
                    ),
                    children: [
                      TextSpan(
                        text: 'Don’t have an account? ',
                        style: SafeGoogleFont(
                          'Urbanist',
                          decoration: TextDecoration.none,
                          fontSize: 15 * ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.4 * ffem / fem,
                          letterSpacing: 0.15 * fem,
                          color: Color(0xffffffff),
                        ),
                      ),
                      TextSpan(
                        text: 'Register Now',
                        style: SafeGoogleFont(
                          'Urbanist',
                          decoration: TextDecoration.none,
                          fontSize: 15 * ffem,
                          fontWeight: FontWeight.w700,
                          height: 1.4 * ffem / fem,
                          letterSpacing: 0.15 * fem,
                          color: Color(0xff35c2c1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
