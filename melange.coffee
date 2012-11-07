class Melange
  
  @host ?= location.hostname

  @init: ->
    return unless mixpanel?

    # Identify current user early
    mixpanel.people.identify(user) if user? 
    
  @log: ->
    if window.console
      console.log.apply console, arguments

  @report: (action, subject, meta = {}) ->
    return unless mixpanel?

    if @debug
      @log "Melange.report", action, subject, meta
    else
      mixpanel.track("#{action} #{subject}", meta)
    
  @reportView: (subject, meta) ->
    @report("viewed", [@host,subject].join(""), meta)


window.Melange = Melange
