export default {
  components: {
    form: {
      registerPasswordInput: {
        password: "Password",
        suggestions: "With:",
        suggestionsLowercase: "At least 2 lowercase",
        suggestionsUppercase: "At least 2 uppercase",
        suggestionsNumber: "At least 2 numbers",
        suggestionsSymbol: "At least 1 symbol",
        suggestionsSize: "Minimum 8",
        suggestionsUnicity: "Unique character",
      },
    },
    user: {
      createForm: {
        title: "Create a new user",
        ok: "Create",
        buttonCancel: "Cancel",
      },
      updateForm: {
        pending: "Loading user",
        title: "Update {email}",
        ok: "Update",
      },
      form: {
        email: "Email",
        passwordConfirm: "Confirm your password",
        errorPasswordConfirm: "The confirmation of the password is invalid",
        buttonCancel: "Cancel",
        ok: "Save",
      },
      list: {
        createButton: "New user",
        pending: "Loading users",
        title: "Users",
        edit: "Edit",
        delete: "Delete",
      },
    },
    layout: {
      appHeader: {
        welcome: "Welcome {username}",
      },
      menu: {
        appMenu: {
          dashboard: "Dashboard",
          users: "Users",
          transactions: "Transactions",
          page1: "page1",
          page2: "page2",
          validation: "validation",
          quit: "Quit",
        },
      },
    },
    demo: {
      validation: {
        form: {
          startDate: "Start Date",
          textField: "Text Field",
          siret: "Siret",
          nestedDemoEntityName: "Nested Entity Name",
        },
      },
    },
  },
  pages: {
    page1: {
      altPanda: "This is to discover images",
      background: "This is to discover background",
    },
    auth: {
      login: {
        username: "Email",
        password: "Password",
        title: "Please log-in",
        ok: "Submit",
      },
    },
    user: {
      index: {
        createButton: "Create a user",
      },
    },
  },
  plugins: {
    appFetch: {
      toasterUnauthorizedDetail: "Unauthorized",
      toasterUnauthorizedSummary: "Unauthorized",

      toasterForbiddenDetail: "Forbidden",
      toasterForbiddenSummary: "Forbidden",

      toasterCatchAllDetail: "Error",
      toasterCatchAllSummary: "Error",
    },
    error: {
      toasterCatchAllDetail: "Error",
      toasterCatchAllSummary: "Error",
    },
  },
};
