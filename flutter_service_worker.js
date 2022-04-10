'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "main.dart.js": "6c2cfc8f73bb73d44552c119df3cc4e0",
"index.html": "df5aac2088d4ab531bcee473eff685e7",
"/": "df5aac2088d4ab531bcee473eff685e7",
"splash/img/light-2x.png": "1adeb19139194df7282f4e2cda6b8bc3",
"splash/img/dark-4x.png": "7c929acf0896e430bc7f33fbb5aef2d2",
"splash/img/dark-3x.png": "38786244a197f0581b547ec9e816e0f7",
"splash/img/light-1x.png": "9fbc374edcd88465f53b3ce19b520a5d",
"splash/img/dark-1x.png": "9fbc374edcd88465f53b3ce19b520a5d",
"splash/img/dark-2x.png": "1adeb19139194df7282f4e2cda6b8bc3",
"splash/img/light-4x.png": "7c929acf0896e430bc7f33fbb5aef2d2",
"splash/img/light-3x.png": "38786244a197f0581b547ec9e816e0f7",
"splash/style.css": "06f5dff802dfdbfd8af404da5f49afa4",
"splash/splash.js": "c6a271349a0cd249bdb6d3c4d12f5dcf",
"assets/fonts/MaterialIcons-Regular.otf": "7e7a6cccddf6d7b20012a548461d5d81",
"assets/AssetManifest.json": "ba7f13247f2679216031e9314e9ace1b",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/assets/logo-compact.png": "cc8c2744e82530c075b7b0bfaf0ee805",
"assets/assets/images/10.jpg": "cd3c199c6c9da671091e591f0f2d664e",
"assets/assets/images/8.jpg": "62315a3e01c8e52990d891595a0f7ac9",
"assets/assets/images/7.jpg": "a3f1b7133947dd3ec60a43016bb1ec82",
"assets/assets/images/11.jpg": "f1a9d69c522f523282fcfca32f4a1a50",
"assets/assets/images/6.jpg": "257c8da3fa13ed8a5661d6844d32ff74",
"assets/assets/images/9.jpg": "82fae4ccc6fcd880270dbc1da5483d0c",
"assets/assets/images/4.jpg": "462a4cb9c4990f8eb765a7889187d835",
"assets/assets/images/3.jpg": "fddb0ac7022777c8ccd2b2bd8f3862a3",
"assets/assets/images/2.jpg": "27bb3eae0099bf42be592428d04c54cb",
"assets/assets/images/5.jpg": "20b99f87af84585be2d491904ded32fd",
"assets/assets/images/1.jpg": "e295586276cf2fb56a1959603251df58",
"assets/assets/initial%2520data/comments.json": "84e398f958acdcf23dcdaf72f15debac",
"assets/assets/initial%2520data/tags.json": "764c8bf485a4e82b8dccc7ddb6040f3f",
"assets/assets/initial%2520data/posts.json": "564f28dafac820973b0e86646cc84268",
"assets/assets/initial%2520data/vacancy.json": "968deafe1304828b45966cbfd3b04f91",
"assets/assets/initial%2520data/categories.json": "2fc3bcb7f5dfc4f9d7dfe0d3336703a9",
"assets/assets/initial%2520data/users.json": "0fda7b8cc320e1cd48c587e79c86cbb2",
"assets/assets/avatars/roman.png": "75dbfad71cbcf7e490ae752b9d3f04d8",
"assets/assets/avatars/alena.png": "cc5f6a4ef1df8a554a9dfdf3a4308b2a",
"assets/assets/avatars/panfilova.png": "2cefa8008fbc68e143c915872457188a",
"assets/assets/logo.png": "b512c442b244cc8c2786b1b083b03b51",
"assets/NOTICES": "88dc132717d685e6fbb53e0795f8ab94",
"icons/Icon-maskable-192.png": "cc8c2744e82530c075b7b0bfaf0ee805",
"icons/Icon-192.png": "cc8c2744e82530c075b7b0bfaf0ee805",
"icons/Icon-512.png": "cc8c2744e82530c075b7b0bfaf0ee805",
"icons/Icon-maskable-512.png": "cc8c2744e82530c075b7b0bfaf0ee805",
"manifest.json": "e57f720d3ed7509c29a7f2b2635b2505",
"version.json": "8f51ee0731f95b34e69ebf7351b6e982",
"favicon.ico": "255d238d054fbf5d2764f5cf1b41d3c1",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba",
"canvaskit/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487"
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
