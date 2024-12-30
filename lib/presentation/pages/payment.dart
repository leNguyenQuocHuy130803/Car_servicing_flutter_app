import 'package:car_servicing/presentation/pages/track_order/confir.dart';
import 'package:car_servicing/presentation/pages/checkout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/service_cart_provider.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentPage> {
  String? selectedPaymentMethod = "pay_after";

  @override
  Widget build(BuildContext context) {
        final cartProvider = Provider.of<ServiceCartProvider>(context);  //  Sử dụng Provider để lấy dữ liệu từ ServiceCartProvider (giỏ hàng dịch vụ).
    final totalPrice = cartProvider.cartItems.entries // Tính toán tổng giá trị giỏ hàng, nhân giá của mỗi dịch vụ với số lượng và cộng lại.
        .map((entry) => entry.key.price * entry.value)
    // key: đối tượng dịch vụ (Service).
    // value: số lượng dịch vụ đó trong giỏ hàng (int).
        .reduce((value, element) => value + element);
    final serviceTitles = cartProvider.cartItems.keys  // serviceTitles: Lấy tên các dịch vụ từ giỏ hàng và nối lại thành chuỗi để hiển thị
        .map((service) => service.title)
        .join(', '); // sẽ nối tất cả các tên dịch vụ lại thành một chuỗi, với dấu phẩy (,) phân cách giữa các tên dịch vụ.

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => CheckoutScreen()),
                    (Route<dynamic> route) => false,
                  )
                }),
      ),
      body: Container(
        color: Colors.grey[100],
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAmountRow('Service Total', '2.499.000 VND'),
                _buildAmountRow('Convenience Charges', '100.000 VND'),
                _buildAmountRow(
                  'Service Amount Payable',
                  '2.599.000 VND',
                  isBold: true,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Apply Coupon',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Coupon Code',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('APPLY'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        backgroundColor: Colors.blue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildAmountRow('Amount Payable', '2.599.000 VND'),
                const SizedBox(height: 20),
                const Text(
                  'Pay Using',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                _buildPaymentOption(
                  'paytm',
                  'Pay via PayTM',
                  'assets/images/pay_tm.png',
                ),
                _buildPaymentOption(
                  'gpay',
                  'Pay via Google Pay',
                  'assets/images/google_pay.png',
                ),
                _buildPaymentOption(
                  'card',
                  'Pay via Debit/Credit Card',
                  'assets/images/card.png',
                ),
                _buildPaymentOption(
                  'pay_after',
                  'Pay after the service',
                  'assets/images/pay_after.png',
                ),
                const SizedBox(height: 100),
                // Extra space at the bottom to avoid overflow
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$serviceTitles\n${(totalPrice).toStringAsFixed(2)} VND',
              // totalPrice: Đây là tổng chi phí của tất cả các dịch vụ trong giỏ hàng, được tính ở dòng trước đó.
      //     toStringAsFixed(2):
      //     Hàm này chuyển đổi giá trị totalPrice thành chuỗi, đồng thời giữ đúng 2 chữ số thập phân.
      // Ví dụ: Nếu totalPrice là 2599000, kết quả sẽ là "2599000.00".
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ConfirmationScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text(
                'PAY',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountRow(String title, String amount, {bool isBold = false}) { // truyền các tham số vào, nó sẽ trả về một hàng chứa tiêu đề và số tiền, căn chỉnh đúng vị trí.
    // title: Chuỗi văn bản để hiển thị tiêu đề, ví dụ: "Service Total".
    // amount: Chuỗi văn bản để hiển thị số tiền, ví dụ: "2.499.000 VND".
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildPaymentOption(String value, String title, String iconPath) {
    return RadioListTile(
      value: value,
      groupValue: selectedPaymentMethod,
      onChanged: (String? newValue) {
        setState(() {
          selectedPaymentMethod = newValue;
        });
      },
      title: Text(title),
      secondary: Image.asset(
        iconPath,
        width: 24,
        height: 24,
      ),
    );
  }
}
