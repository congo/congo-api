var congoApp = angular.module('congoApp', ['ngRoute']);

congoApp.config([
  '$routeProvider',
  '$locationProvider',
  function ($routeProvider, $locationProvider) {
    $locationProvider.html5Mode(true);

    $routeProvider
      .when('/', {
        templateUrl: '/assets/landing.html',
        controller: 'LandingController'
      })
      .when('/users/new_manager', {
        templateUrl: '/assets/users/new_manager.html',
        controller: 'UsersNewManagerController'
      })
      .when('/users/new_plan', {
        templateUrl: '/assets/users/new_plan.html',
        controller: 'UsersNewPlanController'
      })
      .when('/users/new_billing', {
        templateUrl: '/assets/users/new_billing.html',
        controller: 'UsersNewBillingController'
      })
      .when('/users/new_account', {
        templateUrl: '/assets/users/new_account.html',
        controller: 'UsersNewAccountController'
      })
      .when('/users/new_customer', {
        templateUrl: '/assets/users/new_customer.html',
        controller: 'UsersNewCustomerController'
      })
      .when('/users/signin', {
        templateUrl: '/assets/users/signin.html',
        controller: 'UsersSigninController'
      })
      .when('/users/:id', {
        templateUrl: '/assets/users/show.html',
        controller: 'UsersShowController'
      })
      .when('/accounts/:slug', {
        templateUrl: '/assets/home.html',
        controller: 'HomeController'
      })
      .when('/accounts/:slug/products', {
        templateUrl: '/assets/products/index.html',
        controller: 'ProductsIndexController'
      })
      .when('/accounts/:slug/products/new', {
        templateUrl: '/assets/products/new.html',
        controller: 'ProductsNewController'
      })
      .when('/accounts/:slug/groups', {
        templateUrl: '/assets/groups/index.html',
        controller: 'GroupsIndexController'
      })
      .when('/accounts/:slug/groups/new', {
        templateUrl: '/assets/groups/new.html',
        controller: 'GroupsNewController'
      })
      .when('/accounts/:slug/groups/:group_slug', {
        templateUrl: '/assets/groups/show.html',
        controller: 'GroupsShowController'
      });
  }
]);

congoApp.factory('eventsFactory', function () {
  var emitter = new EventEmitter2();

  return {
    on: function ($scope, type, listener) {
      emitter.on(type, listener);

      $scope.$on('$destroy', function() {
        emitter.off(type, listener);
      });
    },
    off: function (type, listener) {
      emitter.off(type, listener);
    },
    emit: function () {
      emitter.emit.apply(emitter, arguments);
    }
  };
});

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

congoApp.factory('userDataFactory', function ($location) {
  var userDataFactory = {
    accountSlug: function () {
      var match = $location.path().match(/\/accounts\/([^\/]+)/);

      if (match && match[1] && match[1].length > 0) {
        return match[1];
      }
    },
    groupSlug: function () {
      var match = $location.path().match(/\/groups\/([^\/]+)/);

      if (match && match[1] && match[1].length > 0) {
        return match[1];
      }
    },
    isSignedin: function () {
      return !!congo.currentUser;
    },
    hasRole: function (name) {
      var currentUser = congo.currentUser;
      var accounts;
      var accountSlug;
      var account;

      if (!currentUser) {
        return;
      }

      accounts = currentUser.accounts;
      accountSlug = userDataFactory.accountSlug();
      account = _.findWhere(accounts, { slug: accountSlug, role: name });

      if (!account) {
        return;
      }

      return true;
    },
    firstName: function () {
      if (!congo.currentUser) {
        return;
      }

      return congo.currentUser.first_name;
    },
    accounts: function () {
      if (!congo.currentUser) {
        return;
      }

      return congo.currentUser.accounts;
    },
    accountName: function () {
      var account;

      if (!congo.currentUser) {
        return;
      }

      account = _(congo.currentUser.accounts)
        .findWhere({ slug: userDataFactory.accountSlug() });

      if(!account) {
        return;
      }

      return account.name;
    },
    currentUserId: function () {
      if (!congo.currentUser) {
        return;
      }

      return congo.currentUser.id;
    },
    userId: function () {
      var match = $location.path().match(/\/users\/(\d+)/);

      if (match && match[1] && match[1].length > 0) {
        return match[1];
      }
    }
  };

  return userDataFactory;
});

