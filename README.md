# Melange

Melange is a simple wrapper around the [Mixpanel Javascript
API](https://mixpanel.com/docs/integration-libraries/javascript-full-api).

## Usage

```coffee
$ ->
  # Initilaize Melange
  Melange.init()

  # Start tracking events
  $(".element").click ->
    Melange.report "clicked", "some element"

  # You can also attach meta data to your events
  $(".element").click ->
    Melange.report "clicked", "some element", { "a key": "a value" }
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


Development
-----------

Use coffee to watch and compile:

```bash
coffee -wc *.coffee
```

License
-------

MIT. Go Nuts.
