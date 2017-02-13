<mt-user-list>
  <div class="container">
    <div class="row">
      <div class="col-sm-10">
        <h3 class="page-header">ユーザー一覧</h3>
      </div>
    </div>
    <div class="col-sm-12">

      <fieldset>
        <div class="form-group">
          <div class="alert col-sm-10"></div>

          <!-- ボタン -->
          <div class="col-sm-2">
            <button type="submit" class="btn btn-primary" onclick={callDetailNew}>
              <span class="glyphicon glyphicon-save"></span>追加</button>
          </div>
        </div>

        <table class="table table-hover">
          <thead>
            <tr>
              <th>ユーザID</th>
              <th>権限</th>
              <th>性</th>
              <th>名</th>
              <th>誕生日</th>
              <th>入社日</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td><input type="text" class="form-control" onkeyup="{filering}" name="user_id"></td>
              <td><input type="text" class="form-control" onkeyup="{filering}" name="auth"></td>
              <td><input type="text" class="form-control" onkeyup="{filering}" name="last_name"></td>
              <td><input type="text" class="form-control" onkeyup="{filering}" name="first_name"></td>
              <td><input type="text" class="form-control" onkeyup="{filering}" name="birthday"></td>
              <td><input type="text" class="form-control" onkeyup="{filering}" name="joined"></td>
            </tr>
            <!-- テーブル内にonClickを置くと、画面ロード時に発火する -->
            <!--  onclick={callDetail(user_id)} -->
            <tr each={userList.filter(itemsFilter)} onclick={callDetailEdit}>
              <td>{user_id}</td>
              <td>{auth}</td>
              <td>{last_name}</td>
              <td>{first_name}</td>
              <td>{birthday}</td>
              <td>{joined}</td>
              <!-- <td><button class="btn btn-success" onclick={callDetail(user_id)}>修正</button></td> -->
            </tr>
          </tbody>
        </table>
      </fieldset>
    </div>
  </div>


  <script>
    var vm = this;

    vm.matching = function(item, filter) {
      var re = new RegExp(filter);
      return (!filter || re.test(item));
    }

    vm.itemsFilter = function(item) {
      if (vm.matching(item.user_id, vm.user_id.value) &&
          vm.matching(item.auth, vm.auth.value) &&
          vm.matching(item.last_name, vm.last_name.value) &&
          vm.matching(item.first_name, vm.first_name.value) &&
          vm.matching(item.birthday, vm.birthday.value) &&
          vm.matching(item.joined, vm.joined.value)) {
        return item;
      }
    };

    vm.filering = function() {
      vm.update();
    };

    vm.on('mount', function() {
      fetch('./webapi/mt/getUserList', {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json'
        }
      }).then(function(response) {
        if (response.status == 200) {
          return response.json();
        }
      }).then(function(json) {
        if (json.result == 0) {
          // vm.userList = JSON.stringify(json.userList);
          vm.userList = json.userList;
          riot.update();
        } else {
          vm.dispAlert();
        }
			}).catch(function(err) {
        vm.dispAlert();
			});
		});

    vm.callDetailNew = function() {
      sessionStorage.mode = 0;  // 新規モード
      riot.route('mt-user-detail/');
    };

    vm.callDetailEdit = function(e) {
      sessionStorage.mode = 1;  // 編集モード
      sessionStorage.mt = JSON.stringify({user_id : e.item.user_id});
      riot.route('mt-user-detail/');
    };

    vm.dispAlert = function() {
      vm.loginError = true;
      vm.update();
      setTimeout(function(){
        vm.loginError = false;
        vm.update();
      }, 5000);
    };
	</script>
</mt-user-list>
