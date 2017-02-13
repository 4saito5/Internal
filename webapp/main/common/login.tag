<login>
	<div class="container">

		<div class="row">
			<div class="col-sm-10">
				<h2 class="page-header">社内向けWeb</h2>
			</div>
		</div>

		<div class="row">
			<div class="col-sm-12">
				<form id="login-form" class="minimal-form" onsubmit='{submit}'>
					<div class="input-group">
						<span class="input-group-addon"><i class="fa fa-user icon"></i></span>
						<input type="text" class="form-control" name="login_id" placeholder="メールアドレス、電話番号またはユーザーID" tabindex="1" autofocus>
					</div>
					<input type="checkbox" name="savelogin_id" tabindex="3">ログインIDをブラウザに記憶
					<div class="input-group">
						<span class="input-group-addon"><i class="fa fa-lock icon"></i></span>
						<input type="password" class="form-control" name="password" placeholder="パスワード" tabindex="2">
					</div>
					<input type="checkbox" name="savePassword" tabindex="4">パスワードをブラウザに記憶
					<div class="input-group">
						<button type="submit" class="btn btn-success"><i class="fa fa-sign-in"></i>ログイン</button>
					</div>
				</form>
		    <div class="alert alert-danger" role="alert" if='{loginError}'>ログインに失敗しました。</div>
			</div>
		</div>

	</div>

	<style>
		.input-group {
			margin: 30px 0px 4px 0px;
		}
		.icon {
			width: 26px;
		}
		.btn {
			margin-top: 10px;
			width: 130px;
		}
		.fa-sign-in {
			margin: 0px 8px 0px 0px;
		}
    .alert {
      margin-top: 20px;
    }
	</style>

	<script>
    var vm = this;
		vm.on('mount', function() {
      vm.loginError = false;
      if (localStorage.login_id) {
        vm.login_id.value = localStorage.login_id;
        vm.savelogin_id.checked = true;
      } else {
        vm.login_id.value = '';
        vm.savelogin_id.checked = false;
      }
      if (localStorage.password) {
        vm.password.value = localStorage.password;
        vm.savePassword.checked = true;
      } else {
        vm.password.value = '';
        vm.savePassword.checked = false;
      }
		});

    vm.dispAlert = function() {
      vm.loginError = true;
      vm.update();
      setTimeout(function(){
        vm.loginError = false;
        vm.update();
      }, 5000);
    };

		vm.submit = function() {
      fetch('./webapi/login', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          login_id: vm.login_id.value,
          password: vm.password.value,
        })
      }).then(function(response) {
        if (response.status == 200) {
          return response.json();
        }
      }).then(function(json) {
        if (vm.savelogin_id.checked) {
          localStorage.login_id = vm.login_id.value;
        }
        if (vm.savePassword.checked) {
          localStorage.password = vm.password.value;
        }
        if (json.result == 0) {
          sessionStorage.login_id = vm.login_id.value;
          sessionStorage.user = JSON.stringify(json.user);
          sessionStorage.contact = JSON.stringify(json.contact);

          // obs.trigger("myEvent");
          window.MainMenu.setUser(json.user.auth);

    			riot.route('home');
        } else {
          vm.dispAlert();
        }
			}).catch(function(err) {
        vm.dispAlert();
			});
		};
	</script>
</login>
