import 'package:flutter/material.dart';

/*
How to Use

  SnackBarMsg snackMsg = SnackBarMsg();
  -snackMsg.showSnackBarMsg(response.data['message'], this.context);
  -snackMsg.showSnackBarMsg(response.data['message'], context);
*/

class SnackBarMsg {
  //=========================================================
  showSnackBarMsg(msg, context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.info, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '$msg',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
