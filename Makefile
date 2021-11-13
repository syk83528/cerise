.PHONY: android androidv icon splash deploy msix


android:
	@flutter build apk --target-platform android-arm64 --split-per-abi

androidv:
	@flutter build apk --target-platform android-arm64 --split-per-abi -v

icon:
	@flutter pub run flutter_launcher_icons:main

splash:
	@flutter pub run flutter_native_splash:create

deploy:
	@flutter build web -v
	cd ./build/web && git add . && git commit -m "deploy" && \
	git push -f origin main
# 	git init && git add . && git commit -m "deploy" && git branch -M main && \     
#	git remote add origin https://github.com/mocaraka/mocaraka.github.io.git && \

msix:
	@flutter build windows -v
	@flutter pub run msix:create