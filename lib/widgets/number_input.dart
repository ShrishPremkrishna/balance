import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';

class NumberInput extends StatefulWidget {
  final String label;
  final int value;
  final int minValue;
  final int maxValue;
  final Function(int) onChanged;
  final String? suffix;

  const NumberInput({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.minValue = 0,
    this.maxValue = 999,
    this.suffix,
  });

  @override
  State<NumberInput> createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value.toString());
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _validateAndUpdate();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(NumberInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _controller.text = widget.value.toString();
    }
  }

  void _validateAndUpdate() {
    final text = _controller.text;
    if (text.isEmpty) {
      _controller.text = widget.minValue.toString();
      widget.onChanged(widget.minValue);
      return;
    }

    final value = int.tryParse(text) ?? widget.minValue;
    final clampedValue = value.clamp(widget.minValue, widget.maxValue);
    
    if (value != clampedValue) {
      _controller.text = clampedValue.toString();
    }
    
    widget.onChanged(clampedValue);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Label
          SizedBox(
            width: 80,
            child: Text(
              widget.label,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          // Number input field
          SizedBox(
            width: 60,
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppTheme.textLight.withOpacity(0.2),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppTheme.textLight.withOpacity(0.2),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppTheme.primaryGreen,
                  ),
                ),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3),
              ],
              onSubmitted: (value) => _validateAndUpdate(),
            ),
          ),
          // Suffix
          if (widget.suffix != null) ...[
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                widget.suffix!,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ],
      ),
    );
  }
} 