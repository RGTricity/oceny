# For more information see: http://emberjs.com/guides/routing/

App.Router.map ()->
  @resource 'attendees'
  @resource 'attendee', path: '/attendees/:id'
  @route 'results', path: '/results'
  @resource 'forms', () ->
    @route('new')

App.IndexRoute = Ember.Route.extend
  beforeModel: () ->
    @transitionTo('attendees');