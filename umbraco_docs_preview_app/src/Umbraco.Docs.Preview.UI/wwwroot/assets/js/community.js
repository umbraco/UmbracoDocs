var community = function () {
    return {
        /* FORUM */
        markCommentAsSolution: function (id) {
            $.get("/umbraco/api/Powers/Action/?alias=TopicSolved&pageId=" + id);
        },

        highFiveComment: function (id) {
            $.get("/umbraco/api/Powers/Action/?alias=LikeComment&pageId=" + id);
        },

        highFiveQuestion: function (id) {
            $.get("/umbraco/api/Powers/Action/?alias=LikeTopic&pageId=" + id);
        },

        voteProject: function (id) {
            $.get("/umbraco/api/Powers/Action/?alias=ProjectUp&pageId=" + id);
        },

        deleteComment: function (id, thisComment) {

            $.ajax({
                url: "/umbraco/api/Forum/Comment/" + id,
                type: "DELETE"
            });
        },

        deleteThread: function (id) {
            $.ajax({
                url: "/umbraco/api/Topic/Delete/" + id,
                type: "DELETE"
            })
            .done(function () {
                window.location = "/forum";
            });
        },

        flag: function (id, typeOfPost, memberId) {
            $.ajax({
                url: "/umbraco/api/Forum/Flag/",
                type: "POST",
                data: { Id: id, TypeOfPost: typeOfPost, MemberId: memberId }
            });
        },

        getCommentMarkdown: function (id) {
            return $.get("/umbraco/api/Forum/CommentMarkDown/" + id).pipe(function (p) {
                return p;
            });

        },

        getThreadMarkdown: function (id) {
            return $.get("/umbraco/api/Forum/TopicMarkDown/" + id).pipe(function (p) {
                return p;
            });

        },
        follow: function (id, controller) {
            $.get("/umbraco/api/Notifications/SubscribeToForum" + controller + "/?id=" + id);
        },

        unfollow: function (id, controller) {
            $.get("/umbraco/api/Notifications/UnSubscribeFromForum" + controller + "/?id=" + id);
        },

        markAsSpam: function (id, controller) {
            $.post("/umbraco/api/Forum/" + controller + "AsSpam/" + id);
        },

        markAsHam: function (id, controller) {
            $.post("/umbraco/api/Forum/" + controller + "AsHam/" + id);
        },

        getCategoryUrl: function (id) {
            return $.get("/umbraco/api/PublicForum/CategoryUrl/" + id).pipe(function (p) {
                return p;
            });
        },

        removeContributor: function (projectId, memberId) {
            $.ajax({
                url: "/umbraco/api/ProjectContribution/DeleteContributor/?projectId=" + projectId + "&memberId=" + memberId,
                type: "DELETE"
            });
        },

        updateCollaborationStatus: function (projectId, status) {
            $.ajax({
                url: "/umbraco/api/ProjectContribution/UpdateCollaborationStatus/?projectId=" + projectId + "&status=" + status,
                type: "PUT"
            });
        },

        addContributor: function (projectId, email) {
            return $.get("/umbraco/api/ProjectContribution/AddContributor/?projectId=" + projectId + "&email=" + email).pipe(function (p) {
                return p;
            });
        },

        removeProjectForum: function (forumId) {
            $.ajax({
                url: "/umbraco/api/ProjectForum/DeleteProjectForum/?forumId=" + forumId,
                type: "DELETE"
            });
        },

        addProjectForum: function (title, description, parentId) {
            $.post("/umbraco/api/ProjectForum/PostProjectForum/", { title: title, description: description, parentId: parentId }, function (data) {
                $("#forums").append("<li>" + data.title + "<small>" + data.description + "</small><a data-id=\"" + data.forumId + "\" class=\"remove-forum\" href=\"#\"><i class=\"icon-Delete-key\"></i>Remove</a></li>");

                $("#forum-title").val("");
                $("#forum-description").val("");
            });
        },
        
        getTopicDataByWeek: function () {
          return $.get("/umbraco/api/Statistics/GetTopicDataByWeek");
        },

        addKey: function (projectId, description) {
            $.ajax({
                type: "POST",
                url: "/umbraco/api/ProjectApiKey/AddKey/?projectId=" + projectId + "&description=" + description,
                success: function(data) {
                    $("#key-description").val("");
                    $(".manage-keys").append("<div class=\"profile-settings\" style=\"border: 1px #ccc solid; padding:20px\"> <strong>Key description: <i class=\"icon-Key\" style=\"font-size: 30px\"></i>" + data.description + "</strong> <div class=\"profile-settings-forms\"> <div> <p> This is your generated API key. Make sure to copy it and save it now, when you leave this page you can't get it back! You will have to create a new one if you lose it. </p><textarea readonly style=\"font-family:monospace; font-size:18px; background:#000; color:#fff; width: 100%; padding: 10px 20px 10px 8px; border-radius: 5px;\">" + data.project_id + "-" + data.member_id + "-" + data.authKey + "</textarea> </div></div></div>");
                    $(".no-keys").text("");
                },
                error: function(xhr){
                    $("#add-key-warning").text(xhr.responseText);
                }
            });
        },

        removeKey: function (projectId, contriId, pk) {
            $.ajax({
                type: "POST",
                url: "/umbraco/api/ProjectApiKey/RemoveKey/?projectId=" + projectId + "&contribId=" + contriId + "&primaryKey=" + pk,
                success: function() {},
                error: function(xhr){
                    $("#key-warning").text(xhr.responseText);
                }
            });
        }
    };
}();


