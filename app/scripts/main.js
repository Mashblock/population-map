require.config({
    paths: {
        jquery: '../bower_components/jquery/jquery',
        leaflet: "//cdnjs.cloudflare.com/ajax/libs/leaflet/0.5.1/leaflet",
        stamen: "http://maps.stamen.com/js/tile.stamen.js?v1.2.3",
        bing: "lib/Tilelayer.Bing",
        underscore: "//cdnjs.cloudflare.com/ajax/libs/underscore.js/1.5.2/underscore-min",
        backbone: "//cdnjs.cloudflare.com/ajax/libs/backbone.js/1.0.0/backbone-min",
        d3: "//cdnjs.cloudflare.com/ajax/libs/d3/3.3.3/d3.min",
        topojson: "//cdnjs.cloudflare.com/ajax/libs/topojson/1.1.0/topojson.min",
        bootstrapAffix: '../bower_components/sass-bootstrap/js/affix',
        bootstrapAlert: '../bower_components/sass-bootstrap/js/alert',
        bootstrapButton: '../bower_components/sass-bootstrap/js/button',
        bootstrapCarousel: '../bower_components/sass-bootstrap/js/carousel',
        bootstrapCollapse: '../bower_components/sass-bootstrap/js/collapse',
        bootstrapDropdown: '../bower_components/sass-bootstrap/js/dropdown',
        bootstrapModal: '../bower_components/sass-bootstrap/js/modal',
        bootstrapPopover: '../bower_components/sass-bootstrap/js/popover',
        bootstrapScrollspy: '../bower_components/sass-bootstrap/js/scrollspy',
        bootstrapTab: '../bower_components/sass-bootstrap/js/tab',
        bootstrapTooltip: '../bower_components/sass-bootstrap/js/tooltip',
        bootstrapTransition: '../bower_components/sass-bootstrap/js/transition'
    },
    shim: {
        leaflet:{
          exports: "L"
        },
        d3:{
          exports: "d3"
        },
        topojson:{
          exports: "topojson"
        },
        stamen: {
          deps:["leaflet"],
          exports: "L"
        },
        bing:{
          deps:["leaflet"],
          exports: "L"
        },
        underscore: {
          exports: "_"
        },
        backbone: {
          deps:["jquery", "underscore"],
          exports: "Backbone"
        },
        bootstrapAffix: {
            deps: ['jquery']
        },
        bootstrapAlert: {
            deps: ['jquery', 'bootstrapTransition']
        },
        bootstrapButton: {
            deps: ['jquery']
        },
        bootstrapCarousel: {
            deps: ['jquery', 'bootstrapTransition']
        },
        bootstrapCollapse: {
            deps: ['jquery', 'bootstrapTransition']
        },
        bootstrapDropdown: {
            deps: ['jquery']
        },
        bootstrapModal:{
            deps: ['jquery', 'bootstrapTransition']
        },
        bootstrapPopover: {
            deps: ['jquery', 'bootstrapTooltip']
        },
        bootstrapScrollspy: {
            deps: ['jquery']
        },
        bootstrapTab: {
            deps: ['jquery', 'bootstrapTransition']
        },
        bootstrapTooltip: {
            deps: ['jquery', 'bootstrapTransition']
        },
        bootstrapTransition: {
            deps: ['jquery']
        }
    }
});

require(["app"], function () {
    'use strict';
    // use app here
    require('app');
});
