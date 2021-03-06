var congoApp = angular.module('congoApp');

congoApp.controller('AdminFeaturesIndexController', [
  '$scope', '$http', '$location', 'flashesFactory',
  function ($scope, $http, $location) {
    // Make sure user is admin before continuing.
    $scope.enforceAdmin();

    $scope.isLocked = false;

    $scope.newFeature = function () {
      var feature = {
        name: $scope.feature.name,
        description: $scope.feature.description,
        enabled_for_all: $scope.feature.enabled_for_all,
        account_slugs: $scope.feature.account_slugs.split(/,\s*/)
      };

      $scope.isLocked = true;

      $http
        .post('/api/internal/admin/features.json', feature)
        .success(function (data, status, headers, config) {
          var feature = data.feature;

          feature.account_slugs = feature.account_slug_data.split(', ');

          $scope.features.push(feature);

          $scope.isLocked = false;
        })
        .error(function (data, status, headers, config) {
          var error = (data && data.error) ?
            data.error :
            'There was a problem creating a new feature.';

          flashesFactory.add('danger', error);

          $scope.isLocked = false;
        });
    };
    
    $scope.updateFeatureAt = function (index) {
      var feature = $scope.features[index];

      $http
        .put('/api/internal/admin/features/' + feature.id + '.json', feature)
        .success(function (data, status, headers, config) {
          data.feature.account_slugs = data.feature.account_slug_data.split(', ');

          $scope.features[index] = data.feature;
        })
        .error(function (data, status, headers, config) {
          var error = (data && data.error) ?
            data.error :
            'There was a problem updating the feature.';

          flashesFactory.add('danger', error);
        });
    };

    $scope.deleteFeatureAt = function (index) {
      var feature = $scope.features[index];

      $http
        .delete('/api/internal/admin/features/' + feature.id + '.json')
        .success(function (data, status, headers, config) {
          $scope.features.splice(index, 1);
        })
        .error(function (data, status, headers, config) {
          var error = (data && data.error) ?
            data.error :
            'There was a problem deleting the feature.';

          flashesFactory.add('danger', error);
        });
    };

    $scope.feature = {
      name: '',
      description: '',
      enabled_for_all: false,
      account_slugs: []
    };

    $scope.features = null;

    $http
      .get('/api/internal/admin/features.json')
      .success(function (data, status, headers, config) {
        $scope.features = _(data.features).map(function (feature) {
          feature.account_slugs = feature.account_slug_data.split(', ');

          return feature;
        });

        $scope.ready();
      })
      .error(function (data, status, headers, config) {
        var error = (data && data.error) ?
          data.error :
          'There was a problem fetching the list of features.';

        flashesFactory.add('danger', error);
      });
  }
]);

