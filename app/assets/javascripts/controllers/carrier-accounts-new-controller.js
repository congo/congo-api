var congoApp = angular.module('congoApp');

congoApp.controller('CarrierAccountsNewController', [
  '$scope', '$http', '$location', 'propertiesFactory',
  function ($scope, $http, $location, propertiesFactory) {
    // Make sure user is totally signed up before continuing.
    $scope.enforceValidAccount();

    $scope.elements = [];
    $scope.carriers = [];
    $scope.selectedCarrier = null;

    $scope.submit = function () {
      var properties = propertiesFactory.getPropertiesFromElements($scope.elements);

      $http
        .post('/api/v1/accounts/' + $scope.accountSlug() + '/roles/' + $scope.currentRole() + '/carrier_accounts.json', {
          name: $scope.name,
          carrier_slug: $scope.selectedCarrier.slug,
          properties: properties
        })
        .success(function (data, status, headers, config) {
          $location.path('/accounts/' + $scope.accountSlug() + '/' + $scope.currentRole() + '/carrier_accounts');
        })
        .error(function (data, status, headers, config) {
          debugger
        });
    };

    function done () {
      if ($scope.elements && $scope.carriers) {
        $scope.ready();
      }
    }

    $http
      .get('/api/v1/accounts/' + $scope.accountSlug() + '/roles/' + $scope.currentRole() + '/properties/carrier_accounts.json')
      .success(function (data, status, headers, config) {
        $scope.elements = data.elements;

        done();
      })
      .error(function (data, status, headers, config) {
        debugger
      });

    $http
      .get('/api/v1/admin/carriers.json')
      .success(function (data, status, headers, config) {
        $scope.carriers = data.carriers;
        $scope.selectedCarrier = data.carriers[0];

        done();
      })
      .error(function (data, status, headers, config) {
        debugger
      });
  }
]);
