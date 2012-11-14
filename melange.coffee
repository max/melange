class Melange
  
  @host ?= location.hostname

  @config =
    logToConsole: false
    preventBubbling: false

  @init: (options={}) ->    
    return unless mixpanel?
    
    # Configuration
    @config.logToConsole = options.logToConsole if options.logToConsole
    @config.preventBubbling = options.preventBubbling if options.preventBubbling
    
    mixpanel.identify(options.user) if options.user
    
    @attachEventHandlers()
    
  @log: ->
    if window.console
      console.log.apply console, arguments

  @report: (event_name, properties, callback) ->
    return unless mixpanel?
    return unless event_name? && event_name.length > 0
    
    if @config.logToConsole
      @log(event_name, properties, callback)

    mixpanel.track(event_name, properties, callback)
    
  # Convenience method for reporting page views.
  # 
  # Melange.reportView('/wibbles/123')
  @reportView: (path, properties) ->
    @report "viewed #{@host}#{path}", properties

  # Detect events on elements that have a `data-melange_trigger` attribute.
  @attachEventHandlers: ->
    
    event_types = [
      'blur', 'change', 'click', 'dblclick', 'focus', 'keydown', 'keyup', 
      'mousedown', 'mouseenter', 'mouseleave', 'mouseout', 'mouseover', 'mouseup'
    ]
    
    # Skip these events, because they're unneeded or too resource-intensive.
    # ['keypress', 'mousemove', 'load', 'resize', 'scroll', 'select', 'submit', 'unload']

    for event_type in event_types
        
      $("[data-melange_trigger='#{event_type}']").on event_type, (event) ->
        
        # Yank melange event info from the elemement's data attributes
        properties = {}
        for key, value of $(this).data() when key.match(/melange_/i)
          properties[key.replace('melange_', '')] = value
        
        event_name = properties.event_name
      
        # Remove redundant properties
        delete properties.trigger
        delete properties.event_name
      
        # If element is a text input, add its current value to properties
        if $(this)[0] && $(this)[0].nodeName.match(/input/i)
          properties.input_value = $(this).val()
        
          # Bail if input is empty
          return if properties.input_value is ""

        Melange.report(event_name, properties)
      
        return false if Melange.config.preventBubbling

window.Melange = Melange
