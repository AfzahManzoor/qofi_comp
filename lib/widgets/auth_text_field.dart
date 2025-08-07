class _AuthTextField extends StatelessWidget {
  _AuthTextField({required this.e});
  final Map e;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    InputBorder outlineInputBorder = e['border'] == "none"
        ? const OutlineInputBorder(borderSide: BorderSide.none)
        : OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.sp),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
            ),
          );

    if (e['type'] == "dropdown") {
      final dropdownItems = (e['items'] ?? []) as List;
      final dropdownValue = e['value'];

      return DropdownButtonFormField(
        value: dropdownValue != "" ? dropdownValue : null,
        items: dropdownItems.map<DropdownMenuItem>((item) {
          return DropdownMenuItem(
            value: "${item['id']}",
            child: Text(
              "${item['name']}",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Theme.of(context).canvasColor,
              ),
            ),
          );
        }).toList(),
        onChanged: (val) {
          e['onChanged']?.call(val);
        },
        validator: e['validator'],
        style: e['style'] as TextStyle?,
        icon: SvgPicture.asset(
          "assets/svgs/arrow-down.svg",
          color: Theme.of(context).dividerColor,
        ),
        isDense: true,
        dropdownColor: Theme.of(context).cardColor,
        decoration: InputDecoration(
          errorMaxLines: 2,
          errorText: e['error']?.toString().trs(context),
          hintText: e['hint']?.toString().trs(context),
          filled: e['filled'] ?? true,
          fillColor: Theme.of(context).cardColor,
          hintStyle: TextStyle(
            color: HexColor("#b0aeae"),
            fontSize: 14.ft,
            fontWeight: FontWeight.w500,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.7.h),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.sp),
            borderSide: const BorderSide(color: Color(0xffD6D6D6)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.sp),
            borderSide: const BorderSide(color: Color(0xffD6D6D6)),
          ),
          errorBorder: outlineInputBorder,
          focusedErrorBorder: outlineInputBorder,
        ),
      );
    }

    // Other input types...
    return TextFormField(
      controller: e['controller'],
      onChanged: (value) => e['onChanged']?.call(value),
      validator: e['validator'],
      // rest of your TextFormField logic here
    );
  }
}
