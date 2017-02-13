require('./general_affairs/time_card/list.tag');
require('./maintenance/user/detail.tag');
require('./maintenance/user/list.tag');

require('./common/app.tag');

require('./common/routing.js');
// window.obs = riot.observable();
riot.mount('*');
