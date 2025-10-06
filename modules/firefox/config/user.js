/* My Firefox (and Firefox-based)-browser "user.js".
* Based on:
* https://github.com/arkenfox/user.js/blob/master/user.js
* https://github.com/yokoffing/Betterfox/blob/main/Fastfox.js
*/

/* 1. CUSTOM */
user_pref("browser.urlbar.suggest.calculator", true); // Calculator in URL bar
user_pref("browser.urlbar.unitConversion.enabled", true); // Units in URL bar
user_pref("browser.urlbar.trimURLs", false); // Don't trim HTTP/HTTPS
user_pref("browser.tabs.closeWindowWithLastTab", false); // Don't close Firefox when last tab closed
user_pref("browser.tabs.loadBookmarksInTabs", true); // Open bookmark in new tab
user_pref("browser.tabs.min_inactive_duration_before_unload", 30000) // Unload tabs after 30secs
user_pref("browser.ctrlTab.sortByRecentlyUsed", true); // Cycle ctrl+tab thru recently used
user_pref("browser.compactmode.show", true); // Compact mode
user_pref("browser.bookmarks.openInTabClosesMenu", false);
//user_pref("browser.backspace_action", 0); // Restore backspace to return to previous page
user_pref("browser.toolbars.bookmarks.visibility", "never"); // Always show bookmarks bar
user_pref("browser.vpn_promo.enabled", false); // Bye bye VPN promo
user_pref("extensions.pocket.enabled", false); // I don't use Firefox Pocket
user_pref("middlemouse.paste", false); // No paste with mousewheel click
user_pref("widget.non-native-theme.scrollbar.style", 4); // Win10 like scrollbar
user_pref("devtools.chrome.enabled", true); // Enable devtools
user_pref("findbar.highlightAll", true); // Highlight all by default with find
user_pref("image.http.accept", "*/*"); // Remove webp as the default image format. Default = "image/webp,*/*"
//user_pref("sidebar.revamp", true); // Vertical tabs in FF nightly
user_pref("sidebar.verticalTabs", true); // NEW vertical tabs option
user_pref("sidebar.visibility", "always-show"); // Always show sidebar
user_pref("layout.word_select.eat_space_to_next_word", false); // Don't select the space next to a word when selecting a word


/* 2. Fastfox version: 137 */
/****************************************************************************
 * SECTION: GENERAL                                                        *
 ****************************************************************************/
user_pref("content.notify.interval", 100000); // (.10s); default=120000 (.12s)
user_pref("browser.startup.preXulSkeletonUI", false);
user_pref("dom.iframe_lazy_loading.enabled", true); // DEFAULT [FF121+]

/****************************************************************************
 * SECTION: GFX RENDERING TWEAKS                                            *
 ****************************************************************************/
user_pref("gfx.webrender.all", true); // enables WR + additional features
user_pref("gfx.webrender.precache-shaders", true); // longer initial startup time
  user_pref("gfx.webrender.compositor.force-enabled", true); // enforce
user_pref("layers.gpu-process.enabled", true); // DEFAULT WINDOWS
  user_pref("layers.gpu-process.force-enabled", true); // enforce
user_pref("media.hardware-video-decoding.enabled", true); // DEFAULT WINDOWS macOS
  user_pref("media.hardware-video-decoding.force-enabled", true); // enforce
user_pref("gfx.webrender.dcomp-video-hw-overlay-win", true); // DEFAULT
  user_pref("gfx.webrender.dcomp-video-hw-overlay-win-force-enabled", true); // enforce
user_pref("gfx.webrender.dcomp-video-sw-overlay-win", true); // DEFAULT
  user_pref("gfx.webrender.dcomp-video-sw-overlay-win-force-enabled", true); // enforce

/****************************************************************************
 * SECTION: DISK CACHE                                                     *
 ****************************************************************************/
