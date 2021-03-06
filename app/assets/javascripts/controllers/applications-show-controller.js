var congoApp = angular.module('congoApp');

congoApp.controller('ApplicationsShowController', [
  '$scope', '$http', '$location', 'flashesFactory',
  function ($scope, $http, $location, flashesFactory) {
    // Make sure user is totally signed up before continuing.
    $scope.enforceValidAccount();

    $http
      .get('/api/internal/accounts/' + $scope.accountSlug() + '/roles/' + $scope.currentRole() + '/applications/' + $scope.applicationId() + '.json')
      .success(function (data, status, headers, config) {
        $scope.application = data.application;

        // TODO: Find a better way to update this (directive?)
        (function () {
          var propertiesData = JSON.parse($scope.application.properties_data);

          _(propertiesData).each(function (i, key, hash) {
            var value = hash[key]

            $('#enrollment-form [name="' + key + '"]').val(value)
          });

          $([
            '#enrollment-form input',
            '#enrollment-form select',
            '#enrollment-form textarea'
          ].join(', ')).attr('disabled', 'disabled');

          $('#enrollment-form input[type=submit]').hide();
          $('#enrollment-form h1').text('Application: ' + $scope.application.benefit_plan.name);
        })();

        $scope.ready();
      })
      .error(function (data, status, headers, config) {
        var error = (data && data.error) ?
          data.error :
          'There was a problem fetching the application.';

        flashesFactory.add('danger', error);
      });
  }
]);

