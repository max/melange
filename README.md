# Melange

A simple wrapper around the Mixpanel Javascript API. It tracks all page views by
default and identifies a user if `window.user` is set.

## Usage

```coffee
$ ->
  # Initilaize Melange
  Melange.init()

  # Start tracking events
  $(".button").click ->
    Melange.report "clicked", "some button"
```

It's recommended that you track events in the format of `action` `subject`. For
example:

* viewed homepage
* clicked button
* opened modal

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
    "/apps/{app}/collaborators"
    "/apps/{app}/settings"
    "/account"
    "/addons/{addon}:{plan}"
  ]

  # Remove trailing slashes
  pathname = location.pathname.replace(/\/$/, '')

  for pattern in patterns
    if pathname.match(new RegExp(pattern))
      Melange.reportView(pattern)
      break
    else
      meta = extractValues(pathname, pattern)
      if meta?
        Melange.reportView(pattern, meta)
        break
```
