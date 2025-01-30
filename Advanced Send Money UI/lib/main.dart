import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(WalletApp());

// Custom Text Field
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  const CustomTextField({
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white54),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        errorStyle: TextStyle(color: Colors.amber),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.amber),
        ),
      ),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
    );
  }
}

// Payment Method Dropdown
class PaymentMethodDropdown extends StatelessWidget {
  final List<PaymentMethod> items;
  final String? value;
  final ValueChanged<String?> onChanged;

  const PaymentMethodDropdown({
    required this.items,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(Icons.payment, color: Colors.white54),
      ),
      dropdownColor: Theme.of(context).colorScheme.surface,
      style: TextStyle(color: Colors.white),
      icon: Icon(Icons.arrow_drop_down, color: Colors.white54),
      items: items.map((method) {
        return DropdownMenuItem<String>(
          value: method.name,
          child: Row(
            children: [
              Icon(method.icon, color: Colors.white54),
              SizedBox(width: 12),
              Text(method.name, style: TextStyle(color: Colors.white)),
            ],
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}

// Favorite Switch
class FavoriteSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const FavoriteSwitch({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Add to Favorites',
            style: Theme.of(context).textTheme.bodyMedium),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Theme.of(context).colorScheme.primary,
          activeTrackColor: Theme.of(context).colorScheme.primary.withOpacity(0.4),
        ),
      ],
    );
  }
}

// Primary Button
class PrimaryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const PrimaryButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// Animated Success Message
class AnimatedSuccessMessage extends StatelessWidget {
  final bool visible;

  const AnimatedSuccessMessage({required this.visible});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500),
      child: Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.9),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Transaction Completed Successfully!',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WalletApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: SendMoneyScreen(),
      onGenerateRoute: (settings) {
        if (settings.name == '/dashboard') {
          return PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 800),
            pageBuilder: (_, __, ___) => DashboardScreen(),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(0.5, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              );
            },
          );
        }
        return null;
      },
    );
  }
}

class AppTheme {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xFF1A1A2E),
    colorScheme: ColorScheme.dark(
      primary: Color(0xFFE94560),
      secondary: Color(0xFF8B8B9A),
      surface: Color(0xFF16213E),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFF16213E),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: Colors.white70,
      ),
    ),
  );
}

class SendMoneyScreen extends StatefulWidget {
  @override
  _SendMoneyScreenState createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  String? _selectedMethod = 'Credit Card';
  bool _isFavorite = false;
  bool _showSuccess = false;
  double _buttonScale = 1.0;

  final List<PaymentMethod> _paymentMethods = [
    PaymentMethod('Credit Card', Icons.credit_card),
    PaymentMethod('PayPal', Icons.payment),
    PaymentMethod('Bank Transfer', Icons.account_balance),
    PaymentMethod('Crypto', Icons.currency_bitcoin),
  ];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _showSuccess = true;
        _buttonScale = 1.0;
      });
      Future.delayed(Duration(seconds: 2), () {
        if (mounted) {
          setState(() => _showSuccess = false);
          Navigator.pushNamed(context, '/dashboard');
        }
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppHeader(title: 'Send Money'),
              SizedBox(height: 32),
              TransactionForm(
                formKey: _formKey,
                nameController: _nameController,
                amountController: _amountController,
                paymentMethods: _paymentMethods,
                selectedMethod: _selectedMethod,
                onMethodChanged: (value) => setState(() => _selectedMethod = value),
                isFavorite: _isFavorite,
                onFavoriteChanged: (value) => setState(() => _isFavorite = value),
              ),
              SizedBox(height: 40),
              AnimatedScale(
                scale: _buttonScale,
                duration: Duration(milliseconds: 200),
                child: GestureDetector(
                  onTapDown: (_) => setState(() => _buttonScale = 0.95),
                  onTapUp: (_) => setState(() => _buttonScale = 1.0),
                  child: PrimaryButton(
                    label: 'Transfer Now',
                    icon: Icons.send_rounded,
                    onPressed: _submitForm,
                  ),
                ),
              ),
              AnimatedSuccessMessage(visible: _showSuccess),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom Widgets
class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1A1A2E),
            Color(0xFF16213E),
            Color(0xFF0F3460),
          ],
        ),
      ),
      child: child,
    );
  }
}

class AppHeader extends StatelessWidget {
  final String title;

  const AppHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 48.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              shadows: [
                Shadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(2, 2),
                )
              ],
            ),
      ),
    );
  }
}

class TransactionForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController amountController;
  final List<PaymentMethod> paymentMethods;
  final String? selectedMethod;
  final ValueChanged<String?> onMethodChanged;
  final bool isFavorite;
  final ValueChanged<bool> onFavoriteChanged;

  const TransactionForm({
    required this.formKey,
    required this.nameController,
    required this.amountController,
    required this.paymentMethods,
    required this.selectedMethod,
    required this.onMethodChanged,
    required this.isFavorite,
    required this.onFavoriteChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: nameController,
            label: 'Recipient Name',
            icon: Icons.person_outline_rounded,
            validator: (value) => value!.isEmpty ? 'Please enter recipient name' : null,
          ),
          SizedBox(height: 20),
          CustomTextField(
            controller: amountController,
            label: 'Amount',
            icon: Icons.attach_money_rounded,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            validator: (value) {
              if (value!.isEmpty) return 'Please enter amount';
              if (double.tryParse(value) == null) return 'Invalid amount';
              if (double.parse(value) <= 0) return 'Amount must be positive';
              return null;
            },
          ),
          SizedBox(height: 20),
          PaymentMethodDropdown(
            items: paymentMethods,
            value: selectedMethod,
            onChanged: onMethodChanged,
          ),
          SizedBox(height: 24),
          FavoriteSwitch(
            value: isFavorite,
            onChanged: onFavoriteChanged,
          ),
        ],
      ),
    );
  }
}

// Implement other custom widgets (PaymentMethodDropdown, FavoriteSwitch, 
// PrimaryButton, AnimatedSuccessMessage) following similar patterns
// with consistent styling and animation features

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Center(
          child: Text(
            'Dashboard',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }
}

class PaymentMethod {
  final String name;
  final IconData icon;

  PaymentMethod(this.name, this.icon);
}