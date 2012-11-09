class Melange
  
  @host ?= location.hostname

  @config =
    debug: false
    preventBubbling: false

  @init: (options={}) ->    
    return unless mixpanel?

    # Identify current user early
    mixpanel.people.identify(user) if user? 
    
    # Configuration
    @config.debug = options.debug if options.debug?
    @config.preventBubbling = options.preventBubbling if options.preventBubbling?
    
    @setupEventHandlers()
    
  @log: ->
    if window.console
      console.log.apply console, arguments

  @report: (event_name, properties, callback) ->
    return unless mixpanel?
    if @config.debug
      @log(event_name, properties, callback)
    else
      mixpanel.track(event_name, properties, callback)

  # Convenience method for reporting page views.
  # 
  # Melange.reportView('/wibbles/123')
  @reportView: (path, properties) ->
    @report "viewed #{@host}#{path}", properties

  # Set up event detection on all elements that have a `data-trigger` attribute.
  @setupEventHandlers: ->
    
    event_types = [
      'blur', 'change', 'click', 'dblclick', 'focus', 'keydown', 'keypress', 'keyup', 
      'load', 'mousedown', 'mouseenter', 'mouseleave', 'mousemove', 'mouseout', 
      'mouseover', 'mouseup', 'resize', 'scroll', 'select',  'submit', 'unload'
    ]

    for event_type in event_types
      $("[data-trigger=#{event_type}]").on event_type, ->
        properties = $(this).data()
        event_name = properties.event_name

        return unless event_name?
        
        delete properties.trigger
        delete properties.event_name
        
        # For inputs, add the current value of the input to the properties
        if $(this)[0] && $(this)[0].nodeName && $(this)[0].nodeName.toLowerCase() is "input"
          properties.input_value = $(this).val()

        Melange.report(event_name, properties)
        return false if Melange.config.preventBubbling

window.Melange = Melange
