'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "favicon.ico": "7ffd1bda059c23223087b8d1e1f12447",
"canvaskit/canvaskit.js": "43fa9e17039a625450b6aba93baf521e",
"canvaskit/profiling/canvaskit.js": "f3bfccc993a1e0bfdd3440af60d99df4",
"canvaskit/profiling/canvaskit.wasm": "a9610cf39260f60fbe7524a785c66101",
"canvaskit/canvaskit.wasm": "04ed3c745ff1dee16504be01f9623498",
"main.dart.js": "bfc99755f6c4f89bf341a8e898aa53a7",
"version.json": "34f981b63a716c4748de2d46e32c3da6",
"splash/img/light-4x.png": "ba5862cf9cd7d7df93b1a83b5cf8b2f9",
"splash/img/dark-3x.png": "63a51a8a7ae05020b5d5dd777734761d",
"splash/img/dark-2x.png": "8fb0bf7e0594d3d8f5d67d482a1e9cba",
"splash/img/light-3x.png": "63a51a8a7ae05020b5d5dd777734761d",
"splash/img/dark-1x.png": "594f7778227da45232ca2660ad2538ba",
"splash/img/light-1x.png": "594f7778227da45232ca2660ad2538ba",
"splash/img/dark-4x.png": "ba5862cf9cd7d7df93b1a83b5cf8b2f9",
"splash/img/light-2x.png": "8fb0bf7e0594d3d8f5d67d482a1e9cba",
"splash/style.css": "64227ec06c71fef909f75868ada72c30",
"manifest.json": "8718638e8bcedfe6127d136b45c4e81c",
"AgoraRtcWrapper.bundle.js": "1716058f7ffb19330bc88e34561f7981",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"assets/NOTICES": "facd959c799370b2452a1d602cf5c177",
"assets/AssetManifest.json": "e83e619657175473fb5c8b0f5a249fa0",
"assets/FontManifest.json": "cbff676e3ce6e987ce4986e475172fab",
"assets/assets/images/scan/qrcode.png": "658e00df983d13d9fa9fe07f41737b98",
"assets/assets/images/scan/photo.png": "c199b4dc22f7963a4d5eeb3efe1718cc",
"assets/assets/images/empty.png": "dddcac94febb4bf495de076a02a07cf2",
"assets/assets/images/login/2.webp": "f312bb6c9f65d28417afe9db78eacf71",
"assets/assets/images/login/5.webp": "d33b9bd06a9e2bbda3e3693aec5a2ee4",
"assets/assets/images/login/0.webp": "6dbe79fc3f63d59ca241e95f6801bd76",
"assets/assets/images/login/1.webp": "a03f91abf5c0e0c23a621d76cfefc419",
"assets/assets/images/login/3.webp": "3e307dfc2447dcbc44a26a89e4427b4c",
"assets/assets/images/login/4.webp": "6ab7e6e0e32476acd8b8c19047a0f1ce",
"assets/assets/images/wechatop.png": "3310f6fafe1ec51ae505aa880cecbe78",
"assets/assets/images/login.jpg": "6e98deab93918bf6393d9f97dbc4f857",
"assets/assets/data/text/privacy.md": "359cbfd315aca102b18141efae929c65",
"assets/assets/data/text/rules.md": "171c37ba5a2978d345214098fd2fb9c3",
"assets/assets/data/text/terms.md": "1030012170a835f5eedc5b2dced39c94",
"assets/assets/data/json/rules.json": "d41d8cd98f00b204e9800998ecf8427e",
"assets/assets/data/json/terms.json": "7f3d54f8bdcbc4aed31b6403999f2039",
"assets/assets/data/json/privacy.json": "c86cdd59a07e289c98a507e2ba15c3b0",
"assets/assets/icons/heart_fill.png": "8ce3de4b6984abc66a8625b073b744cf",
"assets/assets/icons/text.png": "877d1c4fbafe3d703409844f6bfc34ba",
"assets/assets/icons/heart.png": "9db8a403d36b3d40a04797f121a6a46d",
"assets/assets/icons/star_fill.png": "6d5c63614dfac4b27a0b32a609c9ce43",
"assets/assets/icons/emoji/20.png": "f7fcaa5d590731a8b248e05b5d84e324",
"assets/assets/icons/emoji/29.png": "8b2da0ac03379e10c281e744220a415c",
"assets/assets/icons/emoji/12.png": "bf65a5a9adda4094b84431e645b84054",
"assets/assets/icons/emoji/33.png": "339daf2d64a9abc8005011ee5e807c93",
"assets/assets/icons/emoji/22.png": "c9a5fafd43790337e9073bab5ea242c3",
"assets/assets/icons/emoji/1.png": "abbe4672fbdb81fef95908097877fe2b",
"assets/assets/icons/emoji/19.png": "910d1e7729b1d0a25542170da1bf1b94",
"assets/assets/icons/emoji/21.png": "83a55d58c66110a6aaa62795ed0584ab",
"assets/assets/icons/emoji/9.png": "76b56cae3f5943f814ccb3f48954cdc5",
"assets/assets/icons/emoji/7.png": "b9e49643e1c324471991df30c6885194",
"assets/assets/icons/emoji/31.png": "15c5276b932ec85d702e31a75b001935",
"assets/assets/icons/emoji/16.png": "a18ace616c3ef804f03eceb9f8cca136",
"assets/assets/icons/emoji/3.png": "5c2aaa11785f9520a1e589212628e6af",
"assets/assets/icons/emoji/5.png": "30fefeb30dae1ef28ef1b21c65563b77",
"assets/assets/icons/emoji/37.png": "02a2ab9dfee70d288a3d7d98247fea22",
"assets/assets/icons/emoji/11.png": "8e462a1b372a31466cd0dcdb1582e52a",
"assets/assets/icons/emoji/28.png": "98987ca47de2ce5b7d28011e2b3babcd",
"assets/assets/icons/emoji/30.png": "7e1c0a6711fb794832c82f11d773a764",
"assets/assets/icons/emoji/18.png": "fb27fe1f5eaa238efb8e8f2112f66ae3",
"assets/assets/icons/emoji/24.png": "96646a4a5b00fa36e094a0624d27a675",
"assets/assets/icons/emoji/36.png": "90f46c173ce3faac0cff8d36ccefd1ea",
"assets/assets/icons/emoji/13.png": "f5bd8b3b84f511091efc74018241bdae",
"assets/assets/icons/emoji/26.png": "c0ddbf23ee9b3d212910b9bec9efd83d",
"assets/assets/icons/emoji/6.png": "7728af19b49348c4a155800c476bfa4a",
"assets/assets/icons/emoji/27.png": "556e125321c8a24b157459cc69a6feb1",
"assets/assets/icons/emoji/34.png": "75f414e188ab71ec80c660d4f276773c",
"assets/assets/icons/emoji/4.png": "c1ce262276bc16c50550fecf9b27975d",
"assets/assets/icons/emoji/38.png": "cbf92114d8a9c17ebd01188809ca31a1",
"assets/assets/icons/emoji/0.png": "123d28aa8089ab23bcb36d9ed63da42c",
"assets/assets/icons/emoji/2.png": "10da4f84a33879b678b95ff452c76c56",
"assets/assets/icons/emoji/39.png": "0c5e9062b29d9558e37ff52c59046350",
"assets/assets/icons/emoji/8.png": "3e3055e69ce51d61b90bcd2e0bfc2ec8",
"assets/assets/icons/emoji/14.png": "ced7cf5300804cfd9d47db68678697c4",
"assets/assets/icons/emoji/25.png": "81d3c3684b3e5e5b3f064d21075675b1",
"assets/assets/icons/emoji/17.png": "f2ada0c612eebd5058bba1130817c558",
"assets/assets/icons/emoji/15.png": "2228e78ecac679cfecbb09f3b3364ffa",
"assets/assets/icons/emoji/35.png": "ca58a53b783f5ff63580efc4a3d8db35",
"assets/assets/icons/emoji/23.png": "4ae025b9a4e8da2f94f968d7e3a66519",
"assets/assets/icons/emoji/10.png": "e4ba37c18ad3e0895fa4f4432a5bd452",
"assets/assets/icons/emoji/32.png": "ce8e3df8fc1d09a935c8f09beca284bd",
"assets/assets/icons/instagram.png": "9a6d4130d74e26bfd7a910ed874e3ddb",
"assets/assets/icons/share.png": "afbc2532f0f24196662057b7b4910338",
"assets/assets/icons/msg.png": "f938ecc1f5336e1c7a87f4a8d44d0b9a",
"assets/assets/icons/github.png": "b6c3feda8bee7828fd6ddfabf61a6f61",
"assets/assets/icons/message.png": "8952257eaef1bf2ccae2dfda6cc41c06",
"assets/assets/icons/star.png": "637be0b5cc65e8680d183dc642a900cf",
"assets/assets/icons/google.png": "40d2486592f6008f02ba37e73c9b4b90",
"assets/assets/icons/input/emoji.png": "a55731571800e3c49b4f031d99436fac",
"assets/assets/icons/input/at.png": "ea8a5424bec6ee2afd4d6269c65ae566",
"assets/assets/icons/input/keyboard.png": "8e9675c416971200d8637185a28d51e2",
"assets/assets/icons/scan.png": "cdc6624ea8054da331555683187277ba",
"assets/assets/icons/setting.png": "e73bea40037466ae36112c8e71bb2822",
"assets/assets/fonts/girl.ttf": "9ec32d7786fecee1cd6d4f77f009e858",
"assets/assets/raw/logo.png": "5deb661393341d0e381e844a6feb0699",
"assets/assets/raw/logo.ico": "7ffd1bda059c23223087b8d1e1f12447",
"assets/assets/raw/logo.svg": "6aec0dd36408bbb24fa5130f15b1630b",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/packages/wakelock_web/assets/no_sleep.js": "7748a45cd593f33280669b29c2c8919a",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"index.html": "ff5929b90b9c577f0135ecb63cd7398e",
"/": "ff5929b90b9c577f0135ecb63cd7398e",
"favicon.png": "5deb661393341d0e381e844a6feb0699"
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
