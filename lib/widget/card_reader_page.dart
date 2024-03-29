import 'package:flutter/material.dart' hide Card;

import '../card/card.dart';
import '../card/jobs.dart';

class CardReaderPage<T> extends StatefulWidget {
  final CardJob<T> job;

  const CardReaderPage({Key? key, required this.job}) : super(key: key);

  @override
  State<CardReaderPage> createState() => _CardReaderPageState();
}

abstract class ReaderStatus {
  final String message;
  const ReaderStatus._(this.message);
}

class ReaderOkStatus extends ReaderStatus {
  const ReaderOkStatus._(String message) : super._(message);
  static const waiting = ReaderOkStatus._('Hold a card near the reader');
  static const working = ReaderOkStatus._('Do not remove the card');
}

class ReaderErrStatus extends ReaderStatus {
  const ReaderErrStatus._(String message) : super._(message);
  static const noReader = ReaderErrStatus._('No reader available');
  static const initError = ReaderErrStatus._('Cannot connect to card manager');
}

class _CardReaderPageState<T> extends State<CardReaderPage<T>> {
  final _manager = CardManager();
  ReaderStatus _status = ReaderOkStatus.waiting;

  bool get _hasError => _status is ReaderErrStatus;

  void setStatus(ReaderStatus status) => setState(() {
        _status = status;
      });

  @override
  void initState() {
    super.initState();
    _initManager();
  }

  @override
  void dispose() {
    _manager.disconnect();
    super.dispose();
  }

  Future<void> _initManager() async {
    try {
      await _manager.connect();
    } on Exception {
      setStatus(ReaderErrStatus.initError);
    }

    _poll();
  }

  void _poll() async {
    // TODO: wait for reader instead
    try {
      if ((await _manager.readers).isEmpty) throw Exception();
    } on Exception {
      setStatus(ReaderErrStatus.noReader);
      return;
    }

    try {
      final cards = await _manager.poll();
      // TODO: let the user pick one?
      final card = cards[0];
      setStatus(ReaderOkStatus.working);

      try {
        final result = await widget.job.work(card);
        Navigator.pop(context, result);
      } finally {
        await card.disconnect();
        setStatus(ReaderOkStatus.waiting);
      }
    } catch (e) {
      /* FIXME: make sure not to end up in a busy loop */
      if (!mounted) return;
      _showError();
      _poll();
    }
  }

  void _showError({String message = 'Failed to read card'}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

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
              // TODO: this can overflow
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Material(
                    elevation: 2,
                    shape: const CircleBorder(),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        SizedBox.square(
                          dimension: 140,
                          child: CircularProgressIndicator(
                            value: _status == ReaderOkStatus.working ? null : 0,
                          ),
                        ),
                        Icon(
                          Icons.contactless,
                          size: 100,
                          color: _hasError
                              ? Theme.of(context).colorScheme.error
                              : Theme.of(context).colorScheme.secondary,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      _status.message,
                      style: Theme.of(context).textTheme.subtitle1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddCardPage extends StatelessWidget {
  const AddCardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CardReaderPage(job: AddCardJob());
  }
}
