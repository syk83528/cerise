'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "favicon.ico": "7ffd1bda059c23223087b8d1e1f12447",
"version.json": "432108ee1b2e6284d1b679825e8e25b1",
"manifest.json": "8718638e8bcedfe6127d136b45c4e81c",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"main.dart.js": "7ba2a47979d2ea53d0b9166ff29185e4",
"favicon.png": "5deb661393341d0e381e844a6feb0699",
"index.html": "6f09720eed1d335613d3f02de1e31205",
"/": "6f09720eed1d335613d3f02de1e31205",
"AgoraRtcWrapper.bundle.js": "1716058f7ffb19330bc88e34561f7981",
"splash/img/light-1x.png": "594f7778227da45232ca2660ad2538ba",
"splash/img/dark-1x.png": "594f7778227da45232ca2660ad2538ba",
"splash/img/light-3x.png": "63a51a8a7ae05020b5d5dd777734761d",
"splash/img/light-4x.png": "ba5862cf9cd7d7df93b1a83b5cf8b2f9",
"splash/img/dark-2x.png": "8fb0bf7e0594d3d8f5d67d482a1e9cba",
"splash/img/dark-4x.png": "ba5862cf9cd7d7df93b1a83b5cf8b2f9",
"splash/img/light-2x.png": "8fb0bf7e0594d3d8f5d67d482a1e9cba",
"splash/img/dark-3x.png": "63a51a8a7ae05020b5d5dd777734761d",
"splash/style.css": "64227ec06c71fef909f75868ada72c30",
"assets/FontManifest.json": "cbff676e3ce6e987ce4986e475172fab",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/AssetManifest.json": "de7e0493f0063b14315a87b4a063bb22",
"assets/assets/data/json/terms.json": "7f3d54f8bdcbc4aed31b6403999f2039",
"assets/assets/data/json/rules.json": "d41d8cd98f00b204e9800998ecf8427e",
"assets/assets/data/json/privacy.json": "c86cdd59a07e289c98a507e2ba15c3b0",
"assets/assets/data/text/privacy.md": "359cbfd315aca102b18141efae929c65",
"assets/assets/data/text/terms.md": "1030012170a835f5eedc5b2dced39c94",
"assets/assets/data/text/rules.md": "171c37ba5a2978d345214098fd2fb9c3",
"assets/assets/icons/instagram.png": "9a6d4130d74e26bfd7a910ed874e3ddb",
"assets/assets/icons/google.png": "40d2486592f6008f02ba37e73c9b4b90",
"assets/assets/icons/msg.png": "f938ecc1f5336e1c7a87f4a8d44d0b9a",
"assets/assets/icons/share.png": "afbc2532f0f24196662057b7b4910338",
"assets/assets/icons/github.png": "b6c3feda8bee7828fd6ddfabf61a6f61",
"assets/assets/icons/setting.png": "e73bea40037466ae36112c8e71bb2822",
"assets/assets/icons/scan.png": "cdc6624ea8054da331555683187277ba",
"assets/assets/icons/text.png": "877d1c4fbafe3d703409844f6bfc34ba",
"assets/assets/fonts/girl.ttf": "9ec32d7786fecee1cd6d4f77f009e858",
"assets/assets/images/login/4.webp": "9550a777df63d3432ffc299528e39c13",
"assets/assets/images/login/5.webp": "ea31a7c6a04c8a08596e439b0683c417",
"assets/assets/images/login/0.webp": "ec9accea3000420b3b4832bc7391f2c1",
"assets/assets/images/login/3.webp": "6ff9c5a8a2bfa15e296eb0643d35a161",
"assets/assets/images/login/2.webp": "0f0edcc40f22cbeaa7aa7d44b2225ae0",
"assets/assets/images/login/1.webp": "b455367431197bd4a3277b5d786d17b9",
"assets/assets/images/wechatop.png": "3310f6fafe1ec51ae505aa880cecbe78",
"assets/assets/images/login.jpg": "6e98deab93918bf6393d9f97dbc4f857",
"assets/assets/images/empty.png": "dddcac94febb4bf495de076a02a07cf2",
"assets/assets/images/scan/photo.png": "c199b4dc22f7963a4d5eeb3efe1718cc",
"assets/assets/images/scan/qrcode.png": "658e00df983d13d9fa9fe07f41737b98",
"assets/assets/raw/logo.ico": "7ffd1bda059c23223087b8d1e1f12447",
"assets/assets/raw/logo.svg": "6aec0dd36408bbb24fa5130f15b1630b",
"assets/assets/raw/logo.png": "5deb661393341d0e381e844a6feb0699",
"assets/NOTICES": "d9183607fbcba6637b8effe137618069",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/wakelock_web/assets/no_sleep.js": "7748a45cd593f33280669b29c2c8919a"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
