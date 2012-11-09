class Melange
  
  @host ?= location.hostname

  @init: ->
    return unless mixpanel?

    # Identify current user early
    mixpanel.people.identify(user) if user? 
    
  @log: ->
    if window.console
      console.log.apply console, arguments

  @report: (event_name, properties, callback) ->
    return unless mixpanel?
    if @debug
      @log(event_name, properties, callback)
    else
      mixpanel.track(event_name, properties, callback)

  # Convenience method for reporting page views.
  # 
  # Melange.reportView('/wibbles/123')
  @reportView: (path, properties) ->
    @report "viewed #{@host}#{path}", properties

window.Melange = Melange
