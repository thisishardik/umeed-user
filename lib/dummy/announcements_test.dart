import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:umeed_user_app/providers/announcements_provider.dart';

class AnnouncementsTestScreen extends StatefulWidget {
  @override
  _AnnouncementsTestScreenState createState() =>
      _AnnouncementsTestScreenState();
}

class _AnnouncementsTestScreenState extends State<AnnouncementsTestScreen> {
  SlidableController slidableController;
  Animation<double> _rotationAnimation;
  Color _fabColor = Colors.blue;

  void handleSlideAnimationChanged(Animation<double> slideAnimation) {
    setState(() {
      _rotationAnimation = slideAnimation;
    });
  }

  void handleSlideIsOpenChanged(bool isOpen) {
    setState(() {
      _fabColor = isOpen ? Colors.green : Colors.blue;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<AnnouncementsProvider>(context, listen: false)
        .getAnnouncements();
  }

  @override
  void initState() {
    slidableController = SlidableController(
      onSlideAnimationChanged: handleSlideAnimationChanged,
      onSlideIsOpenChanged: handleSlideIsOpenChanged,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final announcements =
        Provider.of<AnnouncementsProvider>(context).announcements;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Announcements",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Slidable.builder(
            key: Key(announcements[index].title),
            controller: slidableController,
            dismissal: SlidableDismissal(
              child: SlidableDrawerDismissal(),
              closeOnCanceled: true,
              onDismissed: (actionType) {
                _showSnackBar(
                  context,
                  'Deleted',
                );
                setState(() {
                  announcements.removeAt(index);
                });
              },
            ),
            actionPane: _getActionPane(index),
            actionExtentRatio: 0.25,
            child: GestureDetector(
              onTap: () => Slidable.of(context)?.renderingMode ==
                      SlidableRenderingMode.none
                  ? Slidable.of(context)?.open()
                  : Slidable.of(context)?.close(),
              child: Container(
                color: Colors.white,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      'assets/images/ann1.jpg',
                      height: 50.0,
                    ),
                  ),
                  title: Text(
                    announcements[index].title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    announcements[index].announcement.toString().length >= 45
                        ? announcements[index]
                                .announcement
                                .toString()
                                .substring(0, 45) +
                            " ..."
                        : announcements[index].announcement,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            secondaryActionDelegate: SlideActionBuilderDelegate(
                actionCount: 1,
                builder: (context, index, animation, renderingMode) {
                  return IconSlideAction(
                    caption: 'Delete',
                    color: renderingMode == SlidableRenderingMode.slide
                        ? Colors.red.withOpacity(animation.value)
                        : Colors.red,
                    icon: Icons.delete,
                    onTap: () => _showSnackBar(context, 'Delete'),
                  );
                }),
          );
        },
        itemCount: 1,
      ),
    );
  }

  static Widget _getActionPane(int index) {
    switch (index % 4) {
      case 0:
        return SlidableBehindActionPane();
      case 1:
        return SlidableStrechActionPane();
      case 2:
        return SlidableScrollActionPane();
      case 3:
        return SlidableDrawerActionPane();
      default:
        return null;
    }
  }

  void _showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