congoApp.directive('autoFocus', function($timeout) {
  return {
    restrict: 'AC',
    link: function($scope, $element) {
      $timeout(function(){
        $element[0].focus();
      }, 0);
    }
  };
});

congoApp.controller('MainController', function ($scope, $http, $location, userDataFactory, flashesFactory, eventsFactory) {
  $scope.flashes = flashesFactory.flashes;
  eventsFactory.on($scope, 'flash_added', function () {
    $scope.flashes = flashesFactory.flashes;
    $scope.$digest();
  });

  $scope.hasRole = function (name) {
    return userDataFactory.hasRole(name);
  };

  $scope.isSignedin = function () {
    return userDataFactory.isSignedin();
  };

  $scope.firstName = function () {
    return userDataFactory.firstName();
  };

  $scope.accounts = function () {
    return userDataFactory.accounts();
  };

  $scope.accountSlug = function () {
    return userDataFactory.accountSlug();
  };

  $scope.currentUserId = function () {
    return userDataFactory.currentUserId();
  };

  $scope.flashes = function () {
    return flashesFactory.all();
  }

  $scope.$watch('hasRole()');
  $scope.$watch('accountSlug()');
  $scope.$watch('hasAccounts()');
  $scope.$watch('currentUserId()');
  $scope.$watch('flashes');

  $scope.signout = function () {
    $http
      .delete('/api/v1/users/signout.json')
      .success(function (data, status, headers, config) {
        congo.currentUser = null;

        $location.path('/');
      })
      .error(function (data, status, headers, config) {
        debugger
      });
  };
});

congoApp.controller('LandingController', function ($scope) {

});

congoApp.controller('HomeController', function ($scope, userDataFactory) {
  $scope.hasRole = function (name) {
    return userDataFactory.hasRole(name);
  };

  $scope.firstName = function () {
    return userDataFactory.firstName();
  };

  $scope.accountName = function () {
    return userDataFactory.accountName();
  };

  $scope.$watch('hasRole()');
  $scope.$watch('firstName()');
  $scope.$watch('accountName()');
});

congoApp.controller('UsersSigninController', function ($scope, $http, $location) {
  $scope.submit = function () {
    $http
      .post('/api/v1/users/signin.json', {
        email: $scope.email,
        password: $scope.password
      })
      .success(function (data, status, headers, config) {
        congo.currentUser = data.user;

        $location.path('/');
      })
      .error(function (data, status, headers, config) {
        debugger
      });
  };
});

congoApp.controller('UsersNewManagerController', function ($scope, $http, $location) {
  $scope.submit = function () {
    $http
      .post('/api/v1/users.json', {
        first_name: $scope.first_name,
        last_name: $scope.last_name,
        email: $scope.email,
        password: $scope.password,
        password_confirmation: $scope.password_confirmation,
        type: 'broker'
      })
      .success(function (data, status, headers, config) {
        congo.currentUser = data.user;

        $location.path('/users/new_plan');
      })
      .error(function (data, status, headers, config) {
        debugger
      });
  };
});

congoApp.controller('UsersNewPlanController', function ($scope, $http, $location) {
  $scope.pickPlan = function (planName) {
    $http
      .put('/api/v1/users/' + congo.currentUser.id + '.json', {
        plan_name: planName
      })
      .success(function (data, status, headers, config) {
        $location.path('/users/new_billing');
      })
      .error(function (data, status, headers, config) {
        debugger
      });
  };
});

congoApp.controller('UsersNewBillingController', function ($scope, $http, $location) {
  $scope.submit = function () {
    $http
      .put('/api/v1/users/' + congo.currentUser.id + '.json', {
        card_number: $scope.cardNumber,
        month: $scope.month,
        year: $scope.year,
        cvc: $scope.cvc
      })
      .success(function (data, status, headers, config) {
        $location.path('/users/new_account');
      })
      .error(function (data, status, headers, config) {
        debugger
      });
  };
});

