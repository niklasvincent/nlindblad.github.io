---
layout: post
title: "Jawbone UP API Updates"
language: english
category: posts
---

Apparently a lot has happened since [Eric Blue](http://eric-blue.com/about/) reverse engineered [the Jawbone UP API](http://eric-blue.com/2011/11/28/jawbone-up-api-discovery/) in the end of 2011 ([documentation](http://eric-blue.com/projects/up-api/)).

I recently purchased my own Jawbone UP and I feel a bit limited by their app. After fiddling with raw HTTP requests using cURL with the instructions Eric provided, as well as libraries such as [a Jawbone UP API gem](https://github.com/andrewpbrett/jawbone-up-api) by [Andy Brett](https://github.com/andrewpbrett) I noticed a few things:

* Some of the previously documented end-points had moved
* The API is picky about the User-Agent string (the documented one is too old, apparently)

## Notable HTTP Headers ##
The [old documentation](http://eric-blue.com/projects/up-api/#JawboneUPAPI-NotableHTTPHeaders) is still valid here, although I noticed that the token will not work if sent in the query string any more. Make sure to always use the **x-nudge-token** header for authentication.

Also note that the API is now picky about valid **User-Agent** strings. Logging in works, but additional requests after that with the **User-Agent** *Nudge/1.3.1 CFNetwork/548.0.4 Darwin/11.0.0* as previously suggested yields this response:

{% highlight json %}
{
    "meta": {
        "error_type": "endpoint_error",
        "message": "Not Found",
        "code": 404,
        "error_detail": "Unsupported UP Client: Nudge/1.3.1 CFNetwork/548.0.4 Darwin/11.0.0",
        "time": 1373664204
    },
    "data": {}
}
{% endhighlight %}

The current Android app on my Nexus 4 has the **User-Agent** string *NudgeAndroid/1.3.0 Dalvik/1.6.0 (Linux; U; Android 4.2.2; Nexus 4 Build/JDQ39)*

## Authentication ##
<b>Resource URL</b><br />
https://jawbone.com/user/signin/login

<b>Method</b><br />
POST

<b>Parameters</b><br />
<table class="table">
	<tr><td>email</td><td>user@domain.com</td></tr>
	<tr><td>pwd</td><td>yourpassword</td></tr>
	<tr><td>service</td><td>nudge</td></tr>
</table>

### Response ###

{% highlight json %}
{
    "newly": false,
    "user": {
        "last_name": "Lastname",
        "uid": 123456,
        "image": "/profile_photo_path.jpg",
        "time_removed": 0,
        "basic_info": {
            "weight": 65,
            "dob": "yyyymmdd",
            "gender": "Gender",
            "metric": 1,
            "height": 2.5,
            "locale": "en"
        },
        "share_move": true,
        "up_member_since": 1372962266,
        "birth_day": "21",
        "share_sleep": true,
        "text_1": "",
        "first_name": "Firstname",
        "xid": "XXXXXXXXXXXXXXXXXXX",
        "smart_alarm": {
            "stopTimeMinsPastMidnight": 550,
            "dayMask": 446,
            "enable": true,
            "startTimeMinsPastMidnight": 530
        },
        "apps": [],
        "share_eat": true,
        "birth_month": "7",
        "type": 0,
        "email": "user@domain.com",
        "birth_year": "2013",
        "band_name": "Your Band",
        "up_goals": {
            "move": {
                "steps": 10000,
                "workout_time": null
            },
            "sleep": {
                "total": 28800,
                "bedtime": null,
                "deep": null
            },
            "meals": {
                "calcium": 0,
                "carbs": 0,
                "fiber": 0,
                "unsat_fat": 0,
                "sodium": 0,
                "cholesterol": 0,
                "protein": 0,
                "sugar": 0,
                "sat_fat": 0
            }
        },
        "share_mood": true,
        "primary_address": null,
        "time_created": 1372962266,
        "power_nap": {
            "use_optimal_duration": true,
            "custom_duration": 1590,
            "maximum_duration": 2700
        },
        "active_alert": {
            "stopTimeMinsPastMidnight": 1200,
            "threshold": 0,
            "durationMins": 45,
            "type": 0,
            "startTimeMinsPastMidnight": 540
        },
        "last": "Lastname",
        "name": "Firstname Lastname",
        "gender": "Gender",
        "profile_privacy": "friends",
        "data_2": 0,
        "data_1": 0,
        "flags": 1,
        "goals": {
            "move": 3500,
            "sleep": 21600,
            "eat": 2
        },
        "mail_opts": {
            "mail_opt_in_deals_n_promotions": null,
            "mail_opt_in": null,
            "mail_opt_in_products_owned_updates": null,
            "mail_opt_in_customer_surveys": null,
            "mail_opt_in_new_products": null
        },
        "first": "Firstname"
    },
    "token": "SecretTokenXXXXXXXXXXXXXXXXXXXXXXXXXX",
    "rc": 0
}
{% endhighlight %}

The important values in the response are **token** and the user's **xid**. Those two are needed for further authentication. However, you can use *@me* instead of the xid.

## Unauthorized Access ##
Exactly [the same response as before](http://eric-blue.com/projects/up-api/#JawboneUPAPI-UnauthorizedAccess), which suggests they have not changed anything in the authentication flow (except for the additional data in the response on logging in).

## Notifications ##
The app pulls for notifications from time to time (almost at every view update).<br />

<b>Resource URL</b><br />
https://jawbone.com/nudge/api/v.1.33/users/@me/notifications

<b>Method</b><br />
GET

<b>Parameters</b><br />
<table class="table">
	<tr><td>limit</td><td>10</td></tr>
</table>

### Response ###

{% highlight json %}
{
    "meta": {
        "user_xid": "XXXXXXXXXXXXXXXXXXX",
        "message": "OK",
        "code": 200,
        "time": 1373664933
    },
    "data": {
        "requests_unread_count": 0,
        "read_count": 0,
        "requests_total_count": 0,
        "total_count": 0,
        "notifications_total_count": 0,
        "unread_count": 0,
        "notifications_read_count": 0,
        "inbox": [],
        "requests_read_count": 0,
        "notifications_unread_count": 0,
        "unacknowledged_count": 0
    }
}
{% endhighlight %}

## Features ##
<b>Resource URL</b><br />
https://jawbone.com/nudge/api/v.1.33/features

<b>Method</b><br />
GET

<b>Parameters</b><br />
None

{% highlight json %}
{
    "meta": {
        "user_xid": "XXXXXXXXXXXXXXXXXXX",
        "message": "OK",
        "code": 200,
        "time": 1373664933
    },
    "data": {
        "items": [
            {
                "status": "on",
                "data": null,
                "feature": "system"
            },
            {
                "status": "on",
                "data": null,
                "feature": "up_food_gallery"
            },
            {
                "status": "on",
                "data": null,
                "feature": "up_twitter_share"
            },
            {
                "status": "on",
                "data": null,
                "feature": "up_fooditem_search_typeahead"
            },
            {
                "status": "on",
                "data": null,
                "feature": "up_addressbook_import"
            },
            {
                "status": "on",
                "data": {},
                "feature": "up_slideshow"
            },
            {
                "status": "on",
                "data": null,
                "feature": "barcode_search"
            },
            {
                "status": "off",
                "data": null,
                "feature": "up_daily_dashboards"
            },
            {
                "status": "on",
                "data": null,
                "feature": "up_search"
            },
            {
                "status": "off",
                "data": null,
                "feature": "up_cheers"
            },
            {
                "status": "on",
                "data": null,
                "feature": "up_fb_share"
            },
            {
                "status": "on",
                "data": null,
                "feature": "up_app_gallery"
            },
            {
                "status": "on",
                "data": null,
                "feature": "daily_dashboard"
            },
            {
                "status": "off",
                "data": null,
                "feature": "up_passive_location"
            },
            {
                "status": "on",
                "data": null,
                "feature": "up_twitter_import"
            },
            {
                "status": "on",
                "data": null,
                "feature": "up_twitter_friend_suggestions"
            },
            {
                "status": "on",
                "data": null,
                "feature": "up_fb_import"
            },
            {
                "status": "on",
                "data": null,
                "feature": "up_fb_friend_suggestions"
            },
            {
                "status": "on",
                "data": null,
                "feature": "app_gallery"
            }
        ],
        "message": "",
        "size": 19
    }
}
{% endhighlight %}

## Friends ##
I currently do not have any friends using Jawbone UP, so I cannot tell what the response would look like if it was populated by other users you have befriended. But my guess it that it would be their profile image, xid and name.<br />

<b>Resource URL</b><br />
https://jawbone.com/nudge/api/v.1.33/users/@me/friends
	
<b>Method</b><br />
GET

<b>Parameters</b><br />
<table class="table">
	<tr><td>include_requests</td><td>true</td></tr>
</table>

{% highlight json %}
{
    "meta": {
        "user_xid": "XXXXXXXXXXXXXXXXXXX",
        "message": "OK",
        "code": 200,
        "time": 1373664933
    },
    "data": {
        "requests": {
            "items": [],
            "size": 0
        },
        "friends": {
            "items": [],
            "size": 0
        },
        "unacknowledged_count": 0
    }
}
{% endhighlight %}

## Activity Feed ##
<b>Resource URL</b><br />
https://jawbone.com/nudge/api/v.1.33/users/@me/social

<b>Method</b><br />
GET

<b>Parameters</b><br />
<table class="table">
	<tr><td>date</td><td>20130712</td></tr>
	<tr><td>limit</td><td>20</td></tr>
</table>

{% highlight json %}
{
    "meta": {
        "user_xid": "XXXXXXXXXXXXXXXXXXX",
        "message": "OK",
        "code": 200,
        "time": 1373666183
    },
    "data": {
        "feed": [
            {
                "time_updated": 1373641104,
                "xid": "EJpCkyAtwoPDzXj42JED4w",
                "title": "13,288 steps today",
                "image": "/nudge/api/v.1.33/moves/EJpCkyAtwoPDzXj42JED4w/image/11373641104",
                "reached_goal": true,
                "comments": {
                    "items": [],
                    "size": 0
                },
                "activity_xid": "tLEqzPIug09d0yPd2gTrZw",
                "app_generated": false,
                "emotions": {
                    "items": [],
                    "size": 0
                },
                "time_created": 1373641104,
                "date": 20130712,
                "tz": "Europe/Stockholm",
                "type": "move",
                "networks": [],
                "is_private": false,
                "user": {
                    "xid": "XXXXXXXXXXXXXXXXXXX",
                    "name": "Firstname Lastname",
                    "short_name": "Firstname",
                    "image": "/profile_photo_path.jpg",
                    "last": "Lastname",
                    "type": "user",
                    "first": "Firstname"
                }
            },
            {
                "user": {
                    "last": "Lastname",
                    "name": "Firstname Lastname",
                    "short_name": "Firstname",
                    "image": "user/image/i/51d5d363e1a4b94bf8bcdb88_XXXXXXXXXXXXXXXXXXX_137296777995_2801669_photo.png",
                    "xid": "XXXXXXXXXXXXXXXXXXX",
                    "type": "user",
                    "first": "Firstname"
                },
                "reaction": null,
                "time_updated": 1373641048,
                "subtitle": null,
                "title": "Workout",
                "km": 7.701,
                "is_completed": 1,
                "emotions": {
                    "items": [],
                    "size": 0
                },
                "sub_type": null,
                "activity_xid": "tLEqzPIug08t1CrjMsjf_g",
                "app_generated": false,
                "steps": 9671,
                "time_created": 1373641048,
                "image": "/nudge/api/v.1.33/workouts/EJpCkyAtwoPdq82esOHMuA/image/11373641104",
                "tz": "Europe/Stockholm",
                "duration": 4963,
                "xid": "EJpCkyAtwoPdq82esOHMuA",
                "type": "workout",
                "networks": [],
                "is_private": false,
                "comments": {
                    "items": [],
                    "size": 0
                }
            },
            {
                "time_updated": 1373611766,
                "subtitle": null,
                "title": "for 8h 42m",
                "type": "sleep",
                "image": "/nudge/api/v.1.33/sleeps/EJpCkyAtwoPSxmSfL0XozQ/image/11373611885",
                "reached_goal": true,
                "comments": {
                    "items": [],
                    "size": 0
                },
                "emotions": {
                    "items": [],
                    "size": 0
                },
                "activity_xid": "tLEqzPIug084jGNlSLo4JQ",
                "app_generated": false,
                "awake": 1053,
                "time_created": 1373611766,
                "xid": "EJpCkyAtwoPSxmSfL0XozQ",
                "duration": 32400,
                "tz": "Europe/Stockholm",
                "quality": 81,
                "networks": [],
                "is_private": false,
                "user": {
                    "last": "Lastname",
                    "name": "Firstname Lastname",
                    "short_name": "Firstname",
                    "image": "user/image/i/51d5d363e1a4b94bf8bcdb88_XXXXXXXXXXXXXXXXXXX_137296777995_2801669_photo.png",
                    "xid": "XXXXXXXXXXXXXXXXXXX",
                    "type": "user",
                    "first": "Firstname"
                }
            }
        ],
        "links": {
            "next": "/nudge/api/v.1.33/users/XXXXXXXXXXXXXXXXXXX/social?page_token=1373004962&limit=20"
        }
    }
}
{% endhighlight %}

## Daily Summary ##
<b>Resource URL</b><br />
https://jawbone.com/nudge/api/v.1.33/users/@me/score

<b>Method</b><br />
GET

<b>Parameters</b><br />
<table class="table">
	<tr><td>date</td><td>20130712</td></tr>
</table>

{% highlight json %}
{
    "meta": {
        "user_xid": "XXXXXXXXXXXXXXXXXXX",
        "message": "OK",
        "code": 200,
        "time": 1373664935
    },
    "data": {
        "mood": null,
        "move": {
            "active_time": 6898,
            "longest_idle": 3300,
            "calories": 781.753758364,
            "bg_steps": 13288,
            "goals": {
                "steps": [
                    13288,
                    10000
                ],
                "workout_time": [
                    4963,
                    null
                ]
            },
            "longest_active": 5142,
            "hidden": false,
            "bmr_calories_day": 1743.03149865,
            "bmr_calories": 1187.90637543,
            "distance": 11.198
        },
        "sleep": {
            "awakenings": 0,
            "light": 21614,
            "time_to_sleep": 1053,
            "goals": {
                "total": [
                    31394,
                    28800
                ],
                "bedtime": [
                    1429,
                    null
                ],
                "deep": [
                    9780,
                    null
                ]
            },
            "qualities": [
                81
            ],
            "awake": 1053,
            "hidden": false
        },
        "user_metrics": {
            "dob": "yyyymmdd",
            "gender": 0,
            "pal": null,
            "weight": 65,
            "height": 2.5
        },
        "meals": {
            "num_meals": 0,
            "calories": 0,
            "num_drinks": 0,
            "goals": {
                "calcium": [
                    0,
                    0
                ],
                "carbs": [
                    0,
                    0
                ],
                "fiber": [
                    0,
                    0
                ],
                "unsat_fat": [
                    0,
                    0
                ],
                "sodium": [
                    0,
                    0
                ],
                "cholesterol": [
                    0,
                    0
                ],
                "protein": [
                    0,
                    0
                ],
                "sugar": [
                    0,
                    0
                ],
                "sat_fat": [
                    0,
                    0
                ]
            },
            "hidden": false,
            "num_foods": 0
        },
        "insights": {
            "items": []
        }
    }
}
{% endhighlight %}

## Detailed Sleep Data ##
This is used to generate the plots in the app.<br />

<b>Resource URL</b><br />
https://jawbone.com/nudge/api/v.1.33/sleeps/*XID*/snapshot

The **XID** for the sleep session can be found in the activity feed.

<b>Method</b><br />
GET

<b>Parameters</b><br />
None

{% highlight json %}
{
    "meta": {
        "user_xid": "XXXXXXXXXXXXXXXXXXX",
        "message": "OK",
        "code": 200,
        "time": 1373666895
    },
    "data": [
        [1373579366, 1],
        [1373580266, 2],
        [1373580566, 3],
        [1373583266, 2],
        [1373584766, 3],
        [1373585966, 2],
        [1373588666, 3],
        [1373590166, 2],
        [1373594666, 3],
        [1373597066, 2],
        [1373603066, 3],
        [1373603666, 2],
        [1373609666, 3],
        [1373610866, 2],
        [1373611766, 1]
    ]
}
{% endhighlight %}

## Detailed Activity Data ##
This is used to generate the plots in the app.<br />
<b>Resource URL</b><br />
https://jawbone.com/nudge/api/v.1.33/moves/*XID*/snapshot

The **XID** for the activity session can be found in the activity feed.

<b>Method</b><br />
GET

<b>Parameters</b><br />
<table class="table">
	<tr><td>bucket</td><td>60</td></tr>
</table>

{% highlight json %}
{
    "meta": {
        "user_xid": "XXXXXXXXXXXXXXXXXXX",
        "message": "OK",
        "code": 200,
        "time": 1373667224
    },
    "data": [
        [1373089920, 19.0],
        [1373089980, 0],
        [1373090040, 0],
        [1373090100, 0],
        [1373090160, 0],
        [1373090220, 0],
        [1373090280, 0],
        [1373090340, 0],
        [1373090400, 0],
        [1373090460, 0],
        [1373090520, 0],
        [1373090580, 0],
        [1373090640, 0],
        [1373090700, 0],
        [1373090760, 0],
        [1373090820, 0],
        [1373090880, 0],
        [1373090940, 0],
        [1373091000, 0],
        [1373091060, 0],
        [1373091120, 0],
        [1373091180, 0],
        [1373091240, 0],
        [1373091300, 0],
        [1373091360, 0],
        [1373091420, 0],
        [1373091480, 0],
        [1373091540, 0]
    ]
}
{% endhighlight %}

## Reviving the Jawbone Ruby Gem ##
There is a fork of the  [original Jawbone UP API gem](https://github.com/andrewpbrett/jawbone-up-api) by [Kevin Poorman](https://github.com/noeticpenguin) with [a patch addressing some of the changes](https://github.com/noeticpenguin/jawbone-up-api/commit/5e934eddfa5a730f81b627d5809560c03bb6c100).

I took the liberty of [forking the original](https://github.com/nlindblad/jawbone-up-api) and making sure it works as intended with the new API.

Apparently you do not need the API version (v.1.33) in the URL (see the code for the URL structures used).
 
