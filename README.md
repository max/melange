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
    Melange.report "click", "some element"

  # You can also attach meta data to your events
  $(".element").click ->
    Melange.report "click", "some element", { "a key": "a value" }
```

It's recommended that you track events in the format of `action` `subject`. For
example:

* view homepage
* click button
* open modal

If you would like to track page views in aggregate try something like this
(requires [extractValues](https://github.com/zeke/extract-values)):

```coffee
$ ->
  # Initialize Melange
  Melange.init()

  # Define pages to track (with or without patterns)
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
