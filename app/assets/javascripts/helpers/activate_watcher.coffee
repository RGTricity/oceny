Ember.Helper.helper 'activateWatcher', (submission) =>
  window.watcher.stop()
  window.watcher.run(submission)
  null