import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mockito_dating_app/ui/utils/colors.dart';
import 'package:mockito_dating_app/ui/utils/responsive.dart';
import 'package:mockito_dating_app/ui/utils/font_styles.dart';

class FilesPage extends StatefulWidget {
  final ValueChanged<PlatformFile> onOpenedFile;
  final List<PlatformFile> files;

  const FilesPage({
    Key? key,
    required this.files,
    required this.onOpenedFile,
  }) : super(key: key);

  @override
  State<FilesPage> createState() => _FilesPageState();
}

class _FilesPageState extends State<FilesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: GridView.builder(
          itemCount: widget.files.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            final file = widget.files[index];
            return buildFile(file);
          },
        ),
      ),
    );
  }

  Widget buildFile(PlatformFile file) {
    final responsive = Responsive.of(context);
    final wp = responsive.wp(100);
    final hp = responsive.hp(100);
    final kb = file.size / 1024;
    final mb = kb / 1024;
    const color = primColor;
    final extension = file.extension ?? 'Sin Archivos';
    final fileSize =
        mb >= 1 ? '${mb.toStringAsFixed(2)} MB' : '${kb.toStringAsFixed(2)} KB';

    return InkWell(
      onTap: () => OpenFile.open(file.path),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: wp,
              height: hp,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: color,
              ),
              child: Text(
                style: MyFontStyles.subtitleColor,
                extension,
              ),
            ),
          ),
          Text(
            style: MyFontStyles.subSubtitle,
            overflow: TextOverflow.ellipsis,
            file.name,
          ),
          Text(
            style: MyFontStyles.normal,
            fileSize,
          ),
        ],
      ),
    );
  }
}
