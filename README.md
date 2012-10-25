# Melange

Melange is a simple wrapper around the 
[Mixpanel Javascript API](https://mixpanel.com/docs/integration-libraries/javascript-full-api).
It tracks all page views by default and identifies a user if `window.user` is set.

Custom actions are submitted in the format of `action` `subject`. For example:

* viewed homepage
* clicked button
* opened modal

```coffeescript
$(".button").click ->
  Melange.report "clicked", "some button"
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