user_pref("browser.cache.disk.enable", false);
user_pref("browser.cache.disk.smart_size.enabled", false); // force a fixed max cache size on disk
user_pref("browser.cache.disk.capacity", 512000); // default=256000; size of disk cache; 1024000=1GB, 2048000=2GB
user_pref("browser.cache.disk.max_entry_size", 51200); // DEFAULT (50 MB); maximum size of an object in disk cache
user_pref("network.http.rcwn.enabled", false);
user_pref("network.http.rcwn.small_resource_size_kb", 256); // DEFAULT
user_pref("browser.cache.disk.metadata_memory_limit", 500); // default=250 (0.25 MB); limit of recent metadata we keep in memory for faster access
user_pref("browser.cache.disk.preload_chunk_count", 4); // DEFAULT
user_pref("browser.cache.frecency_half_life_hours", 6); // DEFAULT
user_pref("browser.cache.disk.max_chunks_memory_usage", 40960); // DEFAULT (40 MB)
user_pref("browser.cache.disk.max_priority_chunks_memory_usage", 40960); // DEFAULT (40 MB)
user_pref("browser.cache.check_doc_frequency", 3); // DEFAULT
user_pref("browser.cache.disk.free_space_soft_limit", 10240); // default=5120 (5 MB)
user_pref("browser.cache.disk.free_space_hard_limit", 2048); // default=1024 (1 MB)
user_pref("browser.cache.jsbc_compression_level", 3);

/****************************************************************************
 * SECTION: MEMORY CACHE                                                   *
 ****************************************************************************/
user_pref("browser.cache.memory.capacity", 131072); // DEFAULT; 256000=256 MB; 512000=500 MB; 1048576=1GB, 2097152=2GB
user_pref("browser.cache.memory.max_entry_size", 20480); // (10 MB); default=5120 (5 MB)
user_pref("browser.sessionhistory.max_total_viewers", 4);

/****************************************************************************
 * SECTION: MEDIA CACHE                                                     *
 ****************************************************************************/
user_pref("media.cache_size", 512000); // DEFAULT
user_pref("media.memory_cache_max_size", 65536); // default=8192; AF=65536; alt=131072
user_pref("media.memory_caches_combined_limit_kb", 524288); // DEFAULT; alt=1048576
user_pref("media.memory_caches_combined_limit_pc_sysmem", 5); // DEFAULT; alt=10; the percentage of system memory that Firefox can use for media caches
user_pref("media.mediasource.enabled", true); // DEFAULT
user_pref("media.cache_readahead_limit", 7200); // 120 min; default=60; stop reading ahead when our buffered data is this many seconds ahead of the current playback
user_pref("media.cache_resume_threshold", 3600); // 60 min; default=30; when a network connection is suspended, don't resume it until the amount of buffered data falls below this threshold

/****************************************************************************
 * SECTION: IMAGE CACHE                                                     *
 ****************************************************************************/
user_pref("image.cache.size", 5242880); // DEFAULT; in MiB; alt=10485760 (cache images up to 10MiB in size)
user_pref("image.mem.decode_bytes_at_a_time", 32768); // default=16384; alt=65536; chunk size for calls to the image decoders
user_pref("image.mem.shared.unmap.min_expiration_ms", 120000); // default=60000; minimum timeout to unmap shared surfaces since they have been last used

/****************************************************************************
 * SECTION: NETWORK                                                         *
 ****************************************************************************/
user_pref("network.buffer.cache.size", 65535); // default=32768 (32 kb); 262144 too large
user_pref("network.buffer.cache.count", 48); // default=24
user_pref("network.http.max-connections", 1800); // default=900
user_pref("network.http.max-persistent-connections-per-server", 10); // default=6; download connections; anything above 10 is excessive
  user_pref("network.http.max-urgent-start-excessive-connections-per-host", 5); // default=3
  user_pref("network.http.max-persistent-connections-per-proxy", 48); // default=32
