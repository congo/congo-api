var congoApp = angular.module('congoApp');

congoApp.factory('flashesFactory', function (eventsFactory) {
  var flashes = [];

  return {
    flashes: flashes,
    add: function (type, message) {
      flashes.push({
        type: type,
        message: message
      });

      eventsFactory.emit('flash_added');
    }
  };
});