congoApp.controller('UsersNewAccountController', function ($scope, $http, $location) {
  $scope.submit = function () {
    $http
      .put('/api/v1/users/' + congo.currentUser.id + '.json', {
        account_id: congo.currentUser.accounts[0].id,
        account_name: $scope.name,
        account_tagline: $scope.tagline
      })
      .success(function (data, status, headers, config) {
        congo.currentUser = data.user;

        $location.path('/accounts/' + congo.currentUser.accounts[0].slug);
      })
      .error(function (data, status, headers, config) {
        debugger
      });
  };
});

congoApp.controller('UsersNewCustomerController', function ($scope, $http, $location) {
  var emailToken = $location.search().email_token;

  congo.currentUser = null;

  $scope.signin = function () {
    var email = $scope.signin_email;
    var password = $scope.signin_password;

    $http
      .post('/api/v1/users/signin.json', {
        email: email,
        password: password,
        email_token: emailToken
      })
      .success(function (data, status, headers, config) {
        congo.currentUser = data.user;

        $location.path('/');
      })
      .error(function (data, status, headers, config) {
        debugger
      });
  }

  $scope.signup = function () {
    $http
      .post('/api/v1/users.json', {
        first_name: $scope.first_name,
        last_name: $scope.last_name,
        email: $scope.email,
        password: $scope.password,
        password_confirmation: $scope.password_confirmation,
        email_token: emailToken
      })
      .success(function (data, status, headers, config) {
        congo.currentUser = data.user;

        $location.path('/');
      })
      .error(function (data, status, headers, config) {
        debugger
      });
  };
});

congoApp.controller('UsersShowController', function ($scope, $http, $location, userDataFactory) {
  $scope.user = null;

  $scope.userId = function () {
    return userDataFactory.userId();
  }

  $scope.$watch('user');
  $scope.$watch('userId()');

  $http
    .get('/api/v1/users/' + $scope.userId() + '.json')
    .success(function (data, status, headers, config) {
      $scope.user = data.user;
    })
    .error(function (data, status, headers, config) {
      debugger
    });
});

congoApp.controller('ProductsIndexController', function ($scope, $http, $location, userDataFactory) {
  $scope.accountSlug = function () {
    return userDataFactory.accountSlug();
  };

  $scope.$watch('accountSlug()');

  $http
    .get('/api/v1/accounts/' + $scope.accountSlug() + '/products.json')
    .success(function (data, status, headers, config) {
      $scope.products = data.products;
    })
    .error(function (data, status, headers, config) {
      debugger
    });

  $scope.deleteProductAt = function (index) {
    var product = $scope.products[index];

    if (!product) {
      debugger
    }

    $http
      .delete('/api/v1/accounts/' + $scope.accountSlug() + '/products/' + product.id + '.json')
      .success(function (data, status, headers, config) {
        $scope.products.splice(index, 1);
      })
      .error(function (data, status, headers, config) {
        debugger
      });
    };
});

congoApp.controller('ProductsNewController', function ($scope, $http, $location, userDataFactory) {
  $scope.accountSlug = function () {
    return userDataFactory.accountSlug();
  };

  $scope.$watch('accountSlug()');

  $scope.submit = function () {
    $http
      .post('/api/v1/accounts/' + $scope.accountSlug() + '/products.json', {
        name: $scope.name
      })
      .success(function (data, status, headers, config) {
        $location.path('/accounts/' + $scope.accountSlug() + '/products');
      })
      .error(function (data, status, headers, config) {
        debugger
      });
  };
});

congoApp.controller('GroupsIndexController', function ($scope, $http, $location, userDataFactory) {
  $scope.accountSlug = function () {
    return userDataFactory.accountSlug();
  };

  $scope.$watch('accountSlug()');

  $http
    .get('/api/v1/accounts/' + $scope.accountSlug() + '/groups.json')
    .success(function (data, status, headers, config) {
      $scope.groups = data.groups;
    })
    .error(function (data, status, headers, config) {
      debugger
    });

  $scope.deleteGroupAt = function (index) {
    var group = $scope.groups[index];

    if (!product) {
      debugger
    }

    $http
      .delete('/api/v1/accounts/' + $scope.accountSlug() + '/groups/' + group.id + '.json')
      .success(function (data, status, headers, config) {
        $scope.groups.splice(index, 1);
        debugger
      })
      .error(function (data, status, headers, config) {
        debugger
      });
    };
});