user_pref("network.websocket.max-connections", 200); // DEFAULT
user_pref("network.http.pacing.requests.enabled", false);
  user_pref("network.http.pacing.requests.min-parallelism", 10); // default=6
  user_pref("network.http.pacing.requests.burst", 14); // default=1
user_pref("network.dnsCacheEntries", 1000); // default=400
user_pref("network.dnsCacheExpiration", 3600); // keep entries for 1 hour
  user_pref("network.dnsCacheExpirationGracePeriod", 240); // default=60; cache DNS entries for 4 minutes after they expire
user_pref("network.dns.max_high_priority_threads", 40); // DEFAULT [FF 123?]
user_pref("network.dns.max_any_priority_threads", 24); // DEFAULT [FF 123?]
user_pref("network.ssl_tokens_cache_capacity", 10240); // default=2048; more TLS token caching (fast reconnects)

/****************************************************************************
 * SECTION: SPECULATIVE LOADING                                            *
 ****************************************************************************/
user_pref("network.dns.disablePrefetch", true);
  user_pref("network.dns.disablePrefetchFromHTTPS", true); // [FF127+ false]
user_pref("network.prefetch-next", false);
user_pref("network.predictor.enabled", false);



/* 3. Arkenfox version: 135 */
/*** [SECTION 0100]: STARTUP ***/
user_pref("browser.startup.page", 1);
user_pref("browser.startup.homepage", "https://searx.l.zzzealed.com/preferences?preferences=eJx1WMuO67gR_Zp4Y0xjJjdIkIVXAbJNgMzeoMiSVCOK1OXDtvrrc6iHVWz1LOxuHZKlYj1PWatEnQ9M8daRo6DsxSrXZdXRTeXkL9ZrZelG7lIetR8nS4luTVAPurTqwdq7e6Do7YPC7cIjTt6n4F_z7d_KRrqMlHpvbv_9z_9-v0TVUiQVdH_79ZJ6GukWuUi8QEK2Kd4hzNHznlSzHTeeD_Fe4fHDh-6yHrvHNNtNUU0uUbgry50b8f92XpmHcprMfXvviv7MFOY7u3viBAG_h0wXdi07ThCqg7d2BddTRS29WmqGIEs6rcu9TwPN8WaoVdD_koO9tz6MKiV23a3N1l4MR9VYaECuYwdD__j7r5vY-2bzv_z1X2_w-mBDPt7v618sKd1mJ58tvZQzgZUUoOwE6VfLLr-uk9IDHAEpnMqai9gLwy7HnYLPjNrWGsUmS0ELcF0cWc4vf9_woLh9n8QVq4OcdJ9hwEPVZmrkjpEMqw-t9YeRu_Q0BWopEBy1yYYLYgR4hze44Cv2NA9GeAiRM01fHs-qF7Bc_m0CQzGpxAA8ojAAwStmbf3ZL4SXsjk2qglxdx3VhMP4BvLbS7yqDewGVlpC8yzOd8SfPWJQIN6bQMoICPFDcK-9luySN-kVEq98bWbq6bX_531nd-uxvU4-pvd9-9wh9LpWaboalVSktIeGXIoIm3fM8GiaQyN2SjiMJwpIlVloxj95ZrHlD469P84jLLuHqmMhKT0pt71u5OJy36arhQ8O9AWvZNhvzJF1Qfxnz5Wc59hYCbhiNHyEMiPy8KEMKletwgFfl4ImF9cU4mLFRZUJlzYfixqHNojbc8i8wXMkHkt7ln93rIrVKTfIlsemxc-swiBPLcD5RT-fyiW5L3DXJzjfV6BPCaXSI948ifhb9RjnWMqh2B9pYrVf-G3d6DtfVZAFOOu0wqfytsJP0r06InZ9ifaGruVru32kEddifY2691YFWR1SeQtwVaki0U30rJArcs-Tm7l-HrjxfohfwZ_Z1_YoYPQ56DM6ETQ7SXjDh94FRm-LSzrVux9-Lt1URuw80ogmdE0BNd2iTBi5bLIhJ9346dRYnfd_EA1n5OysDa9CcfSovhNbn453OKRNqNKvAGd5K1yJW6FTPITczB2Nex2aiELKjewXSxvB-4fSDJ7UiKVZ6cqM5fmsjIXFl2InTj79iwfvkGvXODvvYGlpSRq-aL9C5yBf4HOQw2G6Ssj46AJNXhzNr-fSUd_Aw7NZ-vlmihITIzhKdcE8jnauuklVVIbuo_OigERy4DecEMz7_S7kaoLyz05Bjeh1aUGLsUvjM76BacABB6GiQNdLS54i1lQ27I-6qZxT8VpSnEvVbdmu0qbhOnIIPkisNFx8F0lBbi6lcqU7xTDb_Ry_fJSACollO1bhxQ-ZgCpWCdGAWmk1ToeyRdhUrFCTHcvlI8kOvPcNbypoFTkLcooQsKcm64H2ftMkw113XNdP5EqdICFb99QOvhTj3f1Lt2xRGklVYaJzKPSqyg1D9Flyd78ngoRRXmEw8QpjuivYbWHGvHARcR6ORQL3uRHxWehFXZL0UD6d_x49G0ysnYwk1mpCd-BPKqUhCGqHUrb7b8fAzmmuKiulefQO4SSyvjXBF-63uwBWMAldCjVYeqG1rIdQkUBC3IPLPOGHq-GAeaFMDquV8E7O8TB7Vzqw3xcxj6jmeDiMW9pgQ6E71ghU2o_788b_jhutyNm-G17Zb8NO9t7wb9rttjJZNZfkjIeV5MrSMaTAXpWYWd-9EX00sfjBuwEEH30T0S5L6w6wtorihZbGcQZNGMdconRpr3XtWnfkiPT5k7VCl_9srUiGj75ZZrBGNONi88hCo89ftiWh5LbXt5DnUPpj3ZCaQO-eLr1ofRMTfYTdXqNCGTTe_clt3su9ij3Izzc7zE6u3bQHj5uVOlQFxxqY9hHDmxk9TbgQs7Ea9xmwVCWFAD-miiNE9jUwWGSI2upHvf62055zBcRoQL6G0D-JEgaufeoqYOmfwuqTKSzhkD9hOsfgvh3AdIyhiqIsbgunF1ebuERjo4TfJo9uEFEvTBm1dpXWK10NmDO7NcWObnaIz81Y5AuV5mnvSwtDr7Nwhb7n8t_wJIWWirnFP6Os4vCF4XRyeyBM5kHQF5_R5-rZCkOxHjyaTGv9c2-fcchNdinv_CFj9svxHR6Go84xfkxz6v0eWVoZM3_sGbkXvol_QRmhEx5Ly5m-MN03-IV1veEz80JBHEWJ98MM_2MKHcqQufszessG1TisGb3DqZp2s4soX7GXvyGUqaHWZfb5CzF9I--Wqtiir5TQF9sePFZEqfTNSjKAcqRKjLKpWA5J9HG6u1w8BYpc_MLD5NJiisMiT2_bgES3U183dNbp07vKWb_9-PGP13E0ZIzkNbcOxvEgneNT6aYljL4E6lNZ22MycPJ6KYUPFpPNaVpfgLNdVvjMtRa4MjkK0VFk15muzwcX-5tgYqDghLbVpo1mriT6_TPfZDM6WLwhyO4gaHoo1Urd1x8yn6Dey7QalkZ4Lz8YBjCUh6Dhu4BSwreHJSaR1Wgd2JlWqqeszmgXfh1QbHtn1_oL4h7l8vZ_GwY7yg==");
user_pref("browser.newtabpage.enabled", true);
user_pref("browser.newtabpage.activity-stream.showSponsored", false); // [FF58+]
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false); // [FF83+] Shortcuts>Sponsored shortcuts
user_pref("browser.newtabpage.activity-stream.default.sites", "");

