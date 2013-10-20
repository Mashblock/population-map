require.config({
    paths: {
        jquery: '../bower_components/jquery/jquery',
        leaflet: "../bower_components/leaflet/dist/leaflet",
        leaflet_providers: "../bower_components/leaflet-providers/leaflet-providers",
        bing: "lib/Tilelayer.Bing",
        d3: '../bower_components/d3/d3',
        topojson: '../bower_components/topojson/topojson',
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
        leaflet_providers: {
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
