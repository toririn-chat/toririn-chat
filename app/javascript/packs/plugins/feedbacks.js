import Vue from 'vue'

const feedbacks = {
  data() {
    return {
      feedbacks: []
    };
  },
  methods: {
    clearFeedbacks() {
      Object.keys(this.feedbacks).forEach((key) => {
        Vue.delete(this.feedbacks, key);
      })
    },
    getFeedbacksState(key) {
      if (this.feedbacks[key] === undefined) {
        return 'valid';
      } else {
        return 'invalid';
      }
    },
    onFeedbacksProgress(event) {
      Vue.set(this.feedbacks, 'info', '通信中')
    },
    onFeedbacksErrors(error) {
      // Disable an alert of info
      Vue.delete(this.feedbacks, 'info');

      // Vue.set(this.feedbacks, 'error', error.response.statusText);
      // return;

      // TCP Errors
      if (error.response === undefined) {
        Vue.set(this.feedbacks, 'error', error.message);
        return;
      }
      // HTTP Response does not have contents
      if (error.response.data === undefined) {
        Vue.set(this.feedbacks, 'error', error.response.statusText);
        return;
      }
      // HTTP Response has JSON with errors
      if (error.response.data !== undefined) {
        // Cleanup feedbacks
        Object.keys(this.feedbacks).forEach((key) => {
          Vue.delete(this.feedbacks, key);
        })
        // Set errors to fedbacks
        Object.keys(error.response.data).forEach((attr) => {
          let resource = error.config.resource;
          let key = `${resource}.${attr};`
          let messages = error.response.data[attr];
          messages.forEach((message) => {
            Vue.set(this.feedbacks, key, `${this.$t(key)}${message}`)
          })
        })
        return;
      }
      Vue.set(this.feedbacks, 'error', `Error: ${error.message}`)
    }
  },
  computed: {
    states() {
      let s = {};
      Object.keys(this.feedbacks).forEach((key) => {
        s[key] = this.getFeedbacksState(key)
      })
      return s;
    }
  }
}
export default feedbacks;