/*** [SECTION 0200]: GEOLOCATION ***/
user_pref("geo.provider.ms-windows-location", false); // [WINDOWS]
user_pref("geo.provider.use_corelocation", false); // [MAC]
user_pref("geo.provider.use_geoclue", false); // [FF102+] [LINUX]

/*** [SECTION 0300]: QUIETER FOX ***/
user_pref("extensions.getAddons.showPane", false); // [HIDDEN PREF]
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
user_pref("browser.discovery.enabled", false);
user_pref("browser.shopping.experience2023.enabled", false); // [DEFAULT: false]
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.telemetry", false);
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("app.normandy.enabled", false);
user_pref("app.normandy.api_url", "");
user_pref("breakpad.reportURL", "");
user_pref("browser.tabs.crashReporting.sendReport", false); // [FF44+]
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false); // [DEFAULT: false]
user_pref("captivedetect.canonicalURL", "");
user_pref("network.captive-portal-service.enabled", false); // [FF52+]
user_pref("network.connectivity-service.enabled", false);

/*** [SECTION 0400]: SAFE BROWSING (SB) ***/
user_pref("browser.safebrowsing.malware.enabled", true);
user_pref("browser.safebrowsing.phishing.enabled", true);
user_pref("browser.safebrowsing.downloads.enabled", true);
user_pref("browser.safebrowsing.downloads.remote.enabled", false);
user_pref("browser.safebrowsing.downloads.remote.block_potentially_unwanted", false);
user_pref("browser.safebrowsing.downloads.remote.block_uncommon", false);
user_pref("browser.safebrowsing.allowOverride", true);

