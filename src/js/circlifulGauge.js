/**
 * circlifulGauge.js
 *
 * @fileoverview  jQuery plugin that creates tooltip style toolbars.
 * @link          https://github.com/planetapex/apex-plugin-circlifulGauge/
 * @author        M.Yasir Ali Shah (https://apexfusion.blogspot.com/)
 * @version       1.0
 * @requires      jQuery 1.8+
 *
 * @license Circliful Gauge Apex Plugin v1.0
 * https://github.com/planetapex/apex-plugin-circlifulGauge
 * Copyright 2017 - M.Yasir Ali Shah (https://apexfusion.blogspot.com/)
 * Released under the MIT license.
 * <https://raw.github.com/planetapex/apex-plugin-circlifulGauge/master/LICENSE.txt>
 */

(function(util, server, $, undefined) {
    $.widget("ui.circlifulGauge", {
        options: {
            chart: [{ colSpan: 3 }],
            ajaxIdentifier: null,
            pageItems: '',
            templateNo: 1,
            noDataFoundMessage: '',
            noData: false
        },
        gNoData$: null,
        gRegion$: null,
        gRegionBody$: null,



        _create: function() {
            var uiw = this;

            // getIconUnicode
            $.ui.circlifulGauge.prototype.getIconUnicode = function(name) {
                var fontAwesome = {
                    "glass": "f000",
                    "music": "f001",
                    "search": "f002",
                    "envelope-o": "f003",
                    "heart": "f004",
                    "star": "f005",
                    "star-o": "f006",
                    "user": "f007",
                    "film": "f008",
                    "th-large": "f009",
                    "th": "f00a",
                    "th-list": "f00b",
                    "check": "f00c",
                    "remove": "f00d",
                    "close": "f00d",
                    "times": "f00d",
                    "search-plus": "f00e",
                    "search-minus": "f010",
                    "power-off": "f011",
                    "signal": "f012",
                    "gear": "f013",
                    "cog": "f013",
                    "trash-o": "f014",
                    "home": "f015",
                    "file-o": "f016",
                    "clock-o": "f017",
                    "road": "f018",
                    "download": "f019",
                    "arrow-circle-o-down": "f01a",
                    "arrow-circle-o-up": "f01b",
                    "inbox": "f01c",
                    "play-circle-o": "f01d",
                    "rotate-right": "f01e",
                    "repeat": "f01e",
                    "refresh": "f021",
                    "list-alt": "f022",
                    "lock": "f023",
                    "flag": "f024",
                    "headphones": "f025",
                    "volume-off": "f026",
                    "volume-down": "f027",
                    "volume-up": "f028",
                    "qrcode": "f029",
                    "barcode": "f02a",
                    "tag": "f02b",
                    "tags": "f02c",
                    "book": "f02d",
                    "bookmark": "f02e",
                    "print": "f02f",
                    "camera": "f030",
                    "font": "f031",
                    "bold": "f032",
                    "italic": "f033",
                    "text-height": "f034",
                    "text-width": "f035",
                    "align-left": "f036",
                    "align-center": "f037",
                    "align-right": "f038",
                    "align-justify": "f039",
                    "list": "f03a",
                    "dedent": "f03b",
                    "outdent": "f03b",
                    "indent": "f03c",
                    "video-camera": "f03d",
                    "photo": "f03e",
                    "image": "f03e",
                    "picture-o": "f03e",
                    "pencil": "f040",
                    "map-marker": "f041",
                    "adjust": "f042",
                    "tint": "f043",
                    "edit": "f03e",
                    "pencil-square-o": "f044",
                    "share-square-o": "f045",
                    "check-square-o": "f046",
                    "arrows": "f047",
                    "step-backward": "f048",
                    "fast-backward": "f049",
                    "backward": "f04a",
                    "play": "f04b",
                    "pause": "f04c",
                    "stop": "f04d",
                    "forward": "f04e",
                    "fast-forward": "f050",
                    "step-forward": "f051",
                    "eject": "f052",
                    "chevron-left": "f053",
                    "chevron-right": "f054",
                    "plus-circle": "f055",
                    "minus-circle": "f056",
                    "times-circle": "f057",
                    "check-circle": "f058",
                    "question-circle": "f059",
                    "info-circle": "f05a",
                    "crosshairs": "f05b",
                    "times-circle-o": "f05c",
                    "check-circle-o": "f05d",
                    "ban": "f05e",
                    "arrow-left": "f060",
                    "arrow-right": "f061",
                    "arrow-up": "f062",
                    "arrow-down": "f063",
                    "mail-forward": "f064",
                    "share": "f064",
                    "expand": "f065",
                    "compress": "f066",
                    "plus": "f067",
                    "minus": "f068",
                    "asterisk": "f069",
                    "exclamation-circle": "f06a",
                    "gift": "f06b",
                    "leaf": "f06c",
                    "fire": "f06d",
                    "eye": "f06e",
                    "eye-slash": "f070",
                    "warning": "f071",
                    "exclamation-triangle": "f071",
                    "plane": "f072",
                    "calendar": "f073",
                    "random": "f074",
                    "comment": "f075",
                    "magnet": "f076",
                    "chevron-up": "f077",
                    "chevron-down": "f078",
                    "retweet": "f079",
                    "shopping-cart": "f07a",
                    "folder": "f07b",
                    "folder-open": "f07c",
                    "arrows-v": "f07d",
                    "arrows-h": "f07e",
                    "bar-chart-o": "f080",
                    "bar-chart": "f080",
                    "twitter-square": "f081",
                    "facebook-square": "f082",
                    "camera-retro": "f083",
                    "key": "f084",
                    "gears": "f085",
                    "cogs": "f085",
                    "comments": "f086",
                    "thumbs-o-up": "f087",
                    "thumbs-o-down": "f088",
                    "star-half": "f089",
                    "heart-o": "f08a",
                    "sign-out": "f08b",
                    "linkedin-square": "f08c",
                    "thumb-tack": "f08d",
                    "external-link": "f08e",
                    "sign-in": "f090",
                    "trophy": "f091",
                    "github-square": "f092",
                    "upload": "f093",
                    "lemon-o": "f094",
                    "phone": "f095",
                    "square-o": "f096",
                    "bookmark-o": "f097",
                    "phone-square": "f098",
                    "twitter": "f099",
                    "facebook": "f09a",
                    "github": "f09b",
                    "unlock": "f09c",
                    "credit-card": "f09d",
                    "rss": "f09e",
                    "hdd-o": "f0a0",
                    "bullhorn": "f0a1",
                    "bell": "f0f3",
                    "certificate": "f0a3",
                    "hand-o-right": "f0a4",
                    "hand-o-left": "f0a5",
                    "hand-o-up": "f0a6",
                    "hand-o-down": "f0a7",
                    "arrow-circle-left": "f0a8",
                    "arrow-circle-right": "f0a9",
                    "arrow-circle-up": "f0aa",
                    "arrow-circle-down": "f0ab",
                    "globe": "f0ac",
                    "wrench": "f0ad",
                    "tasks": "f0ae",
                    "filter": "f0b0",
                    "briefcase": "f0b1",
                    "arrows-alt": "f0b2",
                    "group": "f0c0",
                    "users": "f0c0",
                    "chain": "f0c1",
                    "link": "f0c1",
                    "cloud": "f0c2",
                    "flask": "f0c3",
                    "cut": "f0c4",
                    "scissors": "f0c4",
                    "copy": "f0c5",
                    "files-o": "f0c5",
                    "paperclip": "f0c6",
                    "save": "f0c7",
                    "floppy-o": "f0c7",
                    "square": "f0c8",
                    "navicon": "f0c9",
                    "reorder": "f0c9",
                    "bars": "f0c9",
                    "list-ul": "f0ca",
                    "list-ol": "f0cb",
                    "strikethrough": "f0cc",
                    "underline": "f0cd",
                    "table": "f0ce",
                    "magic": "f0d0",
                    "truck": "f0d1",
                    "pinterest": "f0d2",
                    "pinterest-square": "f0d3",
                    "google-plus-square": "f0d4",
                    "google-plus": "f0d5",
                    "money": "f0d6",
                    "caret-down": "f0d7",
                    "caret-up": "f0d8",
                    "caret-left": "f0d9",
                    "caret-right": "f0da",
                    "columns": "f0db",
                    "unsorted": "f0dc",
                    "sort": "f0dc",
                    "sort-down": "f0dd",
                    "sort-desc": "f0dd",
                    "sort-up": "f0de",
                    "sort-asc": "f0de",
                    "envelope": "f0e0",
                    "linkedin": "f0e1",
                    "rotate-left": "f0e2",
                    "undo": "f0e2",
                    "legal": "f0e3",
                    "gavel": "f0e3",
                    "dashboard": "f0e4",
                    "tachometer": "f0e4",
                    "comment-o": "f0e5",
                    "comments-o": "f0e6",
                    "flash": "f0e7",
                    "bolt": "f0e7",
                    "sitemap": "f0e8",
                    "umbrella": "f0e9",
                    "paste": "f0ea",
                    "clipboard": "f0ea",
                    "lightbulb-o": "f0eb",
                    "exchange": "f0ec",
                    "cloud-download": "f0ed",
                    "cloud-upload": "f0ee",
                    "user-md": "f0f0",
                    "stethoscope": "f0f1",
                    "suitcase": "f0f2",
                    "bell-o": "f0a2",
                    "coffee": "f0f4",
                    "cutlery": "f0f5",
                    "file-text-o": "f0f6",
                    "building-o": "f0f7",
                    "hospital-o": "f0f8",
                    "ambulance": "f0f9",
                    "medkit": "f0fa",
                    "fighter-jet": "f0fb",
                    "beer": "f0fc",
                    "h-square": "f0fd",
                    "plus-square": "f0fe",
                    "angle-double-left": "f100",
                    "angle-double-right": "f101",
                    "angle-double-up": "f102",
                    "angle-double-down": "f103",
                    "angle-left": "f104",
                    "angle-right": "f105",
                    "angle-up": "f106",
                    "angle-down": "f107",
                    "desktop": "f108",
                    "laptop": "f109",
                    "tablet": "f10a",
                    "mobile-phone": "f10b",
                    "mobile": "f10b",
                    "circle-o": "f10c",
                    "quote-left": "f10d",
                    "quote-right": "f10e",
                    "spinner": "f110",
                    "circle": "f111",
                    "mail-reply": "f112",
                    "reply": "f112",
                    "github-alt": "f113",
                    "folder-o": "f114",
                    "folder-open-o": "f115",
                    "smile-o": "f118",
                    "frown-o": "f119",
                    "meh-o": "f11a",
                    "gamepad": "f11b",
                    "keyboard-o": "f11c",
                    "flag-o": "f11d",
                    "flag-checkered": "f11e",
                    "terminal": "f120",
                    "code": "f121",
                    "mail-reply-all": "f122",
                    "reply-all": "f122",
                    "star-half-empty": "f123",
                    "star-half-full": "f123",
                    "star-half-o": "f123",
                    "location-arrow": "f124",
                    "crop": "f125",
                    "code-fork": "f126",
                    "unlink": "f127",
                    "chain-broken": "f127",
                    "question": "f128",
                    "info": "f129",
                    "exclamation": "f12a",
                    "superscript": "f12b",
                    "subscript": "f12c",
                    "eraser": "f12d",
                    "puzzle-piece": "f12e",
                    "microphone": "f130",
                    "microphone-slash": "f131",
                    "shield": "f132",
                    "calendar-o": "f133",
                    "fire-extinguisher": "f134",
                    "rocket": "f135",
                    "maxcdn": "f136",
                    "chevron-circle-left": "f137",
                    "chevron-circle-right": "f138",
                    "chevron-circle-up": "f139",
                    "chevron-circle-down": "f13a",
                    "html5": "f13b",
                    "css3": "f13c",
                    "anchor": "f13d",
                    "unlock-alt": "f13e",
                    "bullseye": "f140",
                    "ellipsis-h": "f141",
                    "ellipsis-v": "f142",
                    "rss-square": "f143",
                    "play-circle": "f144",
                    "ticket": "f145",
                    "minus-square": "f146",
                    "minus-square-o": "f147",
                    "level-up": "f148",
                    "level-down": "f149",
                    "check-square": "f14a",
                    "pencil-square": "f14b",
                    "external-link-square": "f14c",
                    "share-square": "f14d",
                    "compass": "f14e",
                    "toggle-down": "f150",
                    "caret-square-o-down": "f150",
                    "toggle-up": "f151",
                    "caret-square-o-up": "f151",
                    "toggle-right": "f152",
                    "caret-square-o-right": "f152",
                    "euro": "f153",
                    "eur": "f153",
                    "gbp": "f154",
                    "dollar": "f155",
                    "usd": "f155",
                    "rupee": "f156",
                    "inr": "f156",
                    "cny": "f157",
                    "rmb": "f157",
                    "yen": "f157",
                    "jpy": "f157",
                    "ruble": "f158",
                    "rouble": "f158",
                    "rub": "f158",
                    "won": "f159",
                    "krw": "f159",
                    "bitcoin": "f15a",
                    "btc": "f15a",
                    "file": "f15b",
                    "file-text": "f15c",
                    "sort-alpha-asc": "f15d",
                    "sort-alpha-desc": "f15e",
                    "sort-amount-asc": "f160",
                    "sort-amount-desc": "f161",
                    "sort-numeric-asc": "f162",
                    "sort-numeric-desc": "f163",
                    "thumbs-up": "f164",
                    "thumbs-down": "f165",
                    "youtube-square": "f166",
                    "youtube": "f167",
                    "xing": "f168",
                    "xing-square": "f169",
                    "youtube-play": "f16a",
                    "dropbox": "f16b",
                    "stack-overflow": "f16c",
                    "instagram": "f16d",
                    "flickr": "f16e",
                    "adn": "f170",
                    "bitbucket": "f171",
                    "bitbucket-square": "f172",
                    "tumblr": "f173",
                    "tumblr-square": "f174",
                    "long-arrow-down": "f175",
                    "long-arrow-up": "f176",
                    "long-arrow-left": "f177",
                    "long-arrow-right": "f178",
                    "apple": "f179",
                    "windows": "f17a",
                    "android": "f17b",
                    "linux": "f17c",
                    "dribbble": "f17d",
                    "skype": "f17e",
                    "foursquare": "f180",
                    "trello": "f181",
                    "female": "f182",
                    "male": "f183",
                    "gittip": "f184",
                    "sun-o": "f185",
                    "moon-o": "f186",
                    "archive": "f187",
                    "bug": "f188",
                    "vk": "f189",
                    "weibo": "f18a",
                    "renren": "f18b",
                    "pagelines": "f18c",
                    "stack-exchange": "f18d",
                    "arrow-circle-o-right": "f18e",
                    "arrow-circle-o-left": "f190",
                    "toggle-left": "f191",
                    "caret-square-o-left": "f191",
                    "dot-circle-o": "f192",
                    "wheelchair": "f193",
                    "vimeo-square": "f194",
                    "turkish-lira": "f195",
                    "try": "f195",
                    "plus-square-o": "f196",
                    "space-shuttle": "f197",
                    "slack": "f198",
                    "envelope-square": "f199",
                    "wordpress": "f19a",
                    "openid": "f19b",
                    "institution": "f19c",
                    "bank": "f19c",
                    "university": "f19c",
                    "mortar-board": "f19d",
                    "graduation-cap": "f19d",
                    "yahoo": "f19e",
                    "google": "f1a0",
                    "reddit": "f1a1",
                    "reddit-square": "f1a2",
                    "stumbleupon-circle": "f1a3",
                    "stumbleupon": "f1a4",
                    "delicious": "f1a5",
                    "digg": "f1a6",
                    "pied-piper": "f1a7",
                    "pied-piper-alt": "f1a8",
                    "drupal": "f1a9",
                    "joomla": "f1aa",
                    "language": "f1ab",
                    "fax": "f1ac",
                    "building": "f1ad",
                    "child": "f1ae",
                    "paw": "f1b0",
                    "spoon": "f1b1",
                    "cube": "f1b2",
                    "cubes": "f1b3",
                    "behance": "f1b4",
                    "behance-square": "f1b5",
                    "steam": "f1b6",
                    "steam-square": "f1b7",
                    "recycle": "f1b8",
                    "automobile": "f1b9",
                    "car": "f1b9",
                    "cab": "f1ba",
                    "taxi": "f1ba",
                    "tree": "f1bb",
                    "spotify": "f1bc",
                    "deviantart": "f1bd",
                    "soundcloud": "f1be",
                    "database": "f1c0",
                    "file-pdf-o": "f1c1",
                    "file-word-o": "f1c2",
                    "file-excel-o": "f1c3",
                    "file-powerpoint-o": "f1c4",
                    "file-photo-o": "f1c5",
                    "file-picture-o": "f1c5",
                    "file-image-o": "f1c5",
                    "file-zip-o": "f1c6",
                    "file-archive-o": "f1c6",
                    "file-sound-o": "f1c7",
                    "file-audio-o": "f1c7",
                    "file-movie-o": "f1c8",
                    "file-video-o": "f1c8",
                    "file-code-o": "f1c9",
                    "vine": "f1ca",
                    "codepen": "f1cb",
                    "jsfiddle": "f1cc",
                    "life-bouy": "f1cd",
                    "life-buoy": "f1cd",
                    "life-saver": "f1cd",
                    "support": "f1cd",
                    "life-ring": "f1cd",
                    "circle-o-notch": "f1ce",
                    "ra": "f1d0",
                    "rebel": "f1d0",
                    "ge": "f1d1",
                    "empire": "f1d1",
                    "git-square": "f1d2",
                    "git": "f1d3",
                    "hacker-news": "f1d4",
                    "tencent-weibo": "f1d5",
                    "qq": "f1d6",
                    "wechat": "f1d7",
                    "weixin": "f1d7",
                    "send": "f1d8",
                    "paper-plane": "f1d8",
                    "send-o": "f1d9",
                    "paper-plane-o": "f1d9",
                    "history": "f1da",
                    "circle-thin": "f1db",
                    "header": "f1dc",
                    "paragraph": "f1dd",
                    "sliders": "f1de",
                    "share-alt": "f1e0",
                    "share-alt-square": "f1e1",
                    "bomb": "f1e2",
                    "soccer-ball-o": "f1e3",
                    "futbol-o": "f1e3",
                    "tty": "f1e4",
                    "binoculars": "f1e5",
                    "plug": "f1e6",
                    "slideshare": "f1e7",
                    "twitch": "f1e8",
                    "yelp": "f1e9",
                    "newspaper-o": "f1ea",
                    "wifi": "f1eb",
                    "calculator": "f1ec",
                    "paypal": "f1ed",
                    "google-wallet": "f1ee",
                    "cc-visa": "f1f0",
                    "cc-mastercard": "f1f1",
                    "cc-discover": "f1f2",
                    "cc-amex": "f1f3",
                    "cc-paypal": "f1f4",
                    "cc-stripe": "f1f5",
                    "bell-slash": "f1f6",
                    "bell-slash-o": "f1f7",
                    "trash": "f1f8",
                    "copyright": "f1f9",
                    "at": "f1fa",
                    "eyedropper": "f1fb",
                    "paint-brush": "f1fc",
                    "birthday-cake": "f1fd",
                    "area-chart": "f1fe",
                    "pie-chart": "f200",
                    "line-chart": "f201",
                    "lastfm": "f202",
                    "lastfm-square": "f203",
                    "toggle-off": "f204",
                    "toggle-on": "f205",
                    "bicycle": "f206",
                    "bus": "f207",
                    "ioxhost": "f208",
                    "angellist": "f209",
                    "cc": "f20a",
                    "shekel": "f20b",
                    "sheqel": "f20b",
                    "ils": "f20b",
                    "meanpath": "f20c"
                };
                return fontAwesome[name.substring(3, name.length)];
            };


            uiw.gRegion$ = $('#' + uiw.element.attr('id'), apex.gPageContext$);
            this._buildTemplate();

            uiw.gRegion$
                .on("apexrefresh", uiw._refresh.bind(uiw))
                .trigger("apexrefresh");



        }, // _create   

        _init: function() {
            var uiw = this;


        }, // _init

        _buildTemplate: function() {
            var uiw = this;
            // Find our region and chart DIV containers
            uiw.gRegion$ = $('#' + uiw.element.attr('id'), apex.gPageContext$);
            uiw.gRegionBody$ = uiw.gRegion$.find(".t-Region-body");

            // if there is no region body container, add one on the fly.
            if (uiw.gRegionBody$.length === 0) {
                var outHTML = util.htmlBuilder();
                outHTML.markup('<div class="t-Region-bodyWrap"><div class="t-Region-body circliContainer"></div></div>');
                uiw.gRegionBody$ = uiw.gRegion$.append(outHTML.toString()).find(".t-Region-body");
            } else {
                uiw.gRegionBody$.addClass('circliContainer');
            }




            // No Data Found container

            // Create "No Data" container
            var noDataTemplate = util.htmlBuilder();
            noDataTemplate.markup('<div class="a-CircliGauge-message a-CircliGauge-noDataFound-container">')
                .markup('<div class="a-CircliGauge-messageIcon  a-CircliGauge-noDataFound">')
                .markup('<span class="a-Icon icon-irr-help"></span></div>')
                .markup('<span class="a-CircliGauge-messageText">#MSG#</span></div>');

            uiw.gNoData$ = $(noDataTemplate.toString().replace('#MSG#', uiw.options.noDataFoundMessage)).hide();
            uiw.gRegionBody$.after(uiw.gNoData$);



        },


        _draw: function(data) {
            var uiw = this;
            gOptions = uiw.options;
            $.extend(this.options, data);

            for (var i = 0, size = this.options.chart.length; i < size; i++) {
                var cardRegtHTML = util.htmlBuilder(),
                    chart = uiw.element.attr('id') + '_' + 'circli_' + (i + 1),
                    template = util.htmlBuilder(),
                    finTempl;


                template.markup('<div class="col col-#COL_SPAN#">');
                if (uiw.options.templateNo == 2) {
                    template.markup('<div class="t-Region t-Region--scrollBody t-Region-bodyWrap" role="group" aria-labelledby="' + uiw.element.attr('id') + '_chart_heading"><div class="t-Region-body">');

                } else if (uiw.options.templateNo == 3) {
                    template.markup('<div class="t-Region t-Region--scrollBody" role="group" aria-labelledby="' + uiw.element.attr('id') + '_chart_heading">')
                        .markup('<div class="t-Region-header"><div class="t-Region-headerItems t-Region-headerItems--title"><h2 class="t-Region-title" id="' + uiw.element.attr('id') + '_chart_heading">#REG_TITLE#</h2></div>')
                        .markup('</div><div class="t-Region-bodyWrap"><div class="t-Region-body">');
                }



                template.markup('<span id = "' + chart + '"></span>');

                if (uiw.options.templateNo == 1) {
                    template.markup('</div>');
                } else if (uiw.options.templateNo == 2) {
                    template.markup('</div></div>');

                } else {
                    template.markup('</div></div></div></div>');
                }

                finTempl = template.toString().replace('#COL_SPAN#', uiw.options.chart[i].colSpan);

                if (uiw.options.templateNo == 3) {
                    finTempl = finTempl.replace('#REG_TITLE#', uiw.options.chart[i].text);

                } else {
                    finTempl = finTempl.replace('#REG_TITLE#', '');
                }


                if (uiw.options.templateNo == 3) {
                    uiw.options.chart[i].text = null;
                    uiw.options.chart[i].textBelow = false;

                }

                // finTempl = util.applyTemplate(cardRegtHTML.toString(), templOpts);

                // gRegionBody$.append(cardRegtHTML.toString());
                // var cardReg$ = $(cardRegtHTML.toString());
                uiw.gRegionBody$.append(finTempl);
                // Time to draw the chart!
                // apex.jQuery('#' + util.escapeCSS(pRegionId)).circliful(gChartOptions);


                if ((this.options.chart[i].iconFA !== '' ||
                        this.options.chart[i].iconFA !== null) && this.options.chart[i].iconFA != undefined) {

                    this.options.chart[i].icon = uiw.getIconUnicode(this.options.chart[i].iconFA);
                }

                $('#' + chart).circliful(this.options.chart[i]);

            } //for loop


        }, // _draw

        _debug: function(i) {
            apex.debug.log(i);
        },

        // Removes everything inside the chart DIV
        _clear: function() {}, // _clear


        // Called by the APEX refresh event to get new chart data
        _refresh: function() {
            var uiw = this,

                // gRegion$ = $('#' + uiw.element.attr('id'), apex.gPageContext$),
                // gRegionBody$ = gRegion$.find(".t-Region-body"),
                lSpinner$;

            apex.server.plugin(
                uiw.options.ajaxIdentifier, { pageItems: uiw.options.pageItems }, {
                    dataType: "json",
                    accept: "application/json",
                    beforeSend: function() {
                        lSpinner$ = apex.util.showSpinner(uiw.gRegion$);
                    },
                    success: function(gReturn) {

                        if (gReturn.chart.length >= 1) {
                            uiw.gNoData$.hide();
                            uiw.gRegionBody$.show();
                            uiw.gRegionBody$.html('');
                            uiw._draw(gReturn);
                        } else {
                            uiw.gRegionBody$.hide();
                            uiw.gNoData$.show();
                        }

                    },

                    complete: function(data) {

                        lSpinner$.remove();
                    },
                    error: uiw._debug,
                    clear: uiw._clear

                }
            );


        }, // _refresh

        _createTag: function(tag) {
            return $(document.createElement(tag));
        }

    }); // ui.circlifulGuuge

})(apex.util, apex.server, apex.jQuery);