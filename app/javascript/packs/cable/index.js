import Vue from 'vue'
import ActionCable from 'actioncable';
Vue.prototype.$cable = ActionCable.createConsumer();
