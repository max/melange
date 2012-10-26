class Melange
  @init: ->
    return unless mixpanel?

    # Identify current user early
    mixpanel.people.identify(user) if user? 

  @reportView: (subject, meta) ->
    @report("viewed", [location.hostname,subject].join(""), meta)

  @report: (action, subject, meta = {}) ->
    return unless mixpanel?

    console.log "Melange: #{action} #{subject}" if window.console
    mixpanel.track("#{action} #{subject}", meta)

window.Melange = Melange
