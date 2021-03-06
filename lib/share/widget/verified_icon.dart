import 'package:datcao/share/import.dart';
import 'package:datcao/share/widget/custom_tooltip.dart';

class VerifiedIcon extends StatelessWidget {
  final String role;
  final double size;
  final bool isPage;
  const VerifiedIcon(this.role, this.size, {this.isPage = false});

  @override
  Widget build(BuildContext context) {
    String image;
    String message;
    if (role == 'AGENT') {
      image = 'agent';
      message = 'Nhà môi giới';
    }
    if (role == 'COMPANY') {
      image = 'company';
      message = 'Tài khoản công ty';
    }

    if (image == null || message == null) return SizedBox.shrink();

    return Align(
      alignment: Alignment.bottomRight,
      child: CustomTooltip(
        message: isPage ? "Trang" : message,
        child: Container(
          width: size + 10,
          height: size + 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          padding: EdgeInsets.all(2),
          child: Center(
            child: Container(
              width: size + 6,
              height: size + 6,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: ptPrimaryColor(context)),
              padding: EdgeInsets.all(3),
              child: SizedBox(
                  width: size,
                  height: size,
                  child: isPage
                      ? Image.asset('assets/image/ic_page.png')
                      : Image.asset('assets/image/$image.png')),
            ),
          ),
        ),
      ),
    );
  }
}
