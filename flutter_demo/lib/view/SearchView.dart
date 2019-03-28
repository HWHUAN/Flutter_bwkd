import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/utils/functions.dart';
class SearchView extends StatefulWidget{

  final double height;
  final double elevation; //阴影
  final String hintText;
  final FocusNode focusNode;
  final TextEditingController controller;
  final IconData prefixIcon;
  final List<TextInputFormatter> inputFormatters;
  final VoidCallback onEditingComplete;
  final OnChangedCallback onChangedCallback;

  const SearchView(
      {Key key,
        this.height: 46.0,
        this.elevation: 0.5,
        this.hintText: '请输入关键词',
        this.focusNode,
        this.controller,
        this.inputFormatters,
        this.onEditingComplete,
        this.onChangedCallback,
        this.prefixIcon: Icons.search})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new SearchViewState();
  }

}

class SearchViewState extends State<SearchView>{
  bool _hasdeleteIcon = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 40.0,
      child: new TextField(
          focusNode: widget.focusNode,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          controller: widget.controller,
          maxLines: 1,
          inputFormatters: widget.inputFormatters,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: Color(0xFF999999),
              fontSize: 16.0,
            ),
            prefixIcon: Padding(
                padding: EdgeInsetsDirectional.only(start: 10.0),
                child: Icon(
                  widget.prefixIcon,
                  color: Colors.black,
                )),
            suffixIcon: Padding(
                padding: EdgeInsetsDirectional.only(
                    start: 2.0, end: _hasdeleteIcon ? 20.0 : 0),
                child: _hasdeleteIcon
                    ? new InkWell(
                    onTap: (() {
                      setState(() {
                        widget.controller.text = '';
                        _hasdeleteIcon = false;
                        if (null != widget.onChangedCallback) {
                          widget.onChangedCallback();
                        }
                      });
                    }),
                    child: Icon(
                      Icons.clear,
                      size: 18.0,
                      color: Colors.black,
                    ))
                    : new Text('')),
            contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            filled: true,
            fillColor: Color.fromARGB(150, 235, 235, 235),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                color: Color(0xFFCCCCCC),
              )
            ),

          ),
          onChanged: (str) {
            if (null != widget.onChangedCallback) {
              widget.onChangedCallback();
            }

            setState(() {
              if (str.isEmpty) {
                _hasdeleteIcon = false;
              } else {
                _hasdeleteIcon = true;
              }
            });
          },
          onEditingComplete: widget.onEditingComplete
      ),
    );

  }

}