/*** [SECTION 0600]: BLOCK IMPLICIT OUTBOUND [not explicitly asked for - e.g. clicked on] ***/
user_pref("network.prefetch-next", false);
user_pref("network.dns.disablePrefetch", true);
user_pref("network.dns.disablePrefetchFromHTTPS", true);
user_pref("network.predictor.enabled", false);
user_pref("network.predictor.enable-prefetch", false); // [FF48+] [DEFAULT: false]
user_pref("network.http.speculative-parallel-limit", 0);
user_pref("browser.places.speculativeConnect.enabled", false);

/*** [SECTION 0700]: DNS / DoH / PROXY / SOCKS ***/
user_pref("network.proxy.socks_remote_dns", true);
user_pref("network.file.disable_unc_paths", true); // [HIDDEN PREF]
user_pref("network.gio.supported-protocols", ""); // [HIDDEN PREF] [DEFAULT: ""]
user_pref("network.trr.mode", 5);

/*** [SECTION 0800]: LOCATION BAR / SEARCH BAR / SUGGESTIONS / HISTORY / FORMS ***/
user_pref("browser.urlbar.speculativeConnect.enabled", false);
user_pref("browser.urlbar.quicksuggest.enabled", false); // [FF92+]
user_pref("browser.urlbar.suggest.quicksuggest.nonsponsored", false); // [FF95+]
user_pref("browser.urlbar.suggest.quicksuggest.sponsored", false); // [FF92+]
user_pref("browser.search.suggest.enabled", false);
user_pref("browser.urlbar.suggest.searches", false);
user_pref("browser.urlbar.trending.featureGate", false);
user_pref("browser.urlbar.addons.featureGate", false); // [FF115+]
user_pref("browser.urlbar.fakespot.featureGate", false); // [FF130+] [DEFAULT: false]
user_pref("browser.urlbar.mdn.featureGate", false); // [FF117+] [HIDDEN PREF]
user_pref("browser.urlbar.pocket.featureGate", false); // [FF116+] [DEFAULT: false]
user_pref("browser.urlbar.weather.featureGate", false); // [FF108+] [DEFAULT: false]
user_pref("browser.urlbar.yelp.featureGate", false); // [FF124+]
user_pref("browser.urlbar.clipboard.featureGate", false);
user_pref("browser.formfill.enable", false);
user_pref("browser.urlbar.suggest.engines", false);
user_pref("layout.css.visited_links_enabled", false);
user_pref("browser.search.separatePrivateDefault", false); // [FF70+]
user_pref("browser.search.separatePrivateDefault.ui.enabled", true); // [FF71+]

