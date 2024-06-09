part of 'play_pause_button.dart';

class _GenericButton extends StatelessWidget {
  const _GenericButton({
    required this.icon,
    required this.onPressed,
  });

  final Widget icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: IconButton.outlined(onPressed: onPressed, icon: icon),
    );
  }
}
