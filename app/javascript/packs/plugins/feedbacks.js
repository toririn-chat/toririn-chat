import Vue from 'vue'

const feedbacks = {
  data() {
    return {
      feedbacks: []
    };
  },
  methods: {
    clearFeedbacks() {
     Vue.delete(this.feedbacks);
      // Object.keys(this.feedbacks).forEach((key) => {
      //   Vue.delete(this.feedbacks, key);
      // })
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
      Vue.set(this.feedbacks, 'error', error.response.statusText);
      return;

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
          Vue.delete(this.feedbacks, key)
        })
        // Set errors to fedbacks
        console.log(error.response);
        Object.keys(error.response.data).forEach((key) => {
          var messages = error.response.data[key]
          var tkey = `room.${key}`
          messages.forEach((message) => {
            Vue.set(this.feedbacks, key, `${this.$t(tkey)}${message}`)
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
