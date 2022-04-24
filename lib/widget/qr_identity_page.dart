import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../model/mpc_model.dart';
import '../util/qr_coder.dart';

class QrIdentityPage extends StatelessWidget {
  const QrIdentityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Material(
          color: Theme.of(context).colorScheme.surface,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: const [
                    BackButton(),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Consumer<MpcModel>(builder: (context, model, child) {
                    return QrImage(
                      padding: const EdgeInsets.all(24),
                      foregroundColor: Theme.of(context).colorScheme.onSurface,
                      data: QrCoder().encode(model.thisDevice),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
