/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
null;

/* @ngInject */
global.cobudgetApp.factory('LoadBar', function($rootScope) {
  let LoadBar;
  return new (LoadBar = class LoadBar {

    start(args) {
      args = args || {};
      $rootScope.loadingScreenMsg = args.msg;
      return $rootScope.$broadcast('loading');
    }

    updateMsg(msg) {
      return $rootScope.loadingScreenMsg = msg;
    }

    stop() {
      $rootScope.loadingScreenMsg = null;
      return $rootScope.$broadcast('loaded');
    }
  });
});
