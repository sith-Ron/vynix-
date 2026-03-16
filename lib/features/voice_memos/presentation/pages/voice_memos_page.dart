import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:vynix/features/voice_memos/presentation/providers/voice_memos_provider.dart';
import 'package:vynix/shared/widgets/adaptive/adaptive_section_scaffold.dart';
import 'package:vynix/shared/widgets/aether_glass_card.dart';

class VoiceMemosPage extends ConsumerStatefulWidget {
  const VoiceMemosPage({super.key});

  @override
  ConsumerState<VoiceMemosPage> createState() => _VoiceMemosPageState();
}

class _VoiceMemosPageState extends ConsumerState<VoiceMemosPage> {
  final SpeechToText _speech = SpeechToText();
  bool _listening = false;
  String _liveTranscript = '';

  Future<void> _toggleListening() async {
    if (_listening) {
      await _speech.stop();
      setState(() => _listening = false);
      if (_liveTranscript.trim().isNotEmpty) {
        ref
            .read(voiceMemosControllerProvider.notifier)
            .addMemo(_liveTranscript);
        setState(() => _liveTranscript = '');
      }
      return;
    }

    final available = await _speech.initialize(
      onStatus: (status) {
        if (status == 'done' || status == 'notListening') {
          if (mounted) {
            setState(() => _listening = false);
          }
        }
      },
    );
    if (!available) {
      return;
    }

    setState(() => _listening = true);
    await _speech.listen(
      onResult: (SpeechRecognitionResult result) {
        if (!mounted) {
          return;
        }
        setState(() => _liveTranscript = result.recognizedWords);
      },
      listenOptions: SpeechListenOptions(partialResults: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    final memos = ref.watch(voiceMemosControllerProvider);

    return AdaptiveSectionScaffold(
      title: 'Voice Memos',
      trailing: IconButton(
        onPressed: _toggleListening,
        icon: Icon(
          _listening
              ? CupertinoIcons.stop_circle_fill
              : CupertinoIcons.mic_fill,
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            sliver: SliverToBoxAdapter(
              child: VynixGlassCard(
                child: Text(
                  _listening
                      ? (_liveTranscript.isEmpty
                            ? 'Listening... speak now.'
                            : _liveTranscript)
                      : 'Tap mic to start a voice memo transcription.',
                ),
              ),
            ),
          ),
          if (memos.isEmpty)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(child: Text('No voice memos yet.')),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              sliver: SliverList.builder(
                itemCount: memos.length,
                itemBuilder: (context, index) {
                  final memo = memos[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: VynixGlassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat.yMMMd().add_jm().format(memo.createdAt),
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          const SizedBox(height: 6),
                          Text(memo.transcript),
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              onPressed: () => ref
                                  .read(voiceMemosControllerProvider.notifier)
                                  .remove(memo.id),
                              icon: const Icon(CupertinoIcons.delete),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
