$ ->
  class Melange
    @init: ->
      return unless mixpanel?

      # Identify current user early
      mixpanel.people.identify(user) if user? 

      # Track all page views by default
      Melange.report("viewed", [location.hostname,location.pathname].join(""))

    @report: (action, subject) ->
      return unless mixpanel?

      console.log "Melange: #{action} #{subject}" if window.console
      mixpanel.track("#{action} #{subject}")

  window.Melange = Melange
  Melange.init()

  # Individual reports
  # Melange.report "clicked", "some button"
