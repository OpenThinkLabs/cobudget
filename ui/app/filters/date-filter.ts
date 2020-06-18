/* eslint-disable
    no-undef,
*/
// TODO: This file was created by bulk-decaffeinate.
// Fix any style issues and re-enable lint.
/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
global.cobudgetApp.filter('timeFromNowInWords', () => date => moment(date).fromNow(true));

global.cobudgetApp.filter('timeFromNowAmount', () => date => moment(date).fromNow(true).split(' ')[0]);

global.cobudgetApp.filter('timeFromNowUnits', () => date => moment(date).fromNow(true).split(' ')[1]);

global.cobudgetApp.filter('timeToNowAmount', () => date => moment(date).toNow(true).split(' ')[0]);

global.cobudgetApp.filter('timeToNowUnits', () => date => moment(date).toNow(true).split(' ')[1]);

global.cobudgetApp.filter('exactDateWithTime', () => date => moment(date).format('dddd MMMM Do YYYY [at] h:mm a'));

global.cobudgetApp.filter('exactDateNoSpaces', () => date => moment(date).format('YYYY-MM-DD-HH-mm-ss'));

global.cobudgetApp.filter('exactDate', () => date => moment(date).format('dddd MMMM Do YYYY'));

global.cobudgetApp.filter('exactDateNoWeek', () => date => moment(date).format('MMMM Do YYYY'));

global.cobudgetApp.filter('exactDateShort', () => date => moment(date).format('D-MMM-YY'));