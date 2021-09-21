#!/bin/bash
# Author: John Ballen
# Date Created:09-08-2021
# Description: 
# Date Modified: 09-08-2021

#Google Maps and other Google services
pihole -w clients4.google.com 
pihole -w clients2.google.com

#YouTube history
pihole -w s.youtube.com 
pihole -w video-stats.l.google.com

#Google Play
pihole -w android.clients.google.com

#Google Keep
#The Google Keep Chrome App requires these domains to be whitelisted in order to sync.
pihole -w reminders-pa.googleapis.com firestore.googleapis.com

#Google Fonts
pihole -w gstaticadssl.l.google.com

#Gmail (Google Mail)
#iOS app requires this to be whitelisted for the app to connect.
pihole -w googleapis.l.google.com

#Google Chrome (to update on ubuntu)
pihole -w dl.google.com

#Android TV
#pihole -w redirector.gvt1.com


#Microsoft (Windows, Office, Skype, etc)
#Windows uses this to verify connectivity to Internet
pihole -w www.msftncsi.com

#Microsoft Web Pages (Outlook, Office365, Live, Microsoft.com...)
pihole -w outlook.office365.com products.office.com c.s-microsoft.com i.s-microsoft.com login.live.com login.microsoftonline.com 

#Backup bitlocker recovery key to Microsoft account
pihole -w g.live.com

#Microsoft Store (Windows Store)
pihole -w dl.delivery.mp.microsoft.com geo-prod.do.dsp.mp.microsoft.com displaycatalog.mp.microsoft.com

#Windows 10 Update
pihole -w sls.update.microsoft.com.akadns.net fe3.delivery.dsp.mp.microsoft.com.nsatc.net tlu.dl.delivery.mp.microsoft.com

#Microsoft Edge Browser Update
pihole -w msedge.api.cdp.microsoft.com

#Xbox Live
#This domain is used for sign-ins, creating new accounts, and recovering existing Microsoft accounts on your (confirmed by Microsoft)
pihole -w clientconfig.passport.net 

#Xbox Live Achievements (confirmed by Microsoft)
pihole -w v10.events.data.microsoft.com
pihole -w v20.events.data.microsoft.com

#Xbox Live Messaging (post)
pihole -w client-s.gateway.messenger.live.com

#Store App on Series X/S
pihole -w arc.msn.com

#EA Play on Xbox
pihole -w activity.windows.com

#Full Functionality
#There are several domains discovered initially on Reddit 422 and /r/xboxone 343, which were also confirmed by Microsoft as being required by Xbox Live for full functionality.
pihole -w xbox.ipv6.microsoft.com device.auth.xboxlive.com www.msftncsi.com title.mgt.xboxlive.com xsts.auth.xboxlive.com title.auth.xboxlive.com ctldl.windowsupdate.com attestation.xboxlive.com xboxexperiencesprod.experimentation.xboxlive.com xflight.xboxlive.com cert.mgt.xboxlive.com xkms.xboxlive.com def-vef.xboxlive.com notify.xboxlive.com help.ui.xboxlive.com licensing.xboxlive.com eds.xboxlive.com www.xboxlive.com v10.vortex-win.data.microsoft.com settings-win.data.microsoft.com

#Skype
#See the GitHub Topic 681 on these domains.
pihole -w s.gateway.messenger.live.com client-s.gateway.messenger.live.com ui.skype.com pricelist.skype.com apps.skype.com m.hotmail.com sa.symcb.com s{1..5}.symcb.com 

#Microsoft Office
#Reddit link - r/pihole - MS Office issues 533
pihole -w officeclient.microsoft.com

#Bing Maps Platform
#as described here 69.
#pihole -w dev.virtualearth.net ecn.dev.virtualearth.net t0.ssl.ak.dynamic.tiles.virtualearth.net t0.ssl.ak.tiles.virtualearth.net

#Apple
#Apple Music
#pihole -w itunes.apple.com
#pihole -w s.mzstatic.com

#Apple ID
#pihole -w appleid.apple.com
#Captive-portal tests
#These domains are checked by the operating systems when connecting via wifi, and if they don't get the response they expect, they may try to open a wifi login page or similar as they believe they are located behind a captive portal.

#Android/Chrome
pihole -w connectivitycheck.android.com android.clients.google.com clients3.google.com connectivitycheck.gstatic.com 

#Windows/Microsoft
pihole -w msftncsi.com www.msftncsi.com ipv6.msftncsi.com

#iOS/Apple
#(note that this does not cover all domains used older iOS versions)
#pihole -w captive.apple.com gsp1.apple.com www.apple.com www.appleiphonecell.com

#Other
#Jackbox.tv
#Jackbox.tv will not load unless you whitelist google-analytics. As of October 2020, this may no longer be necessary.

pihole -w www.google-analytics.com
pihole -w ssl.google-analytics.com

#Spotify
#The Spotify app for iOS will stop functioning unless it's web service counterpart is whitelisted.
pihole -w spclient.wg.spotify.com apresolve.spotify.com

#For spotify to work on TVs the API might need whitelisted:
pihole -w api-tv.spotify.com

#Target's Weekly Ads
#pihole -w weeklyad.target.com m.weeklyad.target.com weeklyad.target.com.edgesuite.net

