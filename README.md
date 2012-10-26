# Melange

A simple wrapper around the Mixpanel Javascript API. It tracks all page views by
default and identifies a user if `window.user` is set.

Custom actions are submitted in the format of `action` `subject`. For example:

* viewed homepage
* clicked button
* opened modal

```coffee
$(".button").click ->
  Melange.report "clicked", "some button"
```

If you want to track page views in aggregate try something like this:

```coffee
$ ->
  # Mixpanel tracking via Melange
  Melange.init()

  # Track page views in aggregates
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
