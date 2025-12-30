import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'home_page.dart';
import 'profile_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedTab = 0;
  int _selectedNavIndex = 1; // ✅ Varsayılan: Add Expense sekmesi seçili

  Map<String, double> categories = {
    "Internet": 25,
    "Groceries": 20,
    "Shopping": 15,
    "Entertainment": 10,
  };

  double get totalExpenses =>
      categories.values.fold(0, (sum, item) => sum + item);

  final TextEditingController _amountController = TextEditingController();
  String? _selectedCategory;

  // 🔹 Alt Navigation yönlendirmeleri
  void _onBottomNavTapped(int index) {
    setState(() => _selectedNavIndex = index);

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } else if (index == 1) {
      // Add Expense sekmesindeyiz -> hiçbir işlem yapma
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ProfilePage()),
      );
    }
  }

  void _updateDataForTab(int index) {
    setState(() {
      _selectedTab = index;
      if (index == 0) {
        categories = {
          "Internet": 25,
          "Groceries": 20,
          "Shopping": 15,
          "Entertainment": 10,
        };
      } else if (index == 1) {
        categories = {
          "Internet": 80,
          "Groceries": 60,
          "Shopping": 30,
          "Entertainment": 15,
        };
      } else {
        categories = {
          "Internet": 200,
          "Groceries": 180,
          "Shopping": 100,
          "Entertainment": 60,
        };
      }
    });
  }

  void _showAddExpenseSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 20,
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Add Expense",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2F80ED),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Category", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Select category",
              ),
              items: const [
                DropdownMenuItem(value: "Internet", child: Text("Internet")),
                DropdownMenuItem(value: "Groceries", child: Text("Groceries")),
                DropdownMenuItem(value: "Shopping", child: Text("Shopping")),
                DropdownMenuItem(
                    value: "Entertainment", child: Text("Entertainment")),
              ],
              onChanged: (v) => _selectedCategory = v,
            ),
            const SizedBox(height: 16),
            const Text("Amount", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter amount",
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            // ✅ SAVE BUTTON
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2F80ED),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
              ),
              onPressed: () {
                final category = _selectedCategory;
                final amount = double.tryParse(_amountController.text);

                if (category != null && amount != null) {
                  setState(() {
                    categories[category] =
                        (categories[category] ?? 0) + amount;
                  });
                  Navigator.pop(context);
                  _amountController.clear();
                }
              },
              child: const Text(
                "Save",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 160,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF2F80ED),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 🔹 Geri tuşu eklendi
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const HomePage()),
                          );
                        },
                        child: const Icon(Icons.arrow_back_ios,
                            color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Add an Expenses",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ⚪ Beyaz Gövde
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _TabsUnderline(
                      selected: _selectedTab,
                      onChanged: _updateDataForTab,
                    ),
                    const SizedBox(height: 50),

                    _TotalCard(amount: totalExpenses),
                    const SizedBox(height: 25),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 160,
                          width: 160,
                          child: PieChart(
                            PieChartData(
                              sectionsSpace: 0,
                              centerSpaceRadius: 0,
                              sections: categories.entries.map((e) {
                                return PieChartSectionData(
                                  color: _catColor(e.key),
                                  value: e.value,
                                  title: '',
                                  radius: 70,
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 40),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: categories.entries.map((e) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                child: Row(
                                  children: [
                                    Icon(Icons.circle,
                                        size: 12, color: _catColor(e.key)),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        "${e.key}: \$${e.value.toStringAsFixed(2)}",
                                        style: const TextStyle(fontSize: 15),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        _CategoryIcon(
                            icon: Icons.wifi,
                            label: "Internet",
                            color: Colors.blue),
                        _CategoryIcon(
                            icon: Icons.shopping_cart,
                            label: "Shopping",
                            color: Colors.orange),
                        _CategoryIcon(
                            icon: Icons.water_drop,
                            label: "Water",
                            color: Colors.lightBlue),
                        _CategoryIcon(
                            icon: Icons.tv,
                            label: "Entera",
                            color: Colors.green),
                      ],
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 10),
        child: FloatingActionButton(
          backgroundColor: const Color(0xFF2F80ED),
          onPressed: _showAddExpenseSheet,
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedNavIndex,
        onTap: _onBottomNavTapped,
        selectedItemColor: const Color(0xFF2F80ED),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline), label: "Add Expense"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "Account"),
        ],
      ),
    );
  }

  Color _catColor(String k) {
    switch (k) {
      case "Internet":
        return Colors.blue;
      case "Groceries":
        return Colors.green;
      case "Shopping":
        return Colors.orange;
      case "Entertainment":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

// 🔹 Sekmeler
class _TabsUnderline extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onChanged;
  const _TabsUnderline({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    Widget tab(String t, int i) {
      final bool isSel = selected == i;
      return GestureDetector(
        onTap: () => onChanged(i),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              t,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isSel
                    ? const Color(0xFF2F80ED)
                    : Colors.grey.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 3,
              width: isSel ? 50 : 0,
              color: const Color(0xFF2F80ED),
            ),
          ],
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        tab('Daily', 0),
        const SizedBox(width: 25),
        tab('Weekly', 1),
        const SizedBox(width: 25),
        tab('Monthly', 2),
      ],
    );
  }
}

// 🔷 Total Expenses Kartı
class _TotalCard extends StatelessWidget {
  final double amount;
  const _TotalCard({required this.amount});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 22),
        decoration: BoxDecoration(
          color: const Color(0xFF2F80ED),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Total Expenses",
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "\$${amount.toStringAsFixed(2)}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 🔘 Alt ikon bileşeni
class _CategoryIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _CategoryIcon(
      {required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: color.withOpacity(0.12),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 13)),
      ],
    );
  }
}
