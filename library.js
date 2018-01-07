(function(module) {
	"use strict";
	var async = module.parent.require('async');
	var nconf = module.parent.require('nconf');

	var db = module.parent.require('./database');
	var categories = module.parent.require('./categories');
	var user = module.parent.require('./user');
	var plugins = module.parent.require('./plugins');
	var topics = module.parent.require('./topics');
	var posts = module.parent.require('./posts');
	var groups = module.parent.require('./groups');
	var utils = module.parent.require('./utils');

	var Plugin = {};
	var app;

	Plugin.init = function(params, callback) {
		console.log('plugin init');
		app = params.app;
	}

	Plugin.serveHomepage = function(params){
		params.res.render('homepage', {
			template: {
				name: 'homepage'
			}
		});
	};

	Plugin.addListing = function(data, callback){
		data.routes.push({
			route: 'masonryIndex',
			name: 'Masonry Homepage'
		});
		callback(null, data);
	};

	Plugin.defineWidgetAreas = function(areas, callback) {
		areas = areas.concat([
			{
				'name': 'Custom Test Header',
				'template': 'homepage.tpl',
				'location': 'hp-header'
			},
			{
				'name': 'Custom HP Footer',
				'template': 'homepage.tpl',
				'location': 'hp-footer'
			},
			{
				'name': 'Custom HP Sidebar',
				'template': 'homepage.tpl',
				'location': 'hp-sidebar'
			},
			{
				'name': 'Custom HP Content',
				'template': 'homepage.tpl',
				'location': 'hp-content'
			}
		]);

		callback(null, areas);
	};

	Plugin.renderWidget = function(widget, callback) {
		var cid = widget.data.cid;
		if (!parseInt(cid, 10)) {
			var match = widget.area.url.match('category/([0-9]+)');
			cid = (match && match.length > 1) ? match[1] : null;
		}
		var numPosts = widget.data.numPosts || 20;
		async.waterfall([
			function (next) {
				if (cid) {
					categories.getRecentReplies(cid, widget.uid, numPosts, next);
				} else {
					posts.getRecentPosts(widget.uid, 0, Math.max(0, numPosts - 1), 'alltime', next);
				}
			},
			function (posts, next) {
				var data = {
					posts: posts,
					numPosts: numPosts,
					cid: cid,
					relative_path: nconf.get('relative_path'),
				};

				app.render('widgets/masonry', data, next);
			},
			function (html, next) {
				widget.html = html;
				next(null, widget);
			},
		], callback);
	};

	Plugin.defineWidgets = function(widgets, callback) {
		console.log('defineWidgets', widgets);
		async.waterfall([
			function (next) {
				widgets.push({
					// 这里必须和 render:xxx 后面的值相同
					widget: "masonry",
					name: "Masonry Posts",
					description: "Masonry Posts in index.",
				});
				next(null, widgets);
			},
		]);

		callback(null, widgets);
	};

	module.exports = Plugin;
}(module));
