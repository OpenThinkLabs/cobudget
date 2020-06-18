// TODO: This file was created by bulk-decaffeinate.
// Sanity-check the conversion and remove this comment.
/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
/* @ngInject */

cobudgetApp.config((markedProvider) =>
  markedProvider.setRenderer({
    link(href, title, text) {
      if (href.startsWith("uid:")) {
        return (
          "<a href='#/users/" +
          href.replace("uid:", "") +
          "'" +
          " target='_blank'>" +
          text +
          "</a>"
        );
      } else {
        return (
          "<a href='" +
          href +
          "'" +
          (title ? " title='" + title + "'" : "") +
          " target='_blank'>" +
          text +
          "</a>"
        );
      }
    },
  })
);