/*** [SECTION 0900]: PASSWORDS ***/
user_pref("signon.autofillForms", false);
user_pref("signon.formlessCapture.enabled", false);
user_pref("network.auth.subresource-http-auth-allow", 1);
user_pref("network.http.windows-sso.enabled", false); // [DEFAULT: false]

/*** [SECTION 1000]: DISK AVOIDANCE ***/
user_pref("browser.cache.disk.enable", false);
user_pref("browser.privatebrowsing.forceMediaMemoryCache", true); // [FF75+]
user_pref("media.memory_cache_max_size", 65536);
user_pref("browser.sessionstore.privacy_level", 2);
user_pref("toolkit.winRegisterApplicationRestart", false);
user_pref("browser.shell.shortcutFavicons", false);

/*** [SECTION 1200]: HTTPS (SSL/TLS / OCSP / CERTS / HPKP) ***/
user_pref("security.ssl.require_safe_negotiation", true);
user_pref("security.tls.enable_0rtt_data", false);
user_pref("security.OCSP.enabled", 1); // [DEFAULT: 1]
user_pref("security.OCSP.require", false);
user_pref("security.cert_pinning.enforcement_level", 2);
user_pref("security.remote_settings.crlite_filters.enabled", true); // [DEFAULT: true FF137+]
user_pref("security.pki.crlite_mode", 2);
user_pref("security.mixed_content.block_display_content", true); // Defense-in-depth (see 1244)
user_pref("dom.security.https_only_mode", true); // [FF76+]
user_pref("dom.security.https_only_mode_pbm", true); // [FF80+]
user_pref("dom.security.https_only_mode.upgrade_local", false);
user_pref("dom.security.https_only_mode_send_http_background_request", false);
user_pref("security.ssl.treat_unsafe_negotiation_as_broken", true);
user_pref("browser.xul.error_pages.expert_bad_cert", true);

/*** [SECTION 1600]: REFERERS ***/
user_pref("network.http.referer.XOriginTrimmingPolicy", 2);

/*** [SECTION 1700]: CONTAINERS ***/
user_pref("privacy.userContext.enabled", true);
user_pref("privacy.userContext.ui.enabled", true);
user_pref("privacy.userContext.newTabContainerOnLeftClick.enabled", false);
user_pref("browser.link.force_default_user_context_id_for_external_opens", true);

/*** [SECTION 2000]: PLUGINS / MEDIA / WEBRTC ***/
user_pref("media.peerconnection.ice.proxy_only_if_behind_proxy", true);
user_pref("media.peerconnection.ice.default_address_only", true);
user_pref("media.peerconnection.ice.no_host", false);
user_pref("media.gmp-provider.enabled", false);

/*** [SECTION 2400]: DOM (DOCUMENT OBJECT MODEL) ***/
user_pref("dom.disable_window_move_resize", true);

/*** [SECTION 2600]: MISCELLANEOUS ***/
user_pref("browser.download.start_downloads_in_tmp_dir", true); // [FF102+]
user_pref("browser.helperApps.deleteTempFileOnExit", true);
user_pref("browser.uitour.enabled", false);
user_pref("devtools.debugger.remote-enabled", false); // [DEFAULT: false]
user_pref("permissions.default.shortcuts", 2);
user_pref("permissions.manager.defaultsUrl", "");
user_pref("webchannel.allowObject.urlWhitelist", "");
user_pref("network.IDN_show_punycode", true);
user_pref("pdfjs.disabled", false); // [DEFAULT: false]
user_pref("pdfjs.enableScripting", false); // [FF86+]
user_pref("browser.tabs.searchclipboardfor.middleclick", false); // [DEFAULT: false NON-LINUX]
user_pref("browser.contentanalysis.enabled", false); // [FF121+] [DEFAULT: false]
user_pref("browser.contentanalysis.default_result", 0); // [FF127+] [DEFAULT: 0]
user_pref("browser.download.useDownloadDir", true);
user_pref("browser.download.alwaysOpenPanel", true);
user_pref("browser.download.manager.addToRecentDocs", false);
user_pref("browser.download.always_ask_before_handling_new_types", false);
user_pref("extensions.enabledScopes", 5); // [HIDDEN PREF]
user_pref("extensions.postDownloadThirdPartyPrompt", false);

