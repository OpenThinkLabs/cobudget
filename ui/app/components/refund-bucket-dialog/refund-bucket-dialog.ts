/* eslint-disable
    no-unused-vars,
*/
// TODO: This file was created by bulk-decaffeinate.
// Fix any style issues and re-enable lint.
/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
export default params => ({
  template: require('./refund-bucket-dialog.html'),
  scope: params.scope,

  controller(Dialog, LoadBar, $location, $mdDialog, $scope, Toast) {

    $scope.cancel = () => $mdDialog.cancel();

    return $scope.proceed = function() {
      $scope.cancel();
      LoadBar.start();
      return $scope.bucket.cancel()
        .then(function() {
          const {
            groupId,
          } = $scope.bucket;
          Toast.show('Bucket refunded!');
          return LoadBar.stop();}).catch(function() {
          Dialog.alert({title: 'Error!'});
          return LoadBar.stop();
      });
    };
  },
});