import { createApp,h } from 'vue'
import Antd from 'ant-design-vue';
// import App from './App.vue'
import AddTest from './components/AddTest'

import 'ant-design-vue/dist/antd.css';

const NotFoundComponent = { template: '<p>Page not found</p>' }

const routes = {
  '/': AddTest,
  '/add-test': AddTest,
}

const SimpleRouter = {
  data: () => ({
    currentRoute: window.location.pathname
  }),

  computed: {
    CurrentComponent() {
      return routes[this.currentRoute] || NotFoundComponent
    }
  },

  render() {
    return h(this.CurrentComponent)
  }
}

createApp(SimpleRouter).use(Antd).mount('#app')