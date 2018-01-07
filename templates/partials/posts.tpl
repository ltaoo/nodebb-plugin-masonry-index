<!-- BEGIN posts -->
<li data-pid="{posts.pid}" class="clearfix col-md-3 col-xs-6 widget-posts card__container">
    <div class="card__item">
        <h3>{posts.topic.title}</h3>
        <hr>
        <div>
            {posts.content}
            <p class="fade-out"></p>
        </div>
        <span class="pull-right post-preview-footer card__footer">
            <a class="card__avatar" href="<!-- IF posts.user.userslug -->{relative_path}/user/{posts.user.userslug}<!-- ELSE -->#<!-- ENDIF posts.user.userslug -->">
                <!-- IF posts.user.picture -->
                <img title="{posts.user.username}" class="avatar avatar-sm not-responsive" src="{posts.user.picture}" />
                <!-- ELSE -->
                <div title="{posts.user.username}" class="avatar avatar-sm not-responsive" style="background-color: {posts.user.icon:bgColor};">{posts.user.icon:text}</div>
                <!-- ENDIF posts.user.picture -->
            </a>
            <span class="timeago" title="{posts.timestampISO}"></span> &bull;
            <a href="{relative_path}/post/{posts.pid}">[[global:read_more]]</a>
        </span>
    </div>
</li>
<!-- END posts -->