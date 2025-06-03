import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController     = TextEditingController();
  final _emailController    = TextEditingController();
  final _phoneController    = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController  = TextEditingController();

  final AuthService _authService = AuthService();
  bool _isLoading = false;

  Future<void> _register() async {
    if (_formKey.currentState?.validate() != true) return;

    setState(() => _isLoading = true);

    final nombre     = _nameController.text.trim();
    final correo     = _emailController.text.trim();
    final telefono   = _phoneController.text.trim();
    final password   = _passwordController.text;
    final confirmar  = _confirmController.text;

    if (password != confirmar) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      setState(() => _isLoading = false);
      return;
    }

    try {
      // Llamamos a tu AuthService (que internamente hace createUser + guarda en Firestore)
      await _authService.registerUser(
        name: nombre,
        email: correo,
        phone: telefono,
        password: password,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario registrado correctamente')),
      );

      // Al terminar, voy a la pantalla de login (o a home si quieres)
      Navigator.pushReplacementNamed(context, 'login');

    } on FirebaseAuthException catch (e) {
      String mensaje = 'Error desconocido';
      if (e.code == 'email-already-in-use') {
        mensaje = 'El correo ya está en uso.';
      } else if (e.code == 'invalid-email') {
        mensaje = 'Correo inválido.';
      } else if (e.code == 'weak-password') {
        mensaje = 'La contraseña es muy débil.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(mensaje)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al registrar: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Colores según mockup anterior:
    const Color fondoPantalla = Color(0xFFF3E6FF);
    const Color campoBG       = Color(0xFFE8DEF8);
    const Color botonMorado   = Color(0xFF7B1FA2);
    const Color linkRosa      = Color(0xFFE91E63);

    return Scaffold(
      backgroundColor: fondoPantalla,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                // --- Logo (reemplaza con tu propia ruta de asset) ---
                Image.asset(
                  'assets/logo.png',
                  height: 120,
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 16),

                const Text(
                  'Registrarse',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 24),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Nombre completo
                      _buildTextField(
                        label: 'Nombre completo',
                        controller: _nameController,
                        background: campoBG,
                        validator: (v) =>
                        v == null || v.isEmpty ? 'Campo requerido' : null,
                      ),

                      // Correo electrónico
                      _buildTextField(
                        label: 'Correo electrónico',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        background: campoBG,
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Campo requerido';
                          if (!v.contains('@')) return 'Correo inválido';
                          return null;
                        },
                      ),

                      // Teléfono
                      _buildTextField(
                        label: 'Teléfono',
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        background: campoBG,
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Campo requerido';
                          if (v.length < 8) return 'Teléfono inválido';
                          return null;
                        },
                      ),

                      // Contraseña
                      _buildTextField(
                        label: 'Contraseña',
                        controller: _passwordController,
                        obscureText: true,
                        background: campoBG,
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Campo requerido';
                          if (v.length < 6) return 'Mínimo 6 caracteres';
                          return null;
                        },
                      ),

                      // Confirmar contraseña
                      _buildTextField(
                        label: 'Confirmar contraseña',
                        controller: _confirmController,
                        obscureText: true,
                        background: campoBG,
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Campo requerido';
                          if (v != _passwordController.text) return 'No coincide';
                          return null;
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Botón "Registrarse"
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: botonMorado,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                        : const Text(
                      'Registrarse',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // "Volver al inicio de sesión"
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'login');
                  },
                  child: const Text(
                    'Volver al inicio de sesión',
                    style: TextStyle(
                      fontSize: 14,
                      color: linkRosa,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    required Color background,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: background,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(30),
          ),
          labelStyle: const TextStyle(color: Colors.black54),
        ),
      ),
    );
  }
}
