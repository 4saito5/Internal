// var vm = this;
//
// // URIでパラメータを渡す例
// riot.route('mt-user-detail/*', function(data) {
//   riot.mount('content', 'mt-user-detail', {
//     user: data,
//   });
//
//   vm.tagName = 'mt-user-detail';
//   riot.update();
// });

riot.route(function(tagName) {
  // タブは画面遷移しない
  if (/.*Tab$/.test(tagName)) return;

  // ログインチェック
  if (sessionStorage.login_id) {
    tagName = tagName || 'home';
  } else {
    tagName = 'login';
  }
  console.log('routing ' + tagName);
  riot.mount('content', tagName);
  riot.update();
});

riot.route.start(true);
