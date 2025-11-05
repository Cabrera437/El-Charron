import 'package:flutter/material.dart';

// 🔹 Importaciones de tus pantallas
import 'package:el_charron/screens/IniciarSesion.dart';
import 'package:el_charron/screens/MenuPantalla.dart';
import 'package:el_charron/screens/CrearProducto.dart' as crear;
import 'package:el_charron/screens/AnadirProducto.dart';
import 'package:el_charron/screens/CrearSesion.dart';
import 'package:el_charron/screens/CrearGasto.dart';
import 'package:el_charron/screens/NuevoGasto.dart';

// ✅ Nueva pantalla Balance
import 'package:el_charron/screens/BalanceScreen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'El Charron',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/iniciarSesion': (context) => const IniciarSesion(),
        '/menu': (context) => const MenuPantalla(),
        '/crearProducto': (context) => const crear.CrearProducto(),
        '/añadirProducto': (context) => const AnadirProducto(),
        '/crearGasto': (context) => const CrearGasto(),
        '/nuevoGasto': (context) => const NuevoGasto(),
        '/balance': (context) => const BalanceScreen(), 
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
    );
  }
}

//
// 🔹 Pantalla de bienvenida (sin cambios grandes)
//
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // LOGO
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Image.asset(
                  'assets/ElCharron_inicio.jpg',
                  height: size.height * 0.50,
                  fit: BoxFit.contain,
                ),
              ),

              // CONTENEDOR BLANCO INFERIOR
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 100),
                child: Column(
                  children: [
                    const Text(
                      'Bienvenido a El Charron',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),

                    // BOTÓN "INICIAR"
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CrearSesion()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding:
                              const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Iniciar',
                          style:
                              TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // BOTÓN "YA TENGO UNA CUENTA"
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const IniciarSesion()),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          padding:
                              const EdgeInsets.symmetric(vertical: 14),
                          side: const BorderSide(
                              color: Colors.black, width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Ya tengo una cuenta',
                          style: TextStyle(
                              fontSize: 16, color: Colors.black),
                        ),
                      ),
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

//
// 🔹 Pantallas adicionales de inicio y login (sin cambios)
//
class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar')),
      body: const Center(
        child: Text('Pantalla de inicio de registro o menú'),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar sesión')),
      body: const Center(
        child: Text('Pantalla de login'),
      ),
    );
  }



}
