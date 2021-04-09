import 'package:datcao/resources/styles/colors.dart';
import 'package:datcao/resources/styles/images.dart';
import 'package:datcao/share/import.dart';
import 'package:datcao/share/widget/base_widgets.dart';

import 'create_page_page.dart';

class PagesPage extends StatefulWidget {
  static Future navigate() {
    return navigatorKey.currentState.push(pageBuilder(PagesPage()));
  }

  @override
  _PagesPageState createState() => _PagesPageState();
}

class _PagesPageState extends State<PagesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar1(
        bgColor: ptSecondaryColor(context),
        title: 'Trang',
        textColor: AppColors.mainColor,
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildPageBodySection('Trang của bạn', AppImages.icOwnPage, [
              _itemBodySectionOwnPage(AppImages.imageDemo, 'Dự án MeiLand ', 2)
            ]),
            _buildPageBodySection(
                'Trang đã theo dõi ', AppImages.icPageFollow, [
              _itemBodySectionPageFollow(AppImages.imageDemo, 'Dự án MeiLand ')
            ]),
            _buildPageBodySection(
                'Lời mời thích trang ', AppImages.icPageLike, [
              _itemBodySectionPageLike(AppImages.imageDemo, 'Dự án MeiLand ')
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() => Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 31, vertical: 18),
        child: _itemIconButtonTitle(AppImages.icCreatePage, 'Tạo trang mới', 41,
            action: () => CreatePagePage.navigate()),
      );

  Widget _itemIconButtonTitle(String image, String title, double iconSize,
          {VoidCallback action}) =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: action,
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Center(
                  child: SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image.asset(
                      image,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
            ),
          ),
          widthSpace(15),
          Container(
            child: Text(
              title,
              style: ptBigTitle().copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        ],
      );

  Widget _buildPageBodySection(String title, String icon, List<Widget> body) =>
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: _itemIconButtonTitle(icon, title, 32),
            ),
            heightSpace(10),
            Column(
              children: body,
            )
          ],
        ),
      );

  Widget _itemBodySectionOwnPage(
    String image,
    String title,
    int number,
  ) =>
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              spreadRadius: 40,
              blurRadius: 40.0,
              offset: Offset(0, 10),
              color: Color.fromRGBO(0, 0, 0, 0.03),
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Center(
                  child: SizedBox(
                    width: 45,
                    height: 45,
                    child: Image.asset(
                      image,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
            ),
            widthSpace(13),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    title,
                    style: ptBigBody().copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                heightSpace(7),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: new BoxDecoration(
                          color: AppColors.notifyColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      widthSpace(8),
                      Text(
                        number.toString() + ' mục mới',
                        style: ptSmall(),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      );

  Widget _itemBodySectionPageFollow(
    String image,
    String title,
  ) =>
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              spreadRadius: 40,
              blurRadius: 40.0,
              offset: Offset(0, 10),
              color: Color.fromRGBO(0, 0, 0, 0.03),
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Center(
                  child: SizedBox(
                    width: 45,
                    height: 45,
                    child: Image.asset(
                      image,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
            ),
            widthSpace(13),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    title,
                    style: ptBigBody().copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                heightSpace(7),
                _itemButton('Đã theo dõi', isApprove: true, icon: Icons.check)
              ],
            )
          ],
        ),
      );

  Widget _itemBodySectionPageLike(
    String image,
    String title,
  ) =>
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              spreadRadius: 40,
              blurRadius: 40.0,
              offset: Offset(0, 10),
              color: Color.fromRGBO(0, 0, 0, 0.03),
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Center(
                  child: SizedBox(
                    width: 45,
                    height: 45,
                    child: Image.asset(
                      image,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
            ),
            widthSpace(13),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    title,
                    style: ptBigBody().copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                heightSpace(7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _itemButton('Đã theo dõi',
                        isApprove: true, icon: Icons.check),
                    widthSpace(10),
                    _itemButton('Từ chối', isApprove: false),
                  ],
                )
              ],
            )
          ],
        ),
      );

  Widget _itemButton(String text, {bool isApprove = false, IconData icon}) =>
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: isApprove ? AppColors.buttonApprove : AppColors.buttonCancel,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            isApprove
                ? Container(
                    child: Icon(
                    icon,
                    size: 14,
                    color: AppColors.mainColor,
                  ))
                : const SizedBox(),
            widthSpace(8),
            Text(
              text,
              style: ptSmall().copyWith(color: AppColors.mainColor),
            )
          ],
        ),
      );
}