$(function () {
    /*FORUM*/


    //Go to solution
    $(".go-to-solution").click(function () {
        $("html, body").animate({
            scrollTop: $(this.getAttribute("href")).offset().top - 80
        }, 800);
    });

    //Mark as solution
    $(".comments").on("click", "a.solved", function (e) {
        e.preventDefault();
        var data = $(this).data();
        var id = parseInt(data.id);
        community.markCommentAsSolution(id);
        $(this).closest(".comment").addClass("solution");
        $(".comment a.solved").remove();
    });

    //Copy link
    var deepLinking = false;
    var getLink = $(".getLink");
    var body = $("body");
    var thankYou = $("#thankyou");

    $(".comments").on("click", "a.copy-link", function (e) {
        e.preventDefault();
        if (deepLinking === false) {
            body.addClass("active copy-prompt");
            getLink.html(window.location.protocol + "//" + window.location.hostname + window.location.pathname + $(this).attr("data-id"));
            getLink.focus().select();
            deepLinking = true;
        } else {
            body.removeClass("active copy-prompt");
            deepLinking = false;
        }
        getLink.height(document.getElementsByClassName("getLink")[0].scrollHeight);
    });

    getLink.keydown(function (e) {
        if ((e.metaKey || e.ctrlKey) && e.keyCode === 67) {
            body.removeClass("active copy-prompt");

            console.log(thankYou);

            thankYou.addClass("active");
            setTimeout(function () {
                thankYou.removeClass("active");
            }, 900);
            deepLinking = false;
        }
    });

    $(".overlay").on("click", function () {
        body.removeClass("active copy-prompt");
        deepLinking = false;
    });

    //High five
    $(".highfive-comment a").on("click", function (e) {
        e.preventDefault();
        var data = $(this).data();
        var id = parseInt(data.id);
        community.highFiveComment(id);
        $(this).empty();
        var cont = $(this).parent();
        cont.append("You Rock!");
        var count = parseInt($(".highfive-count", cont).html());
        count++;
        $(".highfive-count", cont).html(count);
    });

    //High five
    $(".highfive-question a").on("click", function (e) {
        e.preventDefault();
        var data = $(this).data();
        var id = parseInt(data.id);
        community.highFiveQuestion(id);
        $(this).empty();
        var cont = $(this).parent();
        cont.append("You Rock!");
        var count = parseInt($(".highfive-count", cont).html());
        count++;
        $(".highfive-count", cont).html(count);
    });

    //Vote project
    $("#projectVote").one("click", function (e) {
        e.preventDefault();
        $("#projectVote").click(function () { return false; });
        var data = $(this).data();
        var id = parseInt(data.id);
        community.voteProject(id);
        var votes = $("#projectVote").html().replace(" votes", "");
        console.log(votes);
        var count = parseInt(votes);

        count++;
        $("#projectVote").html(count + " votes");
        $("#projectVote").after("<br /><span>&nbsp;&nbsp;&nbsp;You Rock!</span>");
    });

    // Terminate upon confirmation
    function terminatePost(typeOfPost, id, thisComment) {
        switch (typeOfPost) {
            case "comment":
                thisComment.closest(".comment").fadeOut(function () { thisComment.closest(".comment").remove(); });
                community.deleteComment(id, thisComment);
                break;
            case "thread":
                community.deleteThread(id);
                break;
            default:
                alert("Something went wrong");
        }
    }
    
    // Ask for confirmation
    function terminateConfirm(typeOfPost, id, thisComment) {
        var $confirmType = $("#confirm-wrapper .type-of");
        var $body = $("body");

        $body.addClass("active confirm-prompt");

        console.log(typeOfPost);
        $confirmType.html(typeOfPost);

        $("#confirm-wrapper .green").unbind("click");
        $("#confirm-wrapper .green").on("click", function () {
            terminatePost(typeOfPost, id, thisComment);
            $body.removeClass("active confirm-prompt");
        });

        $("#confirm-wrapper .red").on("click", function () {
            $body.removeClass("active confirm-prompt");
        });
    }

    function flagConfirm(typeOfPost, id, memberId) {
        var $body = $("body");
        $body.addClass("active confirm-prompt-flag");

        $("#confirm-wrapper-flag .green").unbind("click");
        $("#confirm-wrapper-flag .green").on("click", function () {
            community.flag(id, typeOfPost, memberId);
            $body.removeClass("active confirm-prompt-flag");
        });


        $("#confirm-wrapper-flag .red").on("click", function () {
            $body.removeClass("active confirm-prompt-flag");
        });
    }

    //Delete comment
    $(".comments").on("click", "a.delete-reply", function (e) {
        e.preventDefault();

        var data = $(this).data();
        var id = parseInt(data.id);
        var $thisComment = $(this).closest(".comment");

        terminateConfirm("comment", id, $thisComment);
    });

    // Delete thread
    $(".delete-thread").on("click", function (e) {
        e.preventDefault();

        var data = $(this).data();
        var id = parseInt(data.id);

        terminateConfirm("thread", id);
    });

    //Flag comment
    $(".comments").on("click", "a.flag-comment", function (e) {
        e.preventDefault();

        var data = $(this).data();
        var id = parseInt(data.id);
        var memberId = parseInt(data.member);

        flagConfirm("comment", id, memberId);
    });

    // Flag thread
    $("a.flag-thread").on("click", function (e) {
        e.preventDefault();

        var data = $(this).data();
        var id = parseInt(data.id);
        var memberId = parseInt(data.member);

        flagConfirm("thread", id, memberId);
    });

    //follow thread

    //unfollow thread
    $(".forum-overview .follow").on("click", function (e) {
        e.preventDefault();
        var data = $(this).data();
        var id = parseInt(data.id);
        var controller = data.controller;
        if ($(this).hasClass("following")) {

            community.unfollow(id, controller);
            $(this).removeClass("following");
            $(this).addClass("transparent");
            $("span", $(this)).text("Follow");
        }
        else {
            community.follow(id, controller);
            $(this).addClass("following");
            $(this).removeClass("transparent");
            $("span", $(this)).text("Following");
        }
    });

    //Category filter
    $(".sorting select").on("change", function () {
        var id = $(this).val();
        community.getCategoryUrl(id).done(function (data) {
            window.location.replace(data);

        });;
    });

    //mark as spam

    $(".comments").on("click", "a.mark-as-spam", function (e) {
        e.preventDefault();
        var data = $(this).data();
        var id = parseInt(data.id);
        var controller = data.controller;
        if (confirm("Are you sure you want to mark this as spam?")) {
            community.markAsSpam(id, controller);

            $(this).removeClass("mark-as-spam");
            $(this).addClass("mark-as-ham");

            $("span", $(this)).text("Mark as ham");
        }
    });

    //mark as ham
    $(".comments").on("click", "a.mark-as-ham", function (e) {
        e.preventDefault();
        var data = $(this).data();
        var id = parseInt(data.id);
        var controller = data.controller;

        community.markAsHam(id, controller);

        $(this).removeClass("mark-as-ham");
        $(this).addClass("mark-as-spam");

        $("span", $(this)).text("Mark as spam");
    });


    /* PROFILE */

    //upload avatar
    $(".profile-settings-forms").on("click", ".avatar-image", function (e) {
        var $body = $("body");
        var $dialog = $("#update-avatar-dialog");
        var $loader = $(".span", $dialog);
        var $file = $("input[type=file]", $dialog);
        var $cancel = $("button", $dialog);

        var uploadStart = function () {
            $loader.show();
            $file.hide();
        };

        var uploadComplete = function (response) {

            $loader.hide();
            $file.show();

            if (response.success) {
                $(".avatar-image img", $(".profile-settings-forms")).attr("src", response.imagePath + "?width=100&height=100&mode=crop");
                $("#Avatar", $(".profile-settings-forms")).val(response.imagePath);
                $body.removeClass("active uploading-image");
            } else {
                $dialog.addClass("invalid");
                setTimeout(function () { $dialog.removeClass("invalid") }, 3000);
                $file.val("");
            }
        };

        $file.unbind("change").ajaxfileupload({
            action: $file.attr("data-action"),
            onStart: uploadStart,
            onComplete: uploadComplete
        });

        $cancel.click(function () {
            $body.removeClass("active uploading-image");

        });
        $body.addClass("active uploading-image");
    });

    //password repeat
    $(".profile-settings-forms #password input").focus(function (e) {
        $(".profile-settings-forms #repeat-password").show();
    });

    /* profile form */

    //make sure surrounding element get's warning class
    $(".profile-settings-forms form").submit(function () {

        if ($(this).valid()) {
            $(this).find("div.profile-input").each(function () {
                if ($(this).find(".input-validation-error").length === 0) {
                    $(this).removeClass("warning");
                }
            });
        }
        else {
            $(this).find("div.profile-input").each(function () {
                if ($(this).find(".input-validation-error").length > 0) {
                    $(this).addClass("warning");
                }
            });
        }
    });

    $(".profile-settings-forms form").each(function () {
        $(this).find("div.profile-input").each(function () {
            if ($(this).find(".input-validation-error").length > 0) {
                $(this).addClass("warning");
            }
        });
    });

    /* profile notifications */
    $(".profile-settings .unfollow").on("click", function (e) {
        e.preventDefault();
        var data = $(this).data();
        var id = parseInt(data.id);
        var controller = data.controller;
        community.unfollow(id, controller);
        $(this).parent("li").fadeOut();
    });

    /* profile project contribution */
    $(".profile-settings .remove-contri").on("click", function (e) {
        e.preventDefault();
        var data = $(this).data();
        var projectId = parseInt(data.projectid);
        var memberId = parseInt(data.memberid);

        community.removeContributor(projectId, memberId);
        $(this).parent("li").fadeOut();
    });

    $(".profile-settings #open-for-collab").on("change", function (e) {
        var data = $(this).data();
        var projectId = parseInt(data.id);
        var status = $(this).is(":checked");

        community.updateCollaborationStatus(projectId, status);
    });

    $(".profile-settings #add-contri").on("click", function (e) {
        e.preventDefault();
        $("#contri-feedback").html("");

        if ($("#contri-email").val()) {

            var data = $(this).data();
            var projectId = parseInt(data.id);
            var email = $("#contri-email").val();

            community.addContributor(projectId, email).done(function (data) {
                if (data.success) {
                    $("#contris").append("<li><a href=\"/member/" + data.memberId + "\">" + data.memberName + "</a> - <a data-projectid=\"" + projectId + "\" data-memberid=\"" + data.memberId + "\" class=\"remove-contri\" href=\"#\">Remove</a></li>");
                } else {
                    console.log(data.error);
                    $("#contri-feedback").html(data.error);
                }

                $("#contri-email").val("");
            });
        }
    });

    /* profile project forums ¨*/
    $("#forums .remove-forum").on("click", function (e) {
        e.preventDefault();
        var data = $(this).data();
        var forumId = parseInt(data.id);

        community.removeProjectForum(forumId);
        $(this).parent("li").fadeOut();
    });

    $(".profile-settings-forms #add-forum").on("click", function (e) {
        e.preventDefault();

        if ($("#forum-title").val() && $("#forum-description").val()) {

            var data = $(this).data();
            var projectId = parseInt(data.id);
            var title = $("#forum-title").val();
            var description = $("#forum-description").val();

            community.addProjectForum(title, description, projectId);
        }
    });

    $(".dismisAvatar").on("click", function (e) {
        e.preventDefault();

        var expireDate = new Date();
        expireDate.setTime(expireDate.getTime() + (3650 * 24 * 60 * 60 * 1000));
        var expires = "expires=" + expireDate.toUTCString();
        document.cookie = "dismissAvatar" + "=" + true + "; " + expires + "; path=/";

        $(".avatarTooSmall").hide("fast");
    });

    /* profile project api keys*/
    $("#add-key").on("click", function (e) {
        e.preventDefault();

        $("#add-key-warning").html("");

        if ($("#key-description").val() && $("#key-member")) {

            var data = $(this).data();
            var projectId = parseInt(data.projId);
            var description = $("#key-description").val();

            community.addKey(projectId, description);
        }        
    });

    $(".delete-key").on("click", function (e) {
        e.preventDefault();

        $("#key-warning").html("");

        var data = $(this).data();
        var projectId = parseInt(data.projId);
        var contriId = parseInt(data.membId);
        var pk = parseInt(data.pk);

        community.removeKey(projectId, contriId, pk);    
        
        $(this).closest("tr").remove();
    });
});