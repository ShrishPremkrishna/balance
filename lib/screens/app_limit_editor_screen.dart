import 'package:flutter/material.dart';
import '../models/app_limit.dart';
import '../models/app_intervention.dart';
import '../theme/app_theme.dart';
import '../widgets/number_input.dart';

class AppLimitEditorScreen extends StatefulWidget {
  final AppLimit appLimit;
  final Function(AppLimit) onSave;
  final Function(int)? onNavigationChanged;

  const AppLimitEditorScreen({
    super.key,
    required this.appLimit,
    required this.onSave,
    this.onNavigationChanged,
  });

  @override
  State<AppLimitEditorScreen> createState() => _AppLimitEditorScreenState();
}

class _AppLimitEditorScreenState extends State<AppLimitEditorScreen> {
  late AppLimit _editedLimit;
  final int _selectedIndex = 2; // Goals tab index

  @override
  void initState() {
    super.initState();
    _editedLimit = widget.appLimit;
  }

  void _updateLimit(AppLimit Function(AppLimit) update) {
    setState(() {
      _editedLimit = update(_editedLimit);
      // Update the total time limit whenever maxOpensPerDay or maxDurationPerOpen changes
      final totalMinutes = _editedLimit.maxOpensPerDay * _editedLimit.maxDurationPerOpen;
      _editedLimit = _editedLimit.copyWith(
        timeLimit: Duration(minutes: totalMinutes),
      );
    });
    widget.onSave(_editedLimit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App-Specific Limits'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildAppHeader(),
            _buildUsageParameters(),
            _buildInterventionSettings(),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          if (index != _selectedIndex && widget.onNavigationChanged != null) {
            widget.onNavigationChanged!(index);
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart),
            label: 'Stats',
          ),
          NavigationDestination(
            icon: Icon(Icons.track_changes),
            label: 'Goals',
          ),
        ],
      ),
    );
  }

  Widget _buildAppHeader() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.apps,
                color: AppTheme.primaryGreen,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _editedLimit.appName,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'Total limit: ${_formatDuration(_editedLimit.timeLimit)}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppTheme.textLight.withOpacity(0.7),
                        ),
                  ),
                ],
              ),
            ),
            Switch(
              value: _editedLimit.isEnabled,
              onChanged: (value) {
                _updateLimit((limit) => limit.copyWith(isEnabled: value));
              },
              activeColor: AppTheme.primaryGreen,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUsageParameters() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Usage Parameters',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            NumberInput(
              label: 'Opens',
              value: _editedLimit.maxOpensPerDay,
              onChanged: (value) {
                _updateLimit((limit) => limit.copyWith(maxOpensPerDay: value));
              },
              suffix: 'times per day',
            ),
            const SizedBox(height: 16),
            NumberInput(
              label: 'Duration',
              value: _editedLimit.maxDurationPerOpen,
              onChanged: (value) {
                _updateLimit((limit) => limit.copyWith(maxDurationPerOpen: value));
              },
              suffix: 'minutes per open',
            ),
            const SizedBox(height: 16),
            NumberInput(
              label: 'Pause',
              value: _editedLimit.minPauseDuration,
              onChanged: (value) {
                _updateLimit((limit) => limit.copyWith(minPauseDuration: value));
              },
              suffix: 'minutes between opens',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInterventionSettings() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Intervention Settings',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Type:',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButton<InterventionType>(
                    value: _editedLimit.intervention.type,
                    isExpanded: true,
                    onChanged: (value) {
                      if (value != null) {
                        _updateLimit((limit) => limit.copyWith(
                            intervention:
                                limit.intervention.copyWith(type: value)));
                      }
                    },
                    items: InterventionType.values.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(_formatInterventionType(type)),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Unlock odds:',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButton<UnlockProbability>(
                    value: _editedLimit.intervention.probability,
                    isExpanded: true,
                    onChanged: (value) {
                      if (value != null) {
                        _updateLimit((limit) => limit.copyWith(
                            intervention: limit.intervention
                                .copyWith(probability: value)));
                      }
                    },
                    items: [
                      UnlockProbability.always,
                      const UnlockProbability(1, 2),
                      const UnlockProbability(1, 3),
                      const UnlockProbability(1, 5),
                      const UnlockProbability(1, 7),
                      const UnlockProbability(1, 10),
                      UnlockProbability.never,
                    ].map((prob) {
                      return DropdownMenuItem(
                        value: prob,
                        child: Text(prob.toString()),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    if (hours > 0) {
      return '$hours hour${hours == 1 ? '' : 's'} ${minutes > 0 ? '$minutes minute${minutes == 1 ? '' : 's'}' : ''}';
    } else {
      return '$minutes minute${minutes == 1 ? '' : 's'}';
    }
  }

  String _formatInterventionType(InterventionType type) {
    switch (type) {
      case InterventionType.none:
        return 'None';
      case InterventionType.mathProblem:
        return 'Math Problem';
      case InterventionType.meditation:
        return 'Meditation';
      case InterventionType.stepCounter:
        return 'Step Counter';
    }
  }
} 