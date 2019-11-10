const API_URL = 'http://localhost';

Vue.use(VueResource);
Vue.use(window['vue-js-modal'].default);

function displayAuthor() {
  return `${this.firstName} ${this.lastName}`;
}

const store = new Vuex.Store({
  state: {
    loadingStatus: 'loading',
    authors: [],
    books: [],
  },
  mutations: {
    updateAuthors(state, authors) {
      state.authors = authors;
    },
    updateBooks(state, books) {
      state.books = books;
    },
  },
  actions: {
    async fetchAuthors({ commit }) {
      const { body: authors } = await Vue.http.get(`${API_URL}/authors`);
      for (const author of authors) {
        author.toString = displayAuthor;
      }
      commit('updateAuthors', authors);
    },
    async publishAuthor({ dispatch }, author) {
      await Vue.http.post(`${API_URL}/authors`, author);
      dispatch('fetchAuthors');
    },
    async deleteAuthor({ dispatch }, author) {
      // Disabled because of DNU on server side
      // await Vue.http.delete(`${API_URL}/authors`, author);
      dispatch('fetchAuthors');
    },
    async fetchBooks({ commit }) {
      const { body: books } = await Vue.http.get(`${API_URL}/books`);
      commit('updateBooks', books);
    },
    async publishBook({ dispatch }, book) {
      await Vue.http.post(`${API_URL}/books`, book);
      dispatch('fetchBooks');
    },
    async deleteBook({ dispatch }, book) {
      // Disabled because of DNU on server side
      // await Vue.http.delete(`${API_URL}/books`, book);
      dispatch('fetchBooks');
    },
  },
});

Vue.component('author-crud', {
  computed: {
    authors() { return this.$store.state.authors; },
  },
  data() {
    return {
      author: {
        firstName: '',
        lastName: '',
        country: '',
      },
    };
  },
  methods: {
    registerAuthor() {
      this.$store.dispatch('publishAuthor', { ...this.author });
    },
    deleteAuthor(author) {
      this.$store.dispatch('deleteAuthor', { ...author });
    },
  },
  mounted() {
    this.$store.dispatch('fetchAuthors');
  },
  template: `\
<span>
  <form>
    <div class="form-row">
      <div class="col-auto">
        <label for="author-first-name" class="sr-only">Nombre</label>
        <input type="text" id="author-first-name" class="form-control mb-2" placeholder="Nombre" v-model="author.firstName"/>
      </div>
      <div class="col-auto">
        <label for="author-last-name" class="sr-only">Apellido</label>
        <input type="text" id="author-last-name" class="form-control mb-2" placeholder="Apellido" v-model="author.lastName"/>
      </div>
      <div class="col-auto">
        <label for="author-country" class="sr-only">País</label>
        <input type="text" id="author-country" class="form-control mb-2" placeholder="País" v-model="author.country"/>
      </div>
      <div class="col-auto">
        <button type="button" class="btn btn-primary" v-on:click="registerAuthor()">Registrar</button>
      </div>
    </div>
  </form>
  <table class="table">
    <tr>
      <th>Nombre</th>
      <th>Apellido</th>
      <th>País</th>
      <th>Acciones</th>
    </tr>
    <tr v-for="author in authors">
      <td>{{author.firstName}}</td>
      <td>{{author.lastName}}</td>
      <td>{{author.country}}</td>
      <td>
        <button type="button" class="btn btn-sm btn-danger" v-on:click="deleteAuthor(author)">
          <i class="fas fa-trash-alt"></i>
        </button>
      </td>
    </tr>
  </table>
</span>`,
});

Vue.component('book-crud', {
  computed: {
    authors() { return this.$store.state.authors; },
    books() { return this.$store.state.books; },
  },
  data() {
    return {
      book: {
        title: '',
        author: undefined,
        releaseYear: '',
        editorial: '',
      },
    };
  },
  methods: {
    registerBook() {
      this.$store.dispatch('publishBook', { ...this.book });
    },
    deleteBook(book) {
      this.$store.dispatch('deleteBook', { ...book });
    },
  },
  mounted() {
    this.$store.dispatch('fetchBooks');
  },
  template: `\
<span>
  <form>
    <datalist id="authors">
      <option v-bind:value="author" v-for="author in authors">
        {{author.firstName}} {{author.lastName}}
      </option>
    </datalist>
    <div class="form-row">
      <div class="col-auto">
        <label for="book-title" class="sr-only">Título</label>
        <input type="text" id="book-title" class="form-control mb-2" placeholder="Título" v-model="book.title"/>
      </div>
      <div class="col-auto">
        <label for="book-author" class="sr-only">Autor</label>
        <input list="authors" id="book-author" class="form-control mb-2" placeholder="Autor" v-model="book.author"/>
      </div>
      <div class="col-auto">
        <label for="book-year" class="sr-only">Año</label>
        <input type="number" id="book-year" class="form-control mb-2" placeholder="Año" v-model="book.releaseYear"/>
      </div>
      <div class="col-auto">
        <label for="book-editorial" class="sr-only">Editorial</label>
        <input type="text" id="book-editorial" class="form-control mb-2" placeholder="Editorial" v-model="book.editorial"/>
      </div>
      <div class="col-auto">
        <label for="book-index" class="sr-only">Indice</label>
        <input type="number" id="book-index" class="form-control mb-2" placeholder="Indice" v-model="book.index"/>
      </div>
      <div class="col-auto">
        <button type="button" class="btn btn-primary" v-on:click="registerBook()">Registrar</button>
      </div>
    </div>
  </form>
  <table class="table">
    <tr>
      <th>Título</th>
      <th>Autor</th>
      <th>Año</th>
      <th>Editorial</th>
      <th>Acciones</th>
    </tr>
    <tr v-for="book in books">
      <td>{{book.title}}</td>
      <td>{{book.author.firstName}} {{book.author.lastName}}</td>
      <td>{{book.releaseYear}}</td>
      <td>{{book.editorial}}</td>
      <td>
        <button type="button" class="btn btn-sm btn-danger" v-on:click="deleteBook(book)">
          <i class="fas fa-trash-alt"></i>
        </button>
      </td>
    </tr>
  </table>
</span>`,
});

// eslint-disable-next-line no-new
new Vue({
  el: '#app',
  store,
  data: {
  },
});