/*** [SECTION 2700]: ETP (ENHANCED TRACKING PROTECTION) ***/
user_pref("browser.contentblocking.category", "strict"); // [HIDDEN PREF]

/*** [SECTION 2800]: SHUTDOWN & SANITIZING ***/
user_pref("privacy.clearOnShutdown_v2.cache", true); // [DEFAULT: true]
user_pref("privacy.clearOnShutdown_v2.historyFormDataAndDownloads", true); // [DEFAULT: true]
user_pref("privacy.clearOnShutdown_v2.siteSettings", false); // [DEFAULT: false]

user_pref("privacy.clearOnShutdown_v2.browsingHistoryAndDownloads", true); // [DEFAULT: true]
user_pref("privacy.clearOnShutdown_v2.downloads", true);
user_pref("privacy.clearOnShutdown_v2.formdata", true);

user_pref("privacy.clearOnShutdown.openWindows", true);

user_pref("privacy.clearOnShutdown_v2.cookiesAndStorage", true);

user_pref("privacy.clearSiteData.cache", true);
user_pref("privacy.clearSiteData.cookiesAndStorage", false); // keep false until it respects "allow" site exceptions
user_pref("privacy.clearSiteData.historyFormDataAndDownloads", true);
user_pref("privacy.clearSiteData.siteSettings", false);
user_pref("privacy.clearSiteData.browsingHistoryAndDownloads", true);
user_pref("privacy.clearSiteData.formdata", true);

user_pref("privacy.clearHistory.cache", true); // [DEFAULT: true]
user_pref("privacy.clearHistory.cookiesAndStorage", false);
user_pref("privacy.clearHistory.historyFormDataAndDownloads", true); // [DEFAULT: true]

user_pref("privacy.clearHistory.browsingHistoryAndDownloads", true); // [DEFAULT: true]
user_pref("privacy.clearHistory.formdata", true);

user_pref("privacy.sanitize.timeSpan", 0);

/*** [SECTION 4000]: FPP (fingerprintingProtection) ***/
user_pref("privacy.fingerprintingProtection.pbmode", true); // [DEFAULT: true FF118+]
user_pref("privacy.fingerprintingProtection.overrides", "+AllTargets,-CSSPrefersColorScheme,-JSDateTimeUTC"); // This is NOT recommended by arkenfox. I just find it really annoying that websites don't respect dark theme and timezone.

/*** [SECTION 4500]: OPTIONAL RFP (resistFingerprinting) ***/
user_pref("privacy.window.maxInnerWidth", 1600);
user_pref("privacy.window.maxInnerHeight", 900);
user_pref("privacy.resistFingerprinting.block_mozAddonManager", true);
user_pref("privacy.resistFingerprinting.letterboxing", false); // [HIDDEN PREF]
user_pref("privacy.spoof_english", 1);
user_pref("browser.display.use_system_colors", true); // [DEFAULT: false NON-WINDOWS]
user_pref("widget.non-native-theme.use-theme-accent", true); // [DEFAULT: false WINDOWS]
user_pref("browser.link.open_newwindow", 3); // [DEFAULT: 3]
user_pref("browser.link.open_newwindow.restriction", 0);
user_pref("webgl.disabled", false);