#Facebook, Facebook Messenger
#pihole -w upload.facebook.com creative.ak.fbcdn.net external-lhr0-1.xx.fbcdn.net external-lhr1-1.xx.fbcdn.net external-lhr10-1.xx.fbcdn.net external-lhr2-1.xx.fbcdn.net external-lhr3-1.xx.fbcdn.net external-lhr4-1.xx.fbcdn.net external-lhr5-1.xx.fbcdn.net external-lhr6-1.xx.fbcdn.net external-lhr7-1.xx.fbcdn.net external-lhr8-1.xx.fbcdn.net external-lhr9-1.xx.fbcdn.net fbcdn-creative-a.akamaihd.net scontent-lhr3-1.xx.fbcdn.net scontent.xx.fbcdn.net scontent.fgdl5-1.fna.fbcdn.net graph.facebook.com b-graph.facebook.com connect.facebook.com cdn.fbsbx.com api.facebook.com edge-mqtt.facebook.com mqtt.c10r.facebook.com portal.fb.com star.c10r.facebook.com star-mini.c10r.facebook.com b-api.facebook.com fb.me bigzipfiles.facebook.com l.facebook.com www.facebook.com scontent-atl3-1.xx.fbcdn.net static.xx.fbcdn.net edge-chat.messenger.com video.xx.fbcdn.net external-ort2-1.xx.fbcdn.net scontent-ort2-1.xx.fbcdn.net edge-chat.facebook.com scontent-mia3-1.xx.fbcdn.net

#DirectTV
#Sourced from here 310.
#pihole -w directvnow.com directvapplications.hb.omtrdc.net s.zkcdn.net js.maxmind.com

#Bild DE
#pihole -w www.asadcdn.com code.bildstatic.de de.ioam.de json.bild.de script.ioam.de tags.tiqcdn.com tagger.opecloud.com
#Plex Domains
#pihole -w plex.tv tvdb2.plex.tv pubsub.plex.bz proxy.plex.bz proxy02.pop.ord.plex.bz cpms.spop10.ams.plex.bz meta-db-worker02.pop.ric.plex.bz meta.plex.bz tvthemes.plexapp.com.cdn.cloudflare.net tvthemes.plexapp.com 106c06cd218b007d-b1e8a1331f68446599e96a4b46a050f5.ams.plex.services meta.plex.tv cpms35.spop10.ams.plex.bz proxy.plex.tv metrics.plex.tv pubsub.plex.tv status.plex.tv www.plex.tv node.plexapp.com nine.plugins.plexapp.com staging.plex.tv app.plex.tv o1.email.plex.tv  o2.sg0.plex.tv dashboard.plex.tv

#Domains used by Plex
#pihole -w gravatar.com # custom login pictures
#pihole -w thetvdb.com # metadata for tv series
#pihole -w themoviedb.com # metadata for movies
#pihole -w chtbl.com # iHeart radio/Plex Podcast

#Sonarr
#pihole -w services.sonarr.tv skyhook.sonarr.tv download.sonarr.tv apt.sonarr.tv forums.sonarr.tv

#Placehold.it (Image placeholders often used during web design. Not sure why this is even blocked in the first place.)
#pihole -w placehold.it placeholdit.imgix.net

#Dropbox
#As described here 1.2k:
#pihole -w dl.dropboxusercontent.com ns1.dropbox.com ns2.dropbox.com

#Fox News
#as described here 657.
#pihole -w widget-cdn.rpxnow.com

#Images on Marketwatch.com
#pihole -w s.marketwatch.com

#GoDaddy webmail buttons
#pihole -w imagesak.secureserver.net

#WatchESPN
#as described here 249.
#pihole -w fpdownload.adobe.com entitlement.auth.adobe.com livepassdl.conviva.com

#NVIDIA GeForce Experience
#GFE requires this 250 to download driver updates (or events.gfe.nvidia.com, but that is also used for telemetry).
pihole -w gfwsl.geforce.com

#Videos not playing in times.com and nydailynews.com
#pihole -w delivery.vidible.tv img.vidible.tv videos.vidible.tv edge.api.brightcove.com cdn.vidible.tv

#Videos not playing on weather.com
#pihole -w v.w-x.co

#Moto phones OS updates
#pihole -w appspot-preview.l.google.com

#Grand Theft Auto V Online PC
#Since March blocking Rockstar telemetry seems to crash GTAOnline.
#Unblocking the domain fixed crashing for people at GTA Forums 102.
#pihole -w prod.telemetry.ros.rockstargames.com


#Epic Games Store
#The tracking domain is required to make a purchase on the website, otherwise the order modal will appear to be loading forever.
#It is also required when logging into the Epic Launcher when using two-factor authentication.
pihole -w tracking.epicgames.com

#Origin (Savegame-Sync)
pihole -w cloudsync-prod.s3.amazonaws.com

#Mozilla Firefox Tracking Protection
#Firefox updates the black- and whitelists for Tracking Protection daily using a domain that might not only occur on some Blocklists, but also can be blocked as the result of regex blacklists for starting with "tracking". The domain should be whitelisted to ensure the Tracking Protection can be updated (when used at all), or it might render some websites useless on the Firefox Webbrowser in the long run.
pihole -w tracking-protection.cdn.mozilla.net

#Playstation 5 "Recently Played Games" and Trophies
#pihole -w telemetry-console.api.playstation.com

#Cannon Printers
#To be able to retrieve firmware updates
#pihole -w gdlp01.c-wss.com