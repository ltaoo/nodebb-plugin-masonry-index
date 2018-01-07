<style>
    #recent_posts {
        list-style: none;
        margin-left: 0;
        padding: 0;
    }
    #recent_posts li > div {
        max-height: max-content;
    }
    .recent-replies ul li .card__footer {
        height: 24px;
        line-height: 24px;
        vertical-align: middle;
    }
    .card__avatar {
        float: left;
    }
    .recent-replies .card__avatar .avatar {
        margin-top: 0;
    }
    .card__container {
        display: inline-block;
        padding: 5px 10px;
        box-sizing: border-box;
    }
    .card__item {
        padding: 20px;
        border-radius: 5px;
        background: #fff;
        box-shadow: 0 0 10px #ccc;
    }
</style>
<div class="recent-replies">
    <ul id="recent_posts" data-numposts="{numPosts}" data-cid="{cid}">
    <!-- IMPORT partials/posts.tpl -->
    </ul>
</div>

<script>
'use strict';
/* globals app, socket, translator, templates*/
(function() {
    function onLoad() {
        var replies = $('#recent_posts');

        app.createUserTooltips();
        processHtml(replies);

        var recentPostsWidget = app.widgets.recentPosts;
        var numPosts = parseInt(replies.attr('data-numposts'), 10) || 4;

        if (!recentPostsWidget) {
            recentPostsWidget = {};
            recentPostsWidget.onNewPost = function(data) {

                var cid = replies.attr('data-cid');
                var recentPosts = $('#recent_posts');
                if (!recentPosts.length) {
                    return;
                }

                if (cid && parseInt(cid, 10) !== parseInt(data.posts[0].topic.cid, 10)) {
                    return;
                }

                app.parseAndTranslate('partials/posts', {
                    relative_path: config.relative_path,
                    posts: data.posts
                }, function(html) {
                    processHtml(html);

                    html.hide()
                        .prependTo(recentPosts)
                        .fadeIn();

                    app.createUserTooltips();
                    if (recentPosts.children().length > numPosts) {
                        recentPosts.children().last().remove();
                    }
                });
            };

            app.widgets.recentPosts = recentPostsWidget;
            socket.on('event:new_post', app.widgets.recentPosts.onNewPost);
        }

        function processHtml(html) {
            app.replaceSelfLinks(html.find('a'));

            html.find('img:not(.not-responsive)').addClass('img-responsive');
            html.find('span.timeago').timeago();
        }
    }


    if (window.jQuery) {
        onLoad();
    } else {
        window.addEventListener('load', onLoad);
    }
})();
</script>
