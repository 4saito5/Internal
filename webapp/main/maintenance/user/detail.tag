<mt-user-detail-contact>
  <div class="form-group">
    <label class="col-sm-2 control-label" for="name">シーケンス番号</label>
    <div class="col-sm-3 controls">
      <input type="text" name="seq" maxlength="20" class="form-control"/>
      <span class="alert alert-danger" role="alert" if='{idError}'>不正な入力</span>
    </div>
  </div>
</mt-user-detail-contact>

<mt-user-detail>
  <div class="container">

    <!-- $$$ Body $$$$$$$$$$$$$$$$$$$$$$$$$$$  -->
    <div class="row">
      <div class="col-sm-10">
        <h3 class="page-header">{title}</h3>
      </div>
    </div>

    <div class="row">
      <div class="col-sm-12">
        <form id="mt-user-detail-form" class="form-horizontal" onsubmit='{submit}'>
          <fieldset>
            <!-- %%%%% 上部ボタン 新規登録モード %%%%% -->
            <div class="form-group" if='{mode == 0}'>
              <div class="alert col-sm-8"></div>

              <!-- ボタン -->
              <div class="col-sm-4">
                <button type="submit" class="btn btn-primary">
                  <span class="glyphicon glyphicon-save"></span>登録</button>
                <a href="#" class="btn btn-default btn-md"
                  id="btnCancel" >
                  <span class="glyphicon glyphicon-refresh"></span>取消</a>
              </div>
            </div>

            <!-- %%%%% 上部ボタン 編集モード %%%%% -->
            <div class="form-group" if='{mode == 1}'>
              <div class="alert col-sm-7"></div>

              <!-- ボタン -->
              <div class="col-sm-5">
                <button type="submit" class="btn btn-primary">
                  <span class="glyphicon glyphicon-save"></span>保存</button>
                <button type="submit" class="btn btn-danger" show="{loginUser.auth == 99}">
                  <span class="glyphicon glyphicon-save"></span>削除</button>
                <a href="#" class="btn btn-default btn-md"
                  id="btnCancel" >
                  <span class="glyphicon glyphicon-refresh"></span>取消</a>
              </div>
            </div>

            <!-- %%%%% TAB START %%%%%%%%%%%%%%%%%%%%%%%%% -->
            <div role="tabpanel">

              <!-- %%%%% タブ・ナビゲーション %%%%% -->
              <ul class="nav nav-tabs" role="tablist">
                <li role="presentation" id="userTabBtn" class="active"><a href="#userTab"
                  onclick="{changeTab}"
                  aria-controls="user" role="tab" data-toggle="tab">ユーザー情報</a></li>
                <li role="presentation" id="contactTabBtn"><a href="#contactTab"
                  onclick="{changeTab}"
                  aria-controls="contact" role="tab" data-toggle="tab">連絡先</a></li>
              </ul>

              <!-- %%%%% タブ・ペイン %%%%% -->
              <div class="tab-content">

                <!-- (( ユーザー情報 )) -->
                <div role="tabpanel" class="tab-pane active" id="userTab">
                  <br/>
                  <div class="form-group">
                    <label class="col-sm-2 control-label" for="name">ユーザーID</label>
                    <div class="col-sm-3 controls">
                      <input type="text" name="user_id" maxlength="16" class="form-control"/>
                      <span class="alert alert-danger" role="alert" if='{user_idError}'>不正な入力</span>
                    </div>
                  </div>
                  <div class="form-group" if='{mode == 0}'>
                    <label class="col-sm-2 control-label" for="name">パスワード</label>
                    <div class="col-sm-4 controls">
                      <input type="text" name="password" maxlength="16" class="form-control"/>
                      <span class="alert alert-danger" role="alert" if='{passwordError}'>不正な入力</span>
                    </div>
                  </div>
                  <div class="form-group" if='{mode == 1}'>
                    <div class="form-group">
                      <div class="col-sm-offset-2 col-sm-10">
                        <div class="checkbox">
                          <label>
                            <input type="checkbox" name="changePassword" onclick="riot.update()" />パスワードを変更する
                          </label>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="form-group" if='{changePassword.checked}'>
                    <label class="col-sm-2 control-label" for="name">現パスワード</label>
                    <div class="col-sm-2 controls">
                      <input type="text" name="passwordNow" maxlength="16" class="form-control"/>
                      <span class="alert alert-danger" role="alert" if='{passwordNowError}'>不正な入力</span>
                    </div>
                  </div>
                  <div class="form-group" if='{changePassword.checked}'>
                    <label class="col-sm-2 control-label" for="name">新パスワード</label>
                    <div class="col-sm-2 controls">
                      <input type="text" name="passwordNew1" maxlength="16" class="form-control"/>
                      <span class="alert alert-danger" role="alert" if='{passwordNew1Error}'>不正な入力</span>
                    </div>
                  </div>
                  <div class="form-group" if='{changePassword.checked}'>
                    <label class="col-sm-2 control-label" for="name">新パスワード確認</label>
                    <div class="col-sm-2 controls">
                      <input type="text" name="passwordNew2" maxlength="16" class="form-control"/>
                      <span class="alert alert-danger" role="alert" if='{passwordNew2Error}'>不正な入力</span>
                    </div>
                  </div>

                  <!-- TODO 権限ドロップダウンリスト -->
                  <div class="form-group">
                    <label class="col-sm-2 control-label" for="name">権限</label>
                    <div class="col-sm-2 controls">
                      <btn-group>
                        <btn toggle="menu">{auth.name ? auth.name : '未選択'}<caret /></btn>
                        <menu onselect={selectAuth}>
                          <menu-item each="{item in athList}">{item.value}</menu-item>
                        </menu>
                      </btn-group>
                    </div>
                  </div>

                  <div class="form-group">
                    <label class="col-sm-2 control-label" for="name">性</label>
                    <div class="col-sm-2 controls">
                      <input type="text" name="last_name" maxlength="6" class="form-control"/>
                      <span class="alert alert-danger" role="alert" if='{last_nameError}'>不正な入力</span>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label" for="name">名</label>
                    <div class="col-sm-2 controls">
                      <input type="text" name="first_name" maxlength="6" class="form-control"/>
                      <span class="alert alert-danger" role="alert" if='{first_nameError}'>不正な入力</span>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label" for="name">性カナ</label>
                    <div class="col-sm-2 controls">
                      <input type="text" name="last_name_kana" maxlength="6" class="form-control"/>
                      <span class="alert alert-danger" role="alert" if='{last_name_kanaError}'>不正な入力</span>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label" for="name">名カナ</label>
                    <div class="col-sm-2 controls">
                      <input type="text" name="first_name_kana" maxlength="6" class="form-control"/>
                      <span class="alert alert-danger" role="alert" if='{first_name_kanaError}'>不正な入力</span>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label" for="name">誕生日</label>
                    <div class="col-sm-2 controls">
                      <btn-group>
                        <btn toggle="menu">{birthday.value ? birthday.value : '未入力'}<caret /></btn>
                        <menu onselect="{selectBirthday}">
                          <calendar value="{birthday.value}"></calendar>
                        </menu>
                      </btn-group>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label" for="name">入社日</label>
                    <div class="col-sm-2 controls">
                      <btn-group>
                        <btn toggle="menu">{joined.value ? joined.value : '未入力'}<caret /></btn>
                        <menu onselect="{selectJoined}">
                          <calendar value="{joined.value}"></calendar>
                        </menu>
                      </btn-group>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label" for="name">退職日</label>
                    <div class="col-sm-2 controls">
                      <btn-group>
                        <btn toggle="menu">{quited.value ? quited.value : '未入力'}<caret /></btn>
                        <menu onselect="{selectQuited}">
                          <calendar value="{quited.value}"></calendar>
                        </menu>
                      </btn-group>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label" for="name">最終学歴</label>
                    <div class="col-sm-6 controls">
                      <input type="text" name="education" maxlength="50" class="form-control"/>
                      <span class="alert alert-danger" role="alert" if='{educationError}'>不正な入力</span>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label" for="name">郵便番号</label>
                    <div class="col-sm-2 controls">
                      <input type="text" name="zip" maxlength="7" class="form-control"/>
                      <span class="alert alert-danger" role="alert" if='{zipError}'>不正な入力</span>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label" for="name">住所</label>
                    <div class="col-sm-10 controls">
                      <input type="text" name="address" maxlength="100" class="form-control"/>
                      <span class="alert alert-danger" role="alert" if='{addressError}'>不正な入力</span>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label" for="name">路線</label>
                    <div class="col-sm-4 controls">
                      <input type="text" name="line" maxlength="20" class="form-control"/>
                      <span class="alert alert-danger" role="alert" if='{lineError}'>不正な入力</span>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label" for="name">最寄り駅</label>
                    <div class="col-sm-4 controls">
                      <input type="text" name="station" maxlength="20" class="form-control"/>
                      <span class="alert alert-danger" role="alert" if='{stationError}'>不正な入力</span>
                    </div>
                  </div>

                </div>



                <!-- (( 連絡先)) -->
                <div role="tabpanel" class="tab-pane" id="contactTab">

                  <div id="contactList">
                  </div>

                  <%-- シーケンス番号
                  名称
                  種類
                  連絡先
                  <div each="{item in contactList}">
                    <div class="form-group">
                      <label class="col-sm-2 control-label" for="name">シーケンス番号</label>
                      <div class="col-sm-3 controls">
                        <input type="text" name="seq[0]" maxlength="20" class="form-control"/>
                        <span class="alert alert-danger" role="alert" if='{idError}'>不正な入力</span>
                      </div>
                    </div>

                  </div> --%>

                </div>

              </div>
            </div>
            <!-- %%%%% TAB END %%%%%%%%%%%%%%%%%%%%%%%%% -->

          </fieldset>
        </form>
        <hr />

      </div>
    </div>
    <!-- $$$ Body $$$$$$$$$$$$$$$$$$$$$$$$$$$  -->

  </div>

  <style scoped>
    :scope {
      display: block;
    }
    .lang-support calendar:not(last-child) {
      margin-right: 10px;
    }
    .lang-support calendar + calendar {
      border-left: 1px solid #eee;
      padding-left: 10px;
    }
  </style>

  <script>
    var vm = this;

    vm.on('mount', function() {

      vm.loginUser = JSON.parse(sessionStorage.user);
      var mt = {};
      if (sessionStorage.mode) {
        vm.mode = sessionStorage.mode;
      } else {
        vm.mode = 1;
        mt.user_id = vm.loginUser.user_id;
      }
      if (vm.mode == 0) {
        vm.title = 'ユーザー新規登録';
      } else if (vm.mode == 1) {
        vm.title = 'ユーザー編集';
        if (!mt.user_id) {
          mt = JSON.parse(sessionStorage.mt);
        }
        fetch('./webapi/mt/getUser', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
            user_id: mt.user_id
          })
        }).then(function(response) {
          if (response.status == 200) {
            return response.json();
          }
        }).then(function(json) {
          if (json.result == 0) {
            // vm.userList = JSON.stringify(json.userList);
            // vm.user = json.user;
            // vm.contact = json.contact;
            vm.athList = json.athList;
            vm.cntList = json.cntList;

            // ユーザー
            vm.user_id.value = json.user.user_id;
            // vm.password.value = json.user.password;
            vm.auth = {};
            vm.auth.value = json.user.auth;
            vm.auth.name = json.user.authName;
            vm.last_name.value = json.user.last_name;
            vm.first_name.value = json.user.first_name;
            vm.last_name_kana.value = json.user.last_name_kana;
            vm.first_name_kana.value = json.user.first_name_kana;
            vm.birthday = {};
            vm.birthday.value = json.user.birthday;
            vm.joined = {};
            vm.joined.value = json.user.joined;
            vm.quited = {};
            vm.quited.value = json.user.quited;
            vm.education.value = json.user.education;
            vm.zip.value = json.user.zip;
            vm.address.value = json.user.address;
            vm.line.value = json.user.line;
            vm.station.value = json.user.station;

            // 連絡先
            vm.contactList = json.contact;
            vm.seq = [];
            vm.seq.push({'value': vm.contactList[0].seq});
            // vm.seq.push(vm.contactList[1].seq);
            // vm.seq.push(vm.contactList[2].seq);
            vm.seq0 = {};
            vm.seq0.value = vm.contactList[0].seq;

            // var tags = riot.mount('div#contactList', 'mt-user-detail-contact', item);
            var tags = riot.mount('div#contactList', 'mt-user-detail-contact');

            riot.update();
          } else {
            // vm.dispAlert();
          }
  			}).catch(function(err) {
          // vm.dispAlert();
  			});
      }



		});

    // ドロップダウンリストイベント
    vm.selectAuth = e => {
      vm.auth.name = e.target.value;
    }

    // カレンダーイベント
    vm.selectBirthday = e => {
      vm.birthday.value = e.target.value;
    }
    vm.selectJoined = e => {
      vm.joined.value = e.target.value;
    }
    vm.selectQuited = e => {
      vm.quited.value = e.target.value;
    }

    // タブ切り替え
    vm.changeTab = function(e) {
      console.log(e.target.hash);
      if (e.target.hash == '#userTab') {
        document.getElementById('contactTabBtn').className = '';
        document.getElementById('userTabBtn').className = 'active';
        document.getElementById('contactTab').style.display = 'none';
        document.getElementById('userTab').style.display = 'block';
      } else if (e.target.hash == '#contactTab') {
        document.getElementById('userTabBtn').className = '';
        document.getElementById('contactTabBtn').className = 'active';
        document.getElementById('userTab').style.display = 'none';
        document.getElementById('contactTab').style.display = 'block';
      }
    };

  </script>
</mt-user-detail>
