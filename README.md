# Melange

Melange is a simple wrapper around the [Mixpanel Javascript
API](https://mixpanel.com/docs/integration-libraries/javascript-full-api).
It mimics the Mixpanel API in most respects, but adds some helpful features 
like automatic tracking of pageviews and event tracking based on data attributes 
you set on your DOM elements.

Melange currently has a dependency on jQuery, which it uses for DOM selectors, 
defining event handlers, and handling of data attributes.

## Usage

```coffee
$ ->

  Melange.init()

  $(".element").click ->
    Melange.report "clicked some element"

  # You can also attach metadata to your events
  $(".element").click ->
    Melange.report "clicked some element", { sweetness: 10 }
```

Usage Tips
----------

Set `Melange.debug = true` to see events logged in 
the console instead of sending them to mixpanel.

Sometimes you want to test a link click event, but your browser
redirects to the link before you have a chance to see the results 
logged in the console. To get around this, you can temporarily prevent the 
event from bubbling by returning false, like so:

```coffee
$("a").click ->
  Melange.report "clicked", "some link"
  false
```

It's recommended that you track events in the format of `action` (in past tense)
`subject`. For example:

* viewed homepage
* clicked button
* opened modal

If you would like to track page views in aggregate try something like this
(requires [extractValues](https://github.com/laktek/extract-values)):

```coffee
$ ->

  Melange.init()

  # Pages to track (with or without patterns)
  patterns = [
    "/apps"
    "/apps/{app}/resources"
    "/apps/{app}/activity"
    "/addons/{addon}:{plan}"
  ]

  # Remove trailing slashes
  pathname = location.pathname.replace(/\/$/, "")

  for pattern in patterns
    if pathname.match(new RegExp("#{pattern}$"))
      Melange.reportView(pattern)
      break
    else
      meta = extractValues(pathname, pattern)
      if meta?
        Melange.reportView(pattern, meta)
        break
```

Sometimes you want to report data that's been changed by the user after page load.
When you attach events to `input` elements in the DOM, their value
will automatically be included in the properties object with a key of `input_value`.

Development
-----------

Use coffee to watch and compile:

```bash
coffee -wc *.coffee
```

License
-------

MIT. Go Nuts.
