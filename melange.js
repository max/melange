// Generated by CoffeeScript 1.3.3
(function() {

  $(function() {
    var Melange;
    Melange = (function() {

      function Melange() {}

      Melange.init = function() {
        if (typeof mixpanel === "undefined" || mixpanel === null) {
          return;
        }
        if (typeof user !== "undefined" && user !== null) {
          mixpanel.people.identify(user);
        }
        return Melange.report("viewed", [location.hostname, location.pathname].join(""));
      };

      Melange.report = function(action, subject) {
        if (typeof mixpanel === "undefined" || mixpanel === null) {
          return;
        }
        if (window.console) {
          console.log("Melange: " + action + " " + subject);
        }
        return mixpanel.track("" + action + " " + subject);
      };

      return Melange;

    })();
    window.Melange = Melange;
    return Melange.init();
  });

}).call(this);
