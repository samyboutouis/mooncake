// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
import "bootstrap";
require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")
require( 'jszip' );
require( 'pdfmake' );
require( 'datatables.net-bs4' )();
require( 'datatables.net-buttons-bs4' )();
require( 'datatables.net-buttons/js/buttons.html5.js' )();
require( 'datatables.net-responsive-bs4' )();
require( 'datatables.net-scroller-bs4' )();
require( 'datatables.net-searchpanes-bs4' )();
require( 'datatables.net-select-bs4' )();
require("packs/custom")
require("packs/form")
require("packs/courses")
require("packs/facreqview")
var $  = require( 'jquery' );
var dt = require( 'datatables.net' )( window, $ );

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
