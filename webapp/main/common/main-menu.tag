<main-menu>
  <div class="row">
    <div class="col-sm-12">

      <ul class="nav nav-tabs" if='{sessionStorage.login_id}'>
        <li role="presentation" class="active"><a href="#home" onclick="riot.route('home')" data-toggle="tab"><i class="fa fa-home"></i>ホーム</a></li>

        <li role="presentation" class="dropdown" if='{MainMenu.generalAffairs.length}'>
          <btn-group>
            <btn toggle="menu">庶務<caret /></btn>
            <menu onselect={ select }>
              <menu-item each="{item in MainMenu.generalAffairs}" value="{item.url}" class="{item.class}" data-toggle="tab">{ item.text }</menu-item>
            </menu>
          </btn-group>
        </li>

        <li role="presentation" class="dropdown" if='{MainMenu.groupWare.length}'>
          <btn-group>
            <btn toggle="menu">グループウェア<caret /></btn>
            <menu onselect={ select }>
              <menu-item each="{item in MainMenu.groupWare}" value="{item.url}" class="{item.class}" data-toggle="tab">{ item.text }</menu-item>
            </menu>
          </btn-group>
        </li>

        <li role="presentation" class="dropdown" if='{MainMenu.maintenance.length}'>
          <btn-group>
            <btn toggle="menu">メンテナンス<caret /></btn>
            <menu onselect={ select }>
              <menu-item each="{item in MainMenu.maintenance}" value="{item.url}" class="{item.class}" data-toggle="tab">{ item.text }</menu-item>
            </menu>
          </btn-group>
        </li>

        <a href="#/logout" class="btn btn-logout pull-right"><i class="fa fa-sign-out"></i>ログアウト</a>
      </ul>

    </div>
  </div>

  <style scoped>
    button {
      margin-right: 2px;
      border-bottom-color: transparent;
      position: relative;
      display: block;
      padding: 10px 15px;
    }
    menu-item  {
      font-size: 24px;
      display: block;
      padding: 10px 20px;
      clear: both;
      font-weight: normal;
      line-height: 1.42857143;
      white-space: nowrap;
      cursor: pointer;
		}
    .colNomal {
      color: rgb(3, 3, 3) !important;
    }
    .colAdmin {
      color: rgb(189, 15, 15) !important;
    }
    .fa {
			margin: 0px 2px 0px 0px;
		}
    .btn-logout {
      position: relative;
      display: block;
      padding: 10px 15px;
      margin: 0px;
    }
  </style>

  <script>
    var vm = this;
    class MainMenu {
      constructor() {
        this.clear();
      }
      clear() {
        this._generalAffairs = [];
        this._groupWare = [];
        this._schedule = [];
        this._maintenance = [];
      }
      setUser(auth) {
        this.clear();
        this._generalAffairs.push({url: 'ga-time-card-record', text: '勤怠入力', class: 'colNomal'});
        this._generalAffairs.push({url: 'ga-time-card-list', text: '勤怠一覧', class: 'colNomal'});
        if (auth > 0) {
          this._generalAffairs.push({url: '#/office/list', text: '勤務地一覧', class: 'colAdmin'});
        }
        this._generalAffairs.push({url: '#/work_report/input', text: '業務報告入力', class: 'colNomal'});
        this._generalAffairs.push({url: '#/work_report/list', text: '業務報告一覧', class: 'colNomal'});

        this._maintenance.push({url: 'mt-user-detail', text: 'ユーザー情報', class: 'colNomal'});
        if (auth == 99) {
          this._maintenance.push({url: 'mt-user-list', text: 'ユーザー一覧', class: 'colAdmin'});
        }
      }
      get generalAffairs() {
        return this._generalAffairs;
      }
      get groupWare() {
        return this._groupWare;
      }
      get schedule() {
        return this._schedule;
      }
      get maintenance() {
        return this._maintenance;
      }
    }
    window.MainMenu = new MainMenu();
    if (sessionStorage.user) {
      vm.user = JSON.parse(sessionStorage.user);
      window.MainMenu.setUser(vm.user.auth);
    }

    // obs.on("myEvent", function() {
    //   if (sessionStorage.user) {
    //     vm.user = JSON.parse(sessionStorage.user);
    //     vm.MainMenu.setUser(vm.user.auth);
    //   }
    // });


    vm.select = function (e) {
      riot.route(e.target.value);
    };
  </script>
</main-menu>