/*** [SECTION 5000]: OPTIONAL OPSEC ***/
user_pref("browser.privatebrowsing.autostart", false);
user_pref("signon.rememberSignons", false);
user_pref("permissions.memory_only", false); // [HIDDEN PREF]
user_pref("security.nocertdb", false);
user_pref("browser.chrome.site_icons", true);
user_pref("browser.sessionstore.max_tabs_undo", 5);
user_pref("browser.sessionstore.resume_from_crash", false);
user_pref("browser.download.forbid_open_with", true);
user_pref("browser.urlbar.suggest.history", false);
user_pref("browser.urlbar.suggest.bookmark", false);
user_pref("browser.urlbar.suggest.openpage", true);
user_pref("browser.urlbar.suggest.topsites", false); // [FF78+]
user_pref("browser.urlbar.maxRichResults", 0);
user_pref("browser.urlbar.autoFill", false);
user_pref("places.history.enabled", true);
user_pref("browser.taskbar.lists.enabled", false);
user_pref("browser.taskbar.lists.frequent.enabled", false);
user_pref("browser.taskbar.lists.recent.enabled", false);
user_pref("browser.taskbar.lists.tasks.enabled", false);
user_pref("browser.download.folderList", 1);
user_pref("extensions.formautofill.addresses.enabled", false); // [FF55+]
user_pref("extensions.formautofill.creditCards.enabled", false); // [FF56+]
user_pref("dom.popup_allowed_events", "click dblclick mousedown pointerdown");
user_pref("browser.pagethumbnails.capturing_disabled", true); // [HIDDEN PREF]
user_pref("alerts.useSystemBackend.windows.notificationserver.enabled", false);
user_pref("keyword.enabled", true);

/*** [SECTION 5500]: OPTIONAL HARDENING ***/

/*** [SECTION 6000]: DON'T TOUCH ***/
user_pref("extensions.blocklist.enabled", true); // [DEFAULT: true]
user_pref("network.http.referer.spoofSource", false); // [DEFAULT: false]
user_pref("security.dialog_enable_delay", 1000); // [DEFAULT: 1000]
user_pref("privacy.firstparty.isolate", false); // [DEFAULT: false]
user_pref("extensions.webcompat.enable_shims", true); // [HIDDEN PREF] [DEFAULT: true]
user_pref("security.tls.version.enable-deprecated", false); // [DEFAULT: false]
user_pref("extensions.webcompat-reporter.enabled", false); // [DEFAULT: false]
user_pref("extensions.quarantinedDomains.enabled", true); // [DEFAULT: true]

/*** [SECTION 7000]: DON'T BOTHER ***/

/*** [SECTION 8000]: DON'T BOTHER: FINGERPRINTING ***/

/*** [SECTION 8500]: TELEMETRY ***/
user_pref("_user.js.parrot", "8500 syntax error: the parrot's off the twig!");

user_pref("datareporting.policy.dataSubmissionEnabled", false);

user_pref("datareporting.healthreport.uploadEnabled", false);

user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.enabled", false); // see [NOTE]
user_pref("toolkit.telemetry.server", "data:,");
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.newProfilePing.enabled", false); // [FF55+]
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false); // [FF55+]
user_pref("toolkit.telemetry.updatePing.enabled", false); // [FF56+]
user_pref("toolkit.telemetry.bhrPing.enabled", false); // [FF57+] Background Hang Reporter
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false); // [FF57+]

user_pref("toolkit.telemetry.coverage.opt-out", true); // [HIDDEN PREF]
user_pref("toolkit.coverage.opt-out", true); // [FF64+] [HIDDEN PREF]
user_pref("toolkit.coverage.endpoint.base", "");

/*** [SECTION 9000]: NON-PROJECT RELATED ***/
user_pref("browser.startup.homepage_override.mstone", "ignore"); // [HIDDEN PREF]
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);
user_pref("browser.urlbar.showSearchTerms.enabled", false);

/*** [SECTION 9999]: DEPRECATED / RENAMED ***/
