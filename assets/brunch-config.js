exports.config = {
  // See http://brunch.io/#documentation for docs.
  files: {
    javascripts: {
      joinTo: "js/app.js",

      // To use a separate vendor.js bundle, specify two files path
      // http://brunch.io/docs/config#-files-
      // joinTo: {
      //   "js/app.js": /^js/,
      //   "js/vendor.js": /^(?!js)/
      // }
      //
      // To change the order of concatenation of files, explicitly mention here
      order: {
        before: [          
          "vendor/js/jquery.min.js",
          "vendor/js/popper.min.js",		
          "vendor/js/bootstrap.min.js",
          "vendor/js/appear.min.js",
          "vendor/js/easing.min.js",
          "vendor/js/retina.min.js",
          "vendor/js/countdown.min.js",
          "vendor/js/imagesloaded.pkgd.min.js",
          "vendor/js/isotope.pkgd.min.js",
          "vendor/js/jarallax.min.js",
          "vendor/js/jarallax-video.min.js",
          "vendor/js/jarallax-element.min.js",
          "vendor/js/magnific-popup.min.js",
          "vendor/js/owl.carousel.min.js",
          "vendor/js/functions.js"
        ]
      }
    },
    stylesheets: {
      joinTo: "css/app.css"
    },
    templates: {
      joinTo: "js/app.js"
    }
  },

  conventions: {
    // This option sets where we should place non-css and non-js assets in.
    // By default, we set this to "/assets/static". Files in this directory
    // will be copied to `paths.public`, which is "priv/static" by default.
    assets: /^(static)/
  },

  // Phoenix paths configuration
  paths: {
    // Dependencies and current project directories to watch
    watched: ["static", "css", "js", "vendor"],
    // Where to compile files to
    public: "../priv/static"
  },

  // Configure your plugins
  plugins: {
    babel: {
      // Do not use ES6 compiler in vendor code
      ignore: [/vendor/]
    }
  }, 

  modules: {
    autoRequire: {
      "js/app.js": ["js/app"]
    }
  },

  npm: {
    enabled: true
  }
};