congoApp.controller('GroupsNewController', function ($scope, $http, $location, userDataFactory) {
  $scope.accountSlug = function () {
    return userDataFactory.accountSlug();
  };

  $scope.$watch('accountSlug()');

  $scope.submit = function () {
    $http
      .post('/api/v1/accounts/' + $scope.accountSlug() + '/groups.json', {
        name: $scope.name
      })
      .success(function (data, status, headers, config) {
        $location.path('/accounts/' + $scope.accountSlug() + '/groups');
      })
      .error(function (data, status, headers, config) {
        debugger
      });
  };
});

congoApp.controller('GroupsShowController', function ($scope, $http, $location, userDataFactory) {
  $scope.accountSlug = function () {
    return userDataFactory.accountSlug();
  };

  $scope.groupSlug = function () {
    return userDataFactory.groupSlug();
  };

  $scope.memberships = function () {
    if ($scope.group) {
      return $scope.group.memberships;
    }
  };

  $scope.$watch('accountSlug()');
  $scope.$watch('groupSlug()');
  $scope.$watch('memberships()');

  $scope.inviteMember = function () {
    var email = $scope.email;
    var data = {
      email: email
    };

    $http
      .post('/api/v1/accounts/' + $scope.accountSlug() + '/groups/' + $scope.groupSlug() + '/memberships.json', data)
      .success(function (data, status, headers, config) {
        $scope.group.memberships.push(data.membership);    
      })
      .error(function (data, status, headers, config) {
        debugger
      });
  };

  $scope.resendConfirmation = function (membership) {
    $http
      .post('/api/v1/accounts/' + $scope.accountSlug() + '/groups/' + $scope.groupSlug() + '/memberships/' + membership.id + '/confirmations.json')
      .success(function (data, status, headers, config) {
        debugger
      })
      .error(function (data, status, headers, config) {
        debugger
      });
  };

  $scope.revokeMembership = function (membership) {
    $http
      .delete('/api/v1/accounts/' + $scope.accountSlug() + '/groups/' + $scope.groupSlug() + '/memberships/' + membership.id + '.json')
      .success(function (data, status, headers, config) {
        $scope.group.memberships = _($scope.group.memberships).reject(function (m) {
          return membership.id === m.id;
        });
      })
      .error(function (data, status, headers, config) {
        debugger
      });
  };

  $scope.enableProduct = function (product) {
    var data = {
      product_id: product.id
    }

    $http
      .post('/api/v1/accounts/' + $scope.accountSlug() + '/groups/' + $scope.groupSlug() + '/group_products.json', data)
      .success(function (data, status, headers, config) {
        product.isEnabled = true;
      })
      .error(function (data, status, headers, config) {
        debugger
      });
  };

  $scope.changeProduct = function (product) {
    if (product.isEnabled) {
      var data = {
        product_id: product.id
      }

      $http
        .post('/api/v1/accounts/' + $scope.accountSlug() + '/groups/' + $scope.groupSlug() + '/group_products.json', data)
        .success(function (data, status, headers, config) {
          product.isEnabled = true;
        })
        .error(function (data, status, headers, config) {
          debugger
        });
    } else {
      $http
        .delete('/api/v1/accounts/' + $scope.accountSlug() + '/groups/' + $scope.groupSlug() + '/group_products.json?product_id=' + product.id)
        .success(function (data, status, headers, config) {
          product.isEnabled = false;
        })
        .error(function (data, status, headers, config) {
          debugger
        });
    }
  };

  function done() {
    if ($scope.products && $scope.group) {
      _($scope.products).each(function (product) {
        product.isEnabled = !!_($scope.group.products).findWhere({ id: product.id });
      });
    }
  }

  $http
    .get('/api/v1/accounts/' + $scope.accountSlug() + '/products.json')
    .success(function (data, status, headers, config) {
      $scope.products = data.products;
      done();
    })
    .error(function (data, status, headers, config) {
      debugger
    });

  $http
    .get('/api/v1/accounts/' + $scope.accountSlug() + '/groups/' + $scope.groupSlug() + '.json')
    .success(function (data, status, headers, config) {
      $scope.group = data.group;
      done();
    })
    .error(function (data, status, headers, config) {
      debugger
    });
});

