var congoApp = angular.module('congoApp');

// Enable HTML 5 history
congoApp.config([
  '$locationProvider',
  function ($locationProvider) {
    $locationProvider.html5Mode(true);
  }
]);

// General routes
congoApp.config([
  '$routeProvider',
  function ($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: congo.assets['landing.html'],
        controller: 'LandingController'
      })
      .when('/accounts', {
        templateUrl: congo.assets['accounts.html'],
        controller: 'AccountsController'
      })
      .when('/accounts/new', {
        templateUrl: congo.assets['accounts-new.html'],
        controller: 'AccountsNewController'
      });
  }
]);

// Admin routes
congoApp.config([
  '$routeProvider',
  function ($routeProvider) {
    $routeProvider
      .when('/admin', {
        templateUrl: congo.assets['home.html'],
        controller: 'HomeController'
      })
      .when('/admin/carriers', {
        templateUrl: congo.assets['admin/carriers/index.html'],
        controller: 'AdminCarriersIndexController'
      })
      .when('/admin/carriers/new', {
        templateUrl: congo.assets['admin/carriers/new.html'],
        controller: 'AdminCarriersNewController'
      })
      .when('/admin/carriers/:carrier_slug', {
        templateUrl: congo.assets['admin/carriers/show.html'],
        controller: 'AdminCarriersShowController'
      })
      .when('/admin/benefit_plans', {
        templateUrl: congo.assets['admin/benefit_plans/index.html'],
        controller: 'AdminBenefitPlansIndexController'
      })
      .when('/admin/benefit_plans/new', {
        templateUrl: congo.assets['admin/benefit_plans/new.html'],
        controller: 'AdminBenefitPlansNewController'
      })
      .when('/admin/benefit_plans/:benefit_plan_slug', {
        templateUrl: congo.assets['admin/benefit_plans/show.html'],
        controller: 'AdminBenefitPlansShowController'
      })
      .when('/admin/invitations', {
        templateUrl: congo.assets['admin/invitations/index.html'],
        controller: 'AdminInvitationsIndexController'
      })
      .when('/admin/accounts', {
        templateUrl: congo.assets['admin/accounts/index.html'],
        controller: 'AdminAccountsIndexController'
      })
      .when('/admin/groups', {
        templateUrl: congo.assets['admin/groups/index.html'],
        controller: 'AdminGroupsIndexController'
      })
      .when('/admin/users', {
        templateUrl: congo.assets['admin/users/index.html'],
        controller: 'AdminUsersIndexController'
      })
      .when('/admin/features', {
        templateUrl: congo.assets['admin/features/index.html'],
        controller: 'AdminFeaturesIndexController'
      })
  }
]);

// User routes
congoApp.config([
  '$routeProvider',
  function ($routeProvider) {
    $routeProvider
      .when('/users/new_manager', {
        templateUrl: congo.assets['users/new_manager.html'],
        controller: 'UsersNewManagerController'
      })
      .when('/users/new_plan', {
        templateUrl: congo.assets['users/new_plan.html'],
        controller: 'UsersNewPlanController'
      })
      .when('/users/new_billing', {
        templateUrl: congo.assets['users/new_billing.html'],
        controller: 'UsersNewBillingController'
      })
      .when('/users/new_account', {
        templateUrl: congo.assets['users/new_account.html'],
        controller: 'UsersNewAccountController'
      })
      .when('/users/new_customer', {
        templateUrl: congo.assets['users/new_customer.html'],
        controller: 'UsersNewCustomerController'
      })
      .when('/users/signin', {
        templateUrl: congo.assets['users/signin.html'],
        controller: 'UsersSigninController'
      })
      .when('/users/:id', {
        templateUrl: congo.assets['users/show.html'],
        controller: 'UsersShowController'
      });
  }
]);

// Account routes
congoApp.config([
  '$routeProvider',
  function ($routeProvider) {
    $routeProvider
      .when('/accounts/:slug/:role', {
        templateUrl: congo.assets['home.html'],
        controller: 'HomeController'
      })
      .when('/accounts/:slug/:role/settings', {
        templateUrl: congo.assets['settings/show.html'],
        controller: 'SettingsShowController'
      })
      .when('/accounts/:slug/:role/carriers', {
        templateUrl: congo.assets['carriers/index.html'],
        controller: 'CarriersIndexController'
      })
      .when('/accounts/:slug/:role/carriers/new', {
        templateUrl: congo.assets['carriers/new.html'],
        controller: 'CarriersNewController'
      })
      .when('/accounts/:slug/:role/carriers/:carrier_slug', {
        templateUrl: congo.assets['carriers/show.html'],
        controller: 'CarriersShowController'
      })
      .when('/accounts/:slug/:role/benefit_plans/new', {
        templateUrl: congo.assets['benefit_plans/new.html'],
        controller: 'BenefitPlansNewController'
      })
      .when('/accounts/:slug/:role/benefit_plans/:benefit_plan_slug', {
        templateUrl: congo.assets['benefit_plans/show.html'],
        controller: 'BenefitPlansShowController'
      })
      .when('/accounts/:slug/:role/groups', {
        templateUrl: congo.assets['groups/index.html'],
        controller: 'GroupsIndexController'
      })
      .when('/accounts/:slug/:role/groups/new', {
        templateUrl: congo.assets['groups/new.html'],
        controller: 'GroupsNewController'
      })
      .when('/accounts/:slug/:role/groups/:group_slug', {
        templateUrl: congo.assets['groups/show.html'],
        controller: 'GroupsShowController'
      })
      .when('/accounts/:slug/:role/groups/:group_slug/benefit_plans/:benefit_plan_slug/applications/new', {
        templateUrl: congo.assets['applications/new.html'],
        controller: 'ApplicationsNewController'
      })
      .when('/accounts/:slug/:role/applications/:application_id', {
        templateUrl: congo.assets['applications/new.html'],
        controller: 'ApplicationsShowController'
      })
      .when('/accounts/:slug/:role/applications', {
        templateUrl: congo.assets['applications/index.html'],
        controller: 'ApplicationsIndexController'
      })
      .when('/accounts/:slug/:role/tokens', {
        templateUrl: congo.assets['tokens/index.html'],
        controller: 'TokensIndexController'
      })
      .when('/accounts/:slug/:role/messages', {
        templateUrl: congo.assets['messages/index.html'],
        controller: 'MessagesIndexController'
      })
      .when('/accounts/:slug/:role/activities', {
        templateUrl: congo.assets['activities/index.html'],
        controller: 'ActivitiesIndexController'
      })
  }
]);

