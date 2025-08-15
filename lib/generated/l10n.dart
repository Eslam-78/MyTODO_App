// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  String getTranslation(String key) {
    switch (key) {
      case 'badge_1_name':
        return badge_1_name;
      case 'badge_1_description':
        return badge_1_description;
      case 'badge_2_name':
        return badge_2_name;
      case 'badge_2_description':
        return badge_2_description;
      case 'badge_3_name':
        return badge_3_name;
      case 'badge_3_description':
        return badge_3_description;
      case 'badge_4_name':
        return badge_4_name;
      case 'badge_4_description':
        return badge_4_description;
      case 'badge_5_name':
        return badge_5_name;
      case 'badge_5_description':
        return badge_5_description;
      case 'badge_6_name':
        return badge_6_name;
      case 'badge_6_description':
        return badge_6_description;
      case 'badge_7_name':
        return badge_7_name;
      case 'badge_7_description':
        return badge_7_description;
      case 'badge_8_name':
        return badge_8_name;
      case 'badge_8_description':
        return badge_8_description;
      case 'badge_9_name':
        return badge_9_name;
      case 'badge_9_description':
        return badge_9_description;
      case 'badge_10_name':
        return badge_10_name;
      case 'badge_10_description':
        return badge_10_description;
      case 'badge_11_name':
        return badge_11_name;
      case 'badge_11_description':
        return badge_11_description;
      case 'badge_12_name':
        return badge_12_name;
      case 'badge_12_description':
        return badge_12_description;
      case 'badge_13_name':
        return badge_13_name;
      case 'badge_13_description':
        return badge_13_description;
      case 'badge_14_name':
        return badge_14_name;
      case 'badge_14_description':
        return badge_14_description;
      case 'badge_15_name':
        return badge_15_name;
      case 'badge_15_description':
        return badge_15_description;
      case 'badge_16_name':
        return badge_16_name;
      case 'badge_16_description':
        return badge_16_description;
      case 'badge_17_name':
        return badge_17_name;
      case 'badge_17_description':
        return badge_17_description;
      case 'badge_18_name':
        return badge_18_name;
      case 'badge_18_description':
        return badge_18_description;
      case 'badge_19_name':
        return badge_19_name;
      case 'badge_19_description':
        return badge_19_description;
      case 'badge_20_name':
        return badge_20_name;
      case 'badge_20_description':
        return badge_20_description;
      case 'badge_21_name':
        return badge_21_name;
      case 'badge_21_description':
        return badge_21_description;
      default:
        return key;
    }
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Light`
  String get lightTheme {
    return Intl.message('Light', name: 'lightTheme', desc: '', args: []);
  }

  /// `Dark`
  String get darkTheme {
    return Intl.message('Dark', name: 'darkTheme', desc: '', args: []);
  }

  /// `System`
  String get systemTheme {
    return Intl.message('System', name: 'systemTheme', desc: '', args: []);
  }

  /// `Home`
  String get homePage {
    return Intl.message('Home', name: 'homePage', desc: '', args: []);
  }

  /// `Nearby Tasks`
  String get nearbyTasks {
    return Intl.message(
      'Nearby Tasks',
      name: 'nearbyTasks',
      desc: '',
      args: [],
    );
  }

  /// `View All`
  String get viewAll {
    return Intl.message('View All', name: 'viewAll', desc: '', args: []);
  }

  /// `Search tasks...`
  String get searchTasks {
    return Intl.message(
      'Search tasks...',
      name: 'searchTasks',
      desc: '',
      args: [],
    );
  }

  /// `Current Tasks`
  String get currentTasks {
    return Intl.message(
      'Current Tasks',
      name: 'currentTasks',
      desc: '',
      args: [],
    );
  }

  /// `Good Morning`
  String get goodMorning {
    return Intl.message(
      'Good Morning',
      name: 'goodMorning',
      desc: '',
      args: [],
    );
  }

  /// `Good Evening`
  String get goodEvening {
    return Intl.message(
      'Good Evening',
      name: 'goodEvening',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completed {
    return Intl.message('Completed', name: 'completed', desc: '', args: []);
  }

  /// `Remaining`
  String get remaining {
    return Intl.message('Remaining', name: 'remaining', desc: '', args: []);
  }

  /// `Streak`
  String get streak {
    return Intl.message('Streak', name: 'streak', desc: '', args: []);
  }

  /// `Days`
  String get days {
    return Intl.message('Days', name: 'days', desc: '', args: []);
  }

  /// `Task marked as completed`
  String get turnChecked {
    return Intl.message(
      'Task marked as completed',
      name: 'turnChecked',
      desc: '',
      args: [],
    );
  }

  /// `Task marked as incomplete`
  String get turnUnchecked {
    return Intl.message(
      'Task marked as incomplete',
      name: 'turnUnchecked',
      desc: '',
      args: [],
    );
  }

  /// `Weekly Tasks`
  String get weeklyTasks {
    return Intl.message(
      'Weekly Tasks',
      name: 'weeklyTasks',
      desc: '',
      args: [],
    );
  }

  /// `This Week`
  String get thisWeekStats {
    return Intl.message('This Week', name: 'thisWeekStats', desc: '', args: []);
  }

  /// `Your Progress`
  String get yourProgress {
    return Intl.message(
      'Your Progress',
      name: 'yourProgress',
      desc: '',
      args: [],
    );
  }

  /// `Task Categories`
  String get taskCategories {
    return Intl.message(
      'Task Categories',
      name: 'taskCategories',
      desc: '',
      args: [],
    );
  }

  /// `Task Status`
  String get taskStatus {
    return Intl.message('Task Status', name: 'taskStatus', desc: '', args: []);
  }

  /// `Your Tasks`
  String get yourTasks {
    return Intl.message('Your Tasks', name: 'yourTasks', desc: '', args: []);
  }

  /// `Achievements`
  String get achievements {
    return Intl.message(
      'Achievements',
      name: 'achievements',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message('All', name: 'all', desc: '', args: []);
  }

  /// `Incomplete`
  String get incomplete {
    return Intl.message('Incomplete', name: 'incomplete', desc: '', args: []);
  }

  /// `No incomplete badges available`
  String get noIncompleteBadges {
    return Intl.message(
      'No incomplete badges available',
      name: 'noIncompleteBadges',
      desc: '',
      args: [],
    );
  }

  /// `Level`
  String get level {
    return Intl.message('Level', name: 'level', desc: '', args: []);
  }

  /// `Current Streak`
  String get currentStreak {
    return Intl.message(
      'Current Streak',
      name: 'currentStreak',
      desc: '',
      args: [],
    );
  }

  /// `Best Streak`
  String get bestStreak {
    return Intl.message('Best Streak', name: 'bestStreak', desc: '', args: []);
  }

  /// `Locked Badge`
  String get lockedBadge {
    return Intl.message(
      'Locked Badge',
      name: 'lockedBadge',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations! You earned this badge!\nWith XP:`
  String get congratsBadge {
    return Intl.message(
      'Congratulations! You earned this badge!\nWith XP:',
      name: 'congratsBadge',
      desc: '',
      args: [],
    );
  }

  /// `Complete requirements to unlock`
  String get unlockRequirement {
    return Intl.message(
      'Complete requirements to unlock',
      name: 'unlockRequirement',
      desc: '',
      args: [],
    );
  }

  /// `Unlock Requirements:`
  String get unlockConditions {
    return Intl.message(
      'Unlock Requirements:',
      name: 'unlockConditions',
      desc: '',
      args: [],
    );
  }

  /// `Required Level:`
  String get requiredLevel {
    return Intl.message(
      'Required Level:',
      name: 'requiredLevel',
      desc: '',
      args: [],
    );
  }

  /// `Okay`
  String get okay {
    return Intl.message('Okay', name: 'okay', desc: '', args: []);
  }

  /// `Complete tasks to unlock new achievements!`
  String get completeTasksPrompt {
    return Intl.message(
      'Complete tasks to unlock new achievements!',
      name: 'completeTasksPrompt',
      desc: '',
      args: [],
    );
  }

  /// `No achievements yet`
  String get noAchievements {
    return Intl.message(
      'No achievements yet',
      name: 'noAchievements',
      desc: '',
      args: [],
    );
  }

  /// `Opened`
  String get opened {
    return Intl.message('Opened', name: 'opened', desc: '', args: []);
  }

  /// `Closed`
  String get closed {
    return Intl.message('Closed', name: 'closed', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Arabic`
  String get arabic {
    return Intl.message('Arabic', name: 'arabic', desc: '', args: []);
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Profile Settings`
  String get profileSettings {
    return Intl.message(
      'Profile Settings',
      name: 'profileSettings',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Reminder Time`
  String get reminderTime {
    return Intl.message(
      'Reminder Time',
      name: 'reminderTime',
      desc: '',
      args: [],
    );
  }

  /// `App Settings`
  String get appSettings {
    return Intl.message(
      'App Settings',
      name: 'appSettings',
      desc: '',
      args: [],
    );
  }

  /// `Theme Mode`
  String get themeMode {
    return Intl.message('Theme Mode', name: 'themeMode', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Daily Reminders`
  String get dailyReminders {
    return Intl.message(
      'Daily Reminders',
      name: 'dailyReminders',
      desc: '',
      args: [],
    );
  }

  /// `App Information`
  String get appInfo {
    return Intl.message('App Information', name: 'appInfo', desc: '', args: []);
  }

  /// `Version`
  String get version {
    return Intl.message('Version', name: 'version', desc: '', args: []);
  }

  /// `Built with`
  String get builtWith {
    return Intl.message('Built with', name: 'builtWith', desc: '', args: []);
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Use`
  String get termsOfUse {
    return Intl.message('Terms of Use', name: 'termsOfUse', desc: '', args: []);
  }

  /// `Press to view`
  String get pressToView {
    return Intl.message(
      'Press to view',
      name: 'pressToView',
      desc: '',
      args: [],
    );
  }

  /// `Reset App`
  String get resetApp {
    return Intl.message('Reset App', name: 'resetApp', desc: '', args: []);
  }

  /// `Are you sure you want to reset all settings and data?`
  String get resetConfirmation {
    return Intl.message(
      'Are you sure you want to reset all settings and data?',
      name: 'resetConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Reset successfully completed`
  String get resetSuccess {
    return Intl.message(
      'Reset successfully completed',
      name: 'resetSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Focus Mode`
  String get focusMode {
    return Intl.message('Focus Mode', name: 'focusMode', desc: '', args: []);
  }

  /// `Focus Settings`
  String get focusSettings {
    return Intl.message(
      'Focus Settings',
      name: 'focusSettings',
      desc: '',
      args: [],
    );
  }

  /// `Focus Duration (minutes)`
  String get focusDuration {
    return Intl.message(
      'Focus Duration (minutes)',
      name: 'focusDuration',
      desc: '',
      args: [],
    );
  }

  /// `Short Break (minutes)`
  String get shortBreak {
    return Intl.message(
      'Short Break (minutes)',
      name: 'shortBreak',
      desc: '',
      args: [],
    );
  }

  /// `Long Break (minutes)`
  String get longBreak {
    return Intl.message(
      'Long Break (minutes)',
      name: 'longBreak',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `End Focus Mode`
  String get endFocusMode {
    return Intl.message(
      'End Focus Mode',
      name: 'endFocusMode',
      desc: '',
      args: [],
    );
  }

  /// `Completed Sessions`
  String get completedSessions {
    return Intl.message(
      'Completed Sessions',
      name: 'completedSessions',
      desc: '',
      args: [],
    );
  }

  /// `Total Sessions`
  String get totalSessions {
    return Intl.message(
      'Total Sessions',
      name: 'totalSessions',
      desc: '',
      args: [],
    );
  }

  /// `Minutes`
  String get minutes {
    return Intl.message('Minutes', name: 'minutes', desc: '', args: []);
  }

  /// `Ready To Start`
  String get startConfirm {
    return Intl.message(
      'Ready To Start',
      name: 'startConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Running Time`
  String get runTimeProgress {
    return Intl.message(
      'Running Time',
      name: 'runTimeProgress',
      desc: '',
      args: [],
    );
  }

  /// `Break Time`
  String get breakTimeProgress {
    return Intl.message(
      'Break Time',
      name: 'breakTimeProgress',
      desc: '',
      args: [],
    );
  }

  /// `Focus Duration:`
  String get focusDurationTime {
    return Intl.message(
      'Focus Duration:',
      name: 'focusDurationTime',
      desc: '',
      args: [],
    );
  }

  /// `Short Break`
  String get shortBreakTime {
    return Intl.message(
      'Short Break',
      name: 'shortBreakTime',
      desc: '',
      args: [],
    );
  }

  /// `Long Break`
  String get longBreakTime {
    return Intl.message(
      'Long Break',
      name: 'longBreakTime',
      desc: '',
      args: [],
    );
  }

  /// `Tasks Management`
  String get tasksManagement {
    return Intl.message(
      'Tasks Management',
      name: 'tasksManagement',
      desc: '',
      args: [],
    );
  }

  /// `Add New Task`
  String get addNewTask {
    return Intl.message('Add New Task', name: 'addNewTask', desc: '', args: []);
  }

  /// `Task Title`
  String get taskTitle {
    return Intl.message('Task Title', name: 'taskTitle', desc: '', args: []);
  }

  /// `Task Description (optional)`
  String get taskDescription {
    return Intl.message(
      'Task Description (optional)',
      name: 'taskDescription',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message('Add', name: 'add', desc: '', args: []);
  }

  /// `Update`
  String get update {
    return Intl.message('Update', name: 'update', desc: '', args: []);
  }

  /// `Task updated successfully`
  String get taskUpdated {
    return Intl.message(
      'Task updated successfully',
      name: 'taskUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Task added successfully`
  String get taskAdded {
    return Intl.message(
      'Task added successfully',
      name: 'taskAdded',
      desc: '',
      args: [],
    );
  }

  /// `No tasks found!`
  String get noTasksFound {
    return Intl.message(
      'No tasks found!',
      name: 'noTasksFound',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get pending {
    return Intl.message('Pending', name: 'pending', desc: '', args: []);
  }

  /// `Priority Level`
  String get priority {
    return Intl.message('Priority Level', name: 'priority', desc: '', args: []);
  }

  /// `Select Due Date`
  String get selectDueDate {
    return Intl.message(
      'Select Due Date',
      name: 'selectDueDate',
      desc: '',
      args: [],
    );
  }

  /// `Please select a due date`
  String get pleaseSelectDueDate {
    return Intl.message(
      'Please select a due date',
      name: 'pleaseSelectDueDate',
      desc: '',
      args: [],
    );
  }

  /// `Please select a priority level`
  String get pleaseSelectPriority {
    return Intl.message(
      'Please select a priority level',
      name: 'pleaseSelectPriority',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a task title`
  String get pleaseEnterTitle {
    return Intl.message(
      'Please enter a task title',
      name: 'pleaseEnterTitle',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message('Category', name: 'category', desc: '', args: []);
  }

  /// `Select Category`
  String get selectCategory {
    return Intl.message(
      'Select Category',
      name: 'selectCategory',
      desc: '',
      args: [],
    );
  }

  /// `Task Details`
  String get taskDetails {
    return Intl.message(
      'Task Details',
      name: 'taskDetails',
      desc: '',
      args: [],
    );
  }

  /// `Description:`
  String get description {
    return Intl.message(
      'Description:',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `In Progress`
  String get inProgress {
    return Intl.message('In Progress', name: 'inProgress', desc: '', args: []);
  }

  /// `Date Information:`
  String get dateInfo {
    return Intl.message(
      'Date Information:',
      name: 'dateInfo',
      desc: '',
      args: [],
    );
  }

  /// `Created Date:`
  String get createdDate {
    return Intl.message(
      'Created Date:',
      name: 'createdDate',
      desc: '',
      args: [],
    );
  }

  /// `Due Date:`
  String get dueDate {
    return Intl.message('Due Date:', name: 'dueDate', desc: '', args: []);
  }

  /// `Completed Date:`
  String get completedDate {
    return Intl.message(
      'Completed Date:',
      name: 'completedDate',
      desc: '',
      args: [],
    );
  }

  /// `Edit Task`
  String get editTask {
    return Intl.message('Edit Task', name: 'editTask', desc: '', args: []);
  }

  /// `Mark as Complete`
  String get markComplete {
    return Intl.message(
      'Mark as Complete',
      name: 'markComplete',
      desc: '',
      args: [],
    );
  }

  /// `Reopen`
  String get reopen {
    return Intl.message('Reopen', name: 'reopen', desc: '', args: []);
  }

  /// `Task reopened`
  String get taskReopened {
    return Intl.message(
      'Task reopened',
      name: 'taskReopened',
      desc: '',
      args: [],
    );
  }

  /// `Task completed successfully`
  String get taskCompleted {
    return Intl.message(
      'Task completed successfully',
      name: 'taskCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Delete Task`
  String get deleteTask {
    return Intl.message('Delete Task', name: 'deleteTask', desc: '', args: []);
  }

  /// `Are you sure you want to delete this task?`
  String get deleteConfirmation {
    return Intl.message(
      'Are you sure you want to delete this task?',
      name: 'deleteConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Task deleted successfully`
  String get taskDeleted {
    return Intl.message(
      'Task deleted successfully',
      name: 'taskDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Task`
  String get taskTitleLabel {
    return Intl.message('Task', name: 'taskTitleLabel', desc: '', args: []);
  }

  /// `Status`
  String get taskStatusLabel {
    return Intl.message('Status', name: 'taskStatusLabel', desc: '', args: []);
  }

  /// `Priority`
  String get taskPriorityLabel {
    return Intl.message(
      'Priority',
      name: 'taskPriorityLabel',
      desc: '',
      args: [],
    );
  }

  /// `Task Suggestions`
  String get taskSuggestions {
    return Intl.message(
      'Task Suggestions',
      name: 'taskSuggestions',
      desc: '',
      args: [],
    );
  }

  /// `No suggestions available for this task`
  String get noSuggestionsAvailable {
    return Intl.message(
      'No suggestions available for this task',
      name: 'noSuggestionsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Related Tasks`
  String get relatedTasks {
    return Intl.message(
      'Related Tasks',
      name: 'relatedTasks',
      desc: '',
      args: [],
    );
  }

  /// `Sub Tasks`
  String get subTasks {
    return Intl.message('Sub Tasks', name: 'subTasks', desc: '', args: []);
  }

  /// `Page Not Found`
  String get pageNotFound {
    return Intl.message(
      'Page Not Found',
      name: 'pageNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, the requested page could not be found.`
  String get pageNotFoundMessage {
    return Intl.message(
      'Sorry, the requested page could not be found.',
      name: 'pageNotFoundMessage',
      desc: '',
      args: [],
    );
  }

  /// `Go Back`
  String get goBack {
    return Intl.message('Go Back', name: 'goBack', desc: '', args: []);
  }

  /// `Home`
  String get navHome {
    return Intl.message('Home', name: 'navHome', desc: '', args: []);
  }

  /// `Trofies`
  String get navAchievments {
    return Intl.message('Trofies', name: 'navAchievments', desc: '', args: []);
  }

  /// `Focus Mode`
  String get navFocusMode {
    return Intl.message('Focus Mode', name: 'navFocusMode', desc: '', args: []);
  }

  /// `Settings`
  String get navSettings {
    return Intl.message('Settings', name: 'navSettings', desc: '', args: []);
  }

  /// `None`
  String get priorityNone {
    return Intl.message('None', name: 'priorityNone', desc: '', args: []);
  }

  /// `Low`
  String get priorityLow {
    return Intl.message('Low', name: 'priorityLow', desc: '', args: []);
  }

  /// `Medium`
  String get priorityMedium {
    return Intl.message('Medium', name: 'priorityMedium', desc: '', args: []);
  }

  /// `High`
  String get priorityHigh {
    return Intl.message('High', name: 'priorityHigh', desc: '', args: []);
  }

  /// `Urgent`
  String get priorityUrgent {
    return Intl.message('Urgent', name: 'priorityUrgent', desc: '', args: []);
  }

  /// `Repeat weekly on day`
  String get repeatWeeklyLabel {
    return Intl.message(
      'Repeat weekly on day',
      name: 'repeatWeeklyLabel',
      desc: 'Label for the recurring day dropdown',
      args: [],
    );
  }

  /// `Select repeat day (optional)`
  String get repeatHint {
    return Intl.message(
      'Select repeat day (optional)',
      name: 'repeatHint',
      desc: '',
      args: [],
    );
  }

  /// `Monday`
  String get monday {
    return Intl.message('Monday', name: 'monday', desc: '', args: []);
  }

  /// `Tuesday`
  String get tuesday {
    return Intl.message('Tuesday', name: 'tuesday', desc: '', args: []);
  }

  /// `Wednesday`
  String get wednesday {
    return Intl.message('Wednesday', name: 'wednesday', desc: '', args: []);
  }

  /// `Thursday`
  String get thursday {
    return Intl.message('Thursday', name: 'thursday', desc: '', args: []);
  }

  /// `Friday`
  String get friday {
    return Intl.message('Friday', name: 'friday', desc: '', args: []);
  }

  /// `Saturday`
  String get saturday {
    return Intl.message('Saturday', name: 'saturday', desc: '', args: []);
  }

  /// `Sunday`
  String get sunday {
    return Intl.message('Sunday', name: 'sunday', desc: '', args: []);
  }

  /// `The Beginning`
  String get badge_1_name {
    return Intl.message(
      'The Beginning',
      name: 'badge_1_name',
      desc: '',
      args: [],
    );
  }

  /// `Complete your first task`
  String get badge_1_description {
    return Intl.message(
      'Complete your first task',
      name: 'badge_1_description',
      desc: '',
      args: [],
    );
  }

  /// `Early Riser`
  String get badge_2_name {
    return Intl.message(
      'Early Riser',
      name: 'badge_2_name',
      desc: '',
      args: [],
    );
  }

  /// `Complete a task before 9 AM`
  String get badge_2_description {
    return Intl.message(
      'Complete a task before 9 AM',
      name: 'badge_2_description',
      desc: '',
      args: [],
    );
  }

  /// `Organizer`
  String get badge_3_name {
    return Intl.message('Organizer', name: 'badge_3_name', desc: '', args: []);
  }

  /// `Reach level 5 in the task app`
  String get badge_3_description {
    return Intl.message(
      'Reach level 5 in the task app',
      name: 'badge_3_description',
      desc: '',
      args: [],
    );
  }

  /// `Streak Starter`
  String get badge_4_name {
    return Intl.message(
      'Streak Starter',
      name: 'badge_4_name',
      desc: '',
      args: [],
    );
  }

  /// `Complete tasks two days in a row`
  String get badge_4_description {
    return Intl.message(
      'Complete tasks two days in a row',
      name: 'badge_4_description',
      desc: '',
      args: [],
    );
  }

  /// `Digital Cleaner`
  String get badge_5_name {
    return Intl.message(
      'Digital Cleaner',
      name: 'badge_5_name',
      desc: '',
      args: [],
    );
  }

  /// `Delete 3 old completed tasks`
  String get badge_5_description {
    return Intl.message(
      'Delete 3 old completed tasks',
      name: 'badge_5_description',
      desc: '',
      args: [],
    );
  }

  /// `Committed`
  String get badge_6_name {
    return Intl.message('Committed', name: 'badge_6_name', desc: '', args: []);
  }

  /// `Complete a task daily for 5 days`
  String get badge_6_description {
    return Intl.message(
      'Complete a task daily for 5 days',
      name: 'badge_6_description',
      desc: '',
      args: [],
    );
  }

  /// `All Done`
  String get badge_7_name {
    return Intl.message('All Done', name: 'badge_7_name', desc: '', args: []);
  }

  /// `Complete all your tasks in one day`
  String get badge_7_description {
    return Intl.message(
      'Complete all your tasks in one day',
      name: 'badge_7_description',
      desc: '',
      args: [],
    );
  }

  /// `Planner`
  String get badge_8_name {
    return Intl.message('Planner', name: 'badge_8_name', desc: '', args: []);
  }

  /// `Add 10 new tasks in a week`
  String get badge_8_description {
    return Intl.message(
      'Add 10 new tasks in a week',
      name: 'badge_8_description',
      desc: '',
      args: [],
    );
  }

  /// `Focused`
  String get badge_9_name {
    return Intl.message('Focused', name: 'badge_9_name', desc: '', args: []);
  }

  /// `Use focus mode 3 times`
  String get badge_9_description {
    return Intl.message(
      'Use focus mode 3 times',
      name: 'badge_9_description',
      desc: '',
      args: [],
    );
  }

  /// `Leader`
  String get badge_10_name {
    return Intl.message('Leader', name: 'badge_10_name', desc: '', args: []);
  }

  /// `Reach level 10 in the task app`
  String get badge_10_description {
    return Intl.message(
      'Reach level 10 in the task app',
      name: 'badge_10_description',
      desc: '',
      args: [],
    );
  }

  /// `Ten in a Day`
  String get badge_11_name {
    return Intl.message(
      'Ten in a Day',
      name: 'badge_11_name',
      desc: '',
      args: [],
    );
  }

  /// `Complete 10 tasks in one day`
  String get badge_11_description {
    return Intl.message(
      'Complete 10 tasks in one day',
      name: 'badge_11_description',
      desc: '',
      args: [],
    );
  }

  /// `No Breaks`
  String get badge_12_name {
    return Intl.message('No Breaks', name: 'badge_12_name', desc: '', args: []);
  }

  /// `Complete tasks for 7 consecutive days`
  String get badge_12_description {
    return Intl.message(
      'Complete tasks for 7 consecutive days',
      name: 'badge_12_description',
      desc: '',
      args: [],
    );
  }

  /// `Resilient`
  String get badge_13_name {
    return Intl.message('Resilient', name: 'badge_13_name', desc: '', args: []);
  }

  /// `Reach level 20 in the task app`
  String get badge_13_description {
    return Intl.message(
      'Reach level 20 in the task app',
      name: 'badge_13_description',
      desc: '',
      args: [],
    );
  }

  /// `The Flame`
  String get badge_14_name {
    return Intl.message('The Flame', name: 'badge_14_name', desc: '', args: []);
  }

  /// `Maintain a 14-day streak`
  String get badge_14_description {
    return Intl.message(
      'Maintain a 14-day streak',
      name: 'badge_14_description',
      desc: '',
      args: [],
    );
  }

  /// `Time Master`
  String get badge_15_name {
    return Intl.message(
      'Time Master',
      name: 'badge_15_name',
      desc: '',
      args: [],
    );
  }

  /// `Complete a task on time`
  String get badge_15_description {
    return Intl.message(
      'Complete a task on time',
      name: 'badge_15_description',
      desc: '',
      args: [],
    );
  }

  /// `The Master`
  String get badge_16_name {
    return Intl.message(
      'The Master',
      name: 'badge_16_name',
      desc: '',
      args: [],
    );
  }

  /// `Complete 100 tasks`
  String get badge_16_description {
    return Intl.message(
      'Complete 100 tasks',
      name: 'badge_16_description',
      desc: '',
      args: [],
    );
  }

  /// `Yearly Planner`
  String get badge_17_name {
    return Intl.message(
      'Yearly Planner',
      name: 'badge_17_name',
      desc: '',
      args: [],
    );
  }

  /// `Reach level 40 in the task app`
  String get badge_17_description {
    return Intl.message(
      'Reach level 40 in the task app',
      name: 'badge_17_description',
      desc: '',
      args: [],
    );
  }

  /// `Balanced`
  String get badge_18_name {
    return Intl.message('Balanced', name: 'badge_18_name', desc: '', args: []);
  }

  /// `Complete diverse tasks in one day`
  String get badge_18_description {
    return Intl.message(
      'Complete diverse tasks in one day',
      name: 'badge_18_description',
      desc: '',
      args: [],
    );
  }

  /// `The Legend`
  String get badge_19_name {
    return Intl.message(
      'The Legend',
      name: 'badge_19_name',
      desc: '',
      args: [],
    );
  }

  /// `Complete all your tasks 7 days in a row`
  String get badge_19_description {
    return Intl.message(
      'Complete all your tasks 7 days in a row',
      name: 'badge_19_description',
      desc: '',
      args: [],
    );
  }

  /// `Golden Legend`
  String get badge_20_name {
    return Intl.message(
      'Golden Legend',
      name: 'badge_20_name',
      desc: '',
      args: [],
    );
  }

  /// `Earn 10,000 XP`
  String get badge_20_description {
    return Intl.message(
      'Earn 10,000 XP',
      name: 'badge_20_description',
      desc: '',
      args: [],
    );
  }

  /// `Pro`
  String get badge_21_name {
    return Intl.message('Pro', name: 'badge_21_name', desc: '', args: []);
  }

  /// `Reach level 50 in the task app`
  String get badge_21_description {
    return Intl.message(
      'Reach level 50 in the task app',
      name: 'badge_21_description',
      desc: '',
      args: [],
    );
  }

  /// `Morning Suggestion`
  String get morning_suggestion_title {
    return Intl.message(
      'Morning Suggestion',
      name: 'morning_suggestion_title',
      desc: '',
      args: [],
    );
  }

  /// `You have {count} high priority tasks for this morning! 🌅`
  String morning_suggestion_body(int count) {
    return Intl.message(
      'You have $count high priority tasks for this morning! 🌅',
      name: 'morning_suggestion_body',
      desc: 'Notification showing count of high priority tasks',
      args: [count],
    );
  }

  /// `Smart Tracking`
  String get smart_tracking_title {
    return Intl.message(
      'Smart Tracking',
      name: 'smart_tracking_title',
      desc: '',
      args: [],
    );
  }

  /// `Reminder`
  String get reminder_title {
    return Intl.message('Reminder', name: 'reminder_title', desc: '', args: []);
  }

  /// `You can do better! Try focusing on one task 🚀`
  String get low_productivity_body {
    return Intl.message(
      'You can do better! Try focusing on one task 🚀',
      name: 'low_productivity_body',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations!`
  String get congrats_title {
    return Intl.message(
      'Congratulations!',
      name: 'congrats_title',
      desc: '',
      args: [],
    );
  }

  /// `Amazing! You've completed most of your tasks today! 🎉`
  String get high_productivity_body {
    return Intl.message(
      'Amazing! You\'ve completed most of your tasks today! 🎉',
      name: 'high_productivity_body',
      desc: '',
      args: [],
    );
  }

  /// `Alert`
  String get alert_title {
    return Intl.message('Alert', name: 'alert_title', desc: '', args: []);
  }

  /// `Attention! {count} tasks are due soon ⏰`
  String critical_tasks_body(int count) {
    return Intl.message(
      'Attention! $count tasks are due soon ⏰',
      name: 'critical_tasks_body',
      desc: 'Alert for critical tasks nearing deadline',
      args: [count],
    );
  }

  /// `Focus Mode`
  String get focus_mode_title {
    return Intl.message(
      'Focus Mode',
      name: 'focus_mode_title',
      desc: '',
      args: [],
    );
  }

  /// `Focus mode is active! Time to get things done 💪`
  String get focus_mode_active_body {
    return Intl.message(
      'Focus mode is active! Time to get things done 💪',
      name: 'focus_mode_active_body',
      desc: '',
      args: [],
    );
  }

  /// `You can activate focus mode to improve your productivity 📵`
  String get focus_suggestion_body {
    return Intl.message(
      'You can activate focus mode to improve your productivity 📵',
      name: 'focus_suggestion_body',
      desc: '',
      args: [],
    );
  }

  /// `Daily Recommendations`
  String get daily_recommendations_title {
    return Intl.message(
      'Daily Recommendations',
      name: 'daily_recommendations_title',
      desc: '',
      args: [],
    );
  }

  /// `Today is {dayName}. You have: {count} recurring tasks 🔄`
  String recurring_tasks_body(String dayName, int count) {
    return Intl.message(
      'Today is $dayName. You have: $count recurring tasks 🔄',
      name: 'recurring_tasks_body',
      desc: 'Notification for recurring tasks on specific day',
      args: [dayName, count],
    );
  }

  /// `Don't forget to add your recurring tasks for today! 📅`
  String get add_recurring_reminder {
    return Intl.message(
      'Don\'t forget to add your recurring tasks for today! 📅',
      name: 'add_recurring_reminder',
      desc: '',
      args: [],
    );
  }

  /// `No tasks yet! 🤔`
  String get no_tasks_body {
    return Intl.message(
      'No tasks yet! 🤔',
      name: 'no_tasks_body',
      desc: '',
      args: [],
    );
  }

  /// `Enable Notifications`
  String get activeNotification {
    return Intl.message(
      'Enable Notifications',
      name: 'activeNotification',
      desc: '',
      args: [],
    );
  }

  /// `Notifications {status} successfully`
  String notificationToggleSuccess(String status) {
    return Intl.message(
      'Notifications $status successfully',
      name: 'notificationToggleSuccess',
      desc: 'Confirmation message for notification status change',
      args: [status],
    );
  }

  /// `enabled`
  String get notificationEnabled {
    return Intl.message(
      'enabled',
      name: 'notificationEnabled',
      desc: '',
      args: [],
    );
  }

  /// `disabled`
  String get notificationDisabled {
    return Intl.message(
      'disabled',
      name: 'notificationDisabled',
      desc: '',
      args: [],
    );
  }

  /// `Notification Vibration`
  String get vibrationSettings {
    return Intl.message(
      'Notification Vibration',
      name: 'vibrationSettings',
      desc: '',
      args: [],
    );
  }

  /// `Notification vibration {status} successfully`
  String vibrationToggleSuccess(String status) {
    return Intl.message(
      'Notification vibration $status successfully',
      name: 'vibrationToggleSuccess',
      desc: 'Confirmation message for notification vibration change',
      args: [status],
    );
  }

  /// `enabled`
  String get vibrationEnabled {
    return Intl.message(
      'enabled',
      name: 'vibrationEnabled',
      desc: '',
      args: [],
    );
  }

  /// `disabled`
  String get vibrationDisabled {
    return Intl.message(
      'disabled',
      name: 'vibrationDisabled',
      desc: '',
      args: [],
    );
  }

  /// `Permission required to enable notifications`
  String get notificationPermissionWarning {
    return Intl.message(
      'Permission required to enable notifications',
      name: 'notificationPermissionWarning',
      desc: '',
      args: [],
    );
  }

  /// `Notification permission is required to receive alerts`
  String get grantNotificationAccessDescription {
    return Intl.message(
      'Notification permission is required to receive alerts',
      name: 'grantNotificationAccessDescription',
      desc: '',
      args: [],
    );
  }

  /// `Notification permission is required to use this feature`
  String get notificationPermissionRequired {
    return Intl.message(
      'Notification permission is required to use this feature',
      name: 'notificationPermissionRequired',
      desc: '',
      args: [],
    );
  }

  /// `🌙 Time to review your evening tasks at home!`
  String get geoHomeMessage {
    return Intl.message(
      '🌙 Time to review your evening tasks at home!',
      name: 'geoHomeMessage',
      desc: '',
      args: [],
    );
  }

  /// `🧑‍💻 Don’t forget to organize your work tasks now.`
  String get geoWorkMessage {
    return Intl.message(
      '🧑‍💻 Don’t forget to organize your work tasks now.',
      name: 'geoWorkMessage',
      desc: '',
      args: [],
    );
  }

  /// `🏋️‍♂️ Reminder for health and fitness tasks!`
  String get geoGymMessage {
    return Intl.message(
      '🏋️‍♂️ Reminder for health and fitness tasks!',
      name: 'geoGymMessage',
      desc: '',
      args: [],
    );
  }

  /// `Work`
  String get work {
    return Intl.message('Work', name: 'work', desc: '', args: []);
  }

  /// `Personal`
  String get personal {
    return Intl.message('Personal', name: 'personal', desc: '', args: []);
  }

  /// `Shopping`
  String get shopping {
    return Intl.message('Shopping', name: 'shopping', desc: '', args: []);
  }

  /// `Fitness`
  String get fitness {
    return Intl.message('Fitness', name: 'fitness', desc: '', args: []);
  }

  /// `Study`
  String get study {
    return Intl.message('Study', name: 'study', desc: '', args: []);
  }

  /// `Health`
  String get health {
    return Intl.message('Health', name: 'health', desc: '', args: []);
  }

  /// `Finance`
  String get finance {
    return Intl.message('Finance', name: 'finance